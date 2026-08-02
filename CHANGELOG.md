# Changelog

## 2026-08-02

### `random_pipeline_generator.cpp`: unrolled 2D convolutions no longer ignore the output channel

`convolve2D_unrolled()` fully unrolls the input channels (`coords[2] = c` for a
literal `c`), so nothing in the generated expression referred to the output
channel argument `args[2]`. The resulting Func was channel-invariant.

That is fatal when the Func's only consumer uses it as a channel index, which
is exactly what `slice()` does. Inlining the convolution constant-folds the
index expression away; every Func feeding that index loses its last consumer.
Those orphans are still in the environment and still get a realize/produce node
from `ScheduleFunctions`, but `BoundsInference` derives bounds from consumers,
so they end up with no bounds lets at all and codegen dies on the undefined
symbol (`Symbol not found`, `CodeGen_LLVM.cpp`). Whether it blew up depended on
the schedule the autoscheduler happened to pick, so it only showed up with some
cost-model weights.

Each tap is now weighted by `weights(c, i, j, args[2])`, the same approach
`convolve2D_r()` and `convolve2D_w()` already use, so the result genuinely
varies with the output channel. `random_expr()` verifies that every tap survives
into the final expression (falling back to a plain sum if not), so the
dependence cannot be optimized away.

Two notes:

- `set_upcast_types()` is deliberately *not* called here, unlike in the
  reduction-based variants: it consumes RNG values, which would shift the
  seed-to-pipeline mapping for every seed. The multiply stays in the input type,
  so the RNG stream is unchanged and existing seeds still produce the same
  pipeline structure - only the convolution's values differ.
- Bool-valued taps are promoted to the weight type (`uint8`) before multiplying,
  since bool cannot be multiplied. This is the one case where a seed's
  downstream types change.

### `random_pipeline_generator.cpp`: aggregation stages no longer reduce over a size-1 dimension

`aggregation_stage()` picked a reduction dimension at random. When that
dimension had extent 1 (e.g. dimension 2 of a single-channel stage), the
reduction coordinate `clamp(args[d] + r, 0, extent - 1)` became `clamp(x, 0, 0)`,
which `simplify()` folds to a constant - taking the RVar with it. `sum()`,
`argmin()` and `argmax()` then rejected the expression with
`Expression passed to sum must reference a reduction domain`, and pipeline
construction failed outright. Pipeline seed 15 at 20 stages hit this.

The stage now redirects to the largest dimension when the chosen one has extent
1, and skips the aggregation entirely in the degenerate case where no dimension
can be reduced over. `rand_int()` consumes one RNG value however wide its range
is, so the window size still lands on the same call index and the RNG stream is
unchanged; only its value differs when the dimension was swapped.

Note that this failure is *not* caused by `random_expr()`'s single-attempt loop:
`aggregation_stage()` passes it exactly one input, so the "all inputs used"
check can never fail there and the retry path is never entered. Raising the
attempt count does not fix it (verified), and would shift later choices within
the same stage chunk for controlled-RNG runs.

### Tests

Added `test_conv2d_unrolled.cpp` and `test_conv2d_unrolled.sh` covering both
fixes. See the README for how to run them.
