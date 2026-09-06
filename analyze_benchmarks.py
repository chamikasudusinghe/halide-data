import re
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
import csv

RESULT_DIR = Path("results_benchapp")
# MODES = ["halideAdams2019", "customAdams2019Random", "customAdams2019TopkFarthest", "customAdams2019TopkFarthestRandom"]
MODES = ["halideAdams2019", "customAdams2019Random", "customAdams2019TopkFarthestRandom", "customAdams2019topkFarthestRandomE24"]

RUNTIME_RE = re.compile(r"Runtime for .*?: ([\d.]+)")
COMPILE_RE = re.compile(r"Compilation time: (\d+)")
BENCH_RE = re.compile(r"Benchmarking time: (\d+)")

def parse_log(filepath):
    """Return list of runtimes (converted from sec → ms)."""
    with open(filepath) as f:
        text = f.read()
    runtimes = [float(x) * 1000 for x in RUNTIME_RE.findall(text)]
    compile_times = [float(x) for x in COMPILE_RE.findall(text)]
    bench_times = [float(x) for x in BENCH_RE.findall(text)]

    total_compile = np.sum(compile_times)
    total_bench = np.sum(bench_times)

    return runtimes, total_compile, total_bench

TRIAL_RE = re.compile(r"^trial(\d+)$", re.IGNORECASE)

def split_log_name(stem):
    """Split a log file stem into (benchmark, mode, trial).

    Accepts both "<bench>_<mode>.log" and "<bench>_<mode>_trial<N>.log";
    trial is None for the former.
    """
    parts = stem.split("_")
    trial = None
    m = TRIAL_RE.match(parts[-1])
    if m is not None and len(parts) > 2:
        trial = int(m.group(1))
        parts = parts[:-1]
    bench = "_".join(parts[:-1])
    mode = parts[-1]
    return bench, mode, trial

def collect_data():
    """Collect runtime stats per benchmark and mode.

    A (benchmark, mode) pair may have several trial logs; each trial's runtimes
    are averaged and the trial with the *minimum* average runtime is kept. The
    per-trial stats are kept alongside it under "trials".
    """
    trials = {}
    for log_file in RESULT_DIR.glob("*.log"):
        bench, mode, trial = split_log_name(log_file.stem)
        if mode not in MODES:
            continue
        runtimes, compile_time, bench_time = parse_log(log_file)
        if not runtimes:
            continue
        trials.setdefault(bench, {}).setdefault(mode, []).append({
            "mean": np.mean(runtimes),
            "std": np.std(runtimes),
            "count": len(runtimes),
            "compile_time": compile_time,
            "bench_time": bench_time,
            "trial": trial,
        })

    data = {}
    for bench, modes in trials.items():
        for mode, mode_trials in modes.items():
            mode_trials.sort(key=lambda s: (s["trial"] is None, s["trial"]))
            best = min(mode_trials, key=lambda s: s["mean"])
            data.setdefault(bench, {})[mode] = {
                **best,
                "n_trials": len(mode_trials),
                "trials": mode_trials,
            }
    return data

def normalize_data_to_max(data):
    """Normalize each benchmark’s runtimes relative to its slowest (max) mean runtime."""
    norm_data = {}
    for bench, modes in data.items():
        vals = [v["mean"] for v in modes.values() if not np.isnan(v["mean"])]
        compile_times = [v["compile_time"] for v in modes.values() if not np.isnan(v["compile_time"])]
        bench_times = [v["bench_time"] for v in modes.values() if not np.isnan(v["bench_time"])]

        if not vals:
            continue
        max_val = max(vals)
        max_c = max(compile_times)
        max_b = max(bench_times)
        norm_data[bench] = {
            m: {
                "mean": v["mean"] / max_val,
                "std": v["std"] / max_val,
                "count": v["count"],
                "compile_time": v["compile_time"]/max_c,
                "bench_time": v["bench_time"]/max_b,
            }
            for m, v in modes.items()
        }
    return norm_data

def generate_trial_table(data):
    """Report every (benchmark, strategy, trial) runtime, before the min is taken."""
    header = [
        "Benchmark", "Strategy", "Trial", "Avg Runtime (ms)", "Std (ms)",
        "Samples", "Compile Time (s)", "Bench Time (s)", "Min",
    ]
    rows = []
    for bench in sorted(data.keys()):
        for mode in MODES:
            stats = data[bench].get(mode)
            if stats is None:
                continue
            best_mean = min(t["mean"] for t in stats["trials"])
            for t in stats["trials"]:
                rows.append([
                    bench,
                    mode,
                    "-" if t["trial"] is None else t["trial"],
                    t["mean"],
                    t["std"],
                    t["count"],
                    t["compile_time"],
                    t["bench_time"],
                    "*" if t["mean"] == best_mean else "",
                ])

    path = Path("analysis_results_benchapp") / "runtime_trials_table.csv"
    with open(path, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)

    print("\n=== Per-Trial Runtime Table (ms, * = min used in plots) ===")
    table = [header] + [
        [f"{c:.3f}" if isinstance(c, (float, np.floating)) else str(c) for c in r]
        for r in rows
    ]
    widths = [max(len(r[i]) for r in table) for i in range(len(header))]
    fmt = "  ".join(f"{{:<{w}}}" for w in widths)
    for r in table:
        print(fmt.format(*r))

def generate_tables(data):
    """Generate tables of un-normalized values for runtimes, compile time, and bench time."""
    benchmarks = sorted(data.keys())

    runtime_rows = []
    compile_rows = []
    bench_rows = []

    header = ["Benchmark"] + MODES

    for bench in benchmarks:
        runtime_row = [bench]
        compile_row = [bench]
        bench_row = [bench]

        for mode in MODES:
            stats = data[bench].get(mode, {})
            runtime_row.append(stats.get("mean", np.nan))
            compile_row.append(stats.get("compile_time", np.nan))
            bench_row.append(stats.get("bench_time", np.nan))

        runtime_rows.append(runtime_row)
        compile_rows.append(compile_row)
        bench_rows.append(bench_row)

    tables = {
        "runtime_table.csv": runtime_rows,
        "compile_table.csv": compile_rows,
        "bench_table.csv": bench_rows,
    }

    for filename, rows in tables.items():
        path = Path("analysis_results_benchapp") / filename
        with open(path, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(header)
            writer.writerows(rows)

    # Also print nicely in terminal
    print("\n=== Runtime Table (ms) ===")
    print(header)
    for r in runtime_rows:
        print(r)

    print("\n=== Compile Time Table (s) ===")
    print(header)
    for r in compile_rows:
        print(r)

    print("\n=== Benchmark Time Table (s) ===")
    print(header)
    for r in bench_rows:
        print(r)

def plot_runtimes(data, normalized=False):
    """Plot grouped bar chart with error bars for std deviation."""
    benchmarks = sorted(data.keys())
    x = np.arange(len(benchmarks))

    fig, ax = plt.subplots(figsize=(10, 6))
    # colors = ["#f5c518", "#1d3557", "#2a9d8f"]
    colors = ["#f5c518", "#1d3557", "#2a9d8f", "#abcdef"]
    n_modes = len(MODES)
    group_width = 0.8          # total width reserved for one benchmark group
    width = group_width/n_modes
    # bar_width = group_width / n_modes

    for i, mode in enumerate(MODES):
        offset = (i - (n_modes - 1) / 2) * width
        means = [data[b].get(mode, {}).get("mean", np.nan) for b in benchmarks]
        stds = [data[b].get(mode, {}).get("std", 0) for b in benchmarks]
        ax.bar(
            x + offset,
            means,
            width,
            label=mode,
            color=colors[i],
            yerr=stds,
            capsize=5,
            alpha=0.9,
        )

    ylabel = "Runtime (normalized to max = 1)" if normalized else "Average Runtime (ms)"
    title = "Benchmark Runtime Comparison" + (" (Normalized to Max)" if normalized else "")
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    ax.set_xticks(x)
    ax.set_xticklabels(benchmarks, rotation=20, ha="right")
    ax.legend()
    ax.grid(axis="y", linestyle="--", alpha=0.6)

    plt.tight_layout()
    suffix = "_normalized_max" if normalized else ""
    plt.savefig(f"analysis_results_benchapp/avg_runtime{suffix}.png", dpi=200)
    plt.show()

def plot_compile_times(data, normalized=False):
    """Plot grouped bar chart with error bars for std deviation."""
    benchmarks = sorted(data.keys())
    x = np.arange(len(benchmarks))

    fig, ax = plt.subplots(figsize=(10, 6))
    colors = ["#f5c518", "#1d3557", "#2a9d8f", "#abcdef"]

    n_modes = len(MODES)
    group_width = 0.8          # total width reserved for one benchmark group
    width = group_width/n_modes 

    for i, mode in enumerate(MODES):
        offset = (i - (n_modes - 1) / 2) * width
        compile_times = [data[b].get(mode, {}).get("compile_time", np.nan) for b in benchmarks]
        # stds = [data[b].get(mode, {}).get("std", 0) for b in benchmarks]
        ax.bar(
            x + offset,
            compile_times,
            width,
            label=mode,
            color=colors[i],
            capsize=5,
            alpha=0.9,
        )

    ylabel = "Total Compilation times (normalized to max = 1)" if normalized else "Total Compile time (s)"
    title = "Benchmark Compile Time Comparison" + (" (Normalized to Max)" if normalized else "")
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    ax.set_xticks(x)
    ax.set_xticklabels(benchmarks, rotation=20, ha="right")
    ax.legend()
    ax.grid(axis="y", linestyle="--", alpha=0.6)

    plt.tight_layout()
    suffix = "_normalized_max" if normalized else ""
    plt.savefig(f"analysis_results_benchapp/total_compile{suffix}.png", dpi=200)
    plt.show()

def plot_bench_times(data, normalized=False):
    """Plot grouped bar chart with error bars for std deviation."""
    benchmarks = sorted(data.keys())
    x = np.arange(len(benchmarks))

    fig, ax = plt.subplots(figsize=(10, 6))
    # colors = ["#f5c518", "#1d3557", "#2a9d8f"]
    colors = ["#f5c518", "#1d3557", "#2a9d8f", "#abcdef"]
    n_modes = len(MODES)
    group_width = 0.8          # total width reserved for one benchmark group
    width = group_width / n_modes 

    for i, mode in enumerate(MODES):
        offset = (i - (n_modes - 1) / 2) * width
        bench_times = [data[b].get(mode, {}).get("bench_time", np.nan) for b in benchmarks]
        ax.bar(
            x + offset,
            bench_times,
            width,
            label=mode,
            color=colors[i],
            capsize=5,
            alpha=0.9,
        )

    ylabel = "Total benchmarking time (normalized to max = 1)" if normalized else "Total Benchmarking time (s)"
    title = "Total Benchmark time Comparison" + (" (Normalized to Max)" if normalized else "")
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    ax.set_xticks(x)
    ax.set_xticklabels(benchmarks, rotation=20, ha="right")
    ax.legend()
    ax.grid(axis="y", linestyle="--", alpha=0.6)

    plt.tight_layout()
    suffix = "_normalized_max" if normalized else ""
    plt.savefig(f"analysis_results_benchapp/total_bench{suffix}.png", dpi=200)
    plt.show()

if __name__ == "__main__":
    data = collect_data()

    print("=== Benchmark Summary (Mean ± Std, in ms) ===")
    for bench, modes in data.items():
        print(f"\n{bench}:")
        for mode, stats in modes.items():
            trial_info = f", best of {stats['n_trials']} trials"
            if stats["trial"] is not None:
                trial_info += f" (trial {stats['trial']})"
            print(
                f"  {mode:10s}: {stats['mean']:.3f} ± {stats['std']:.3f} ms "
                f"({stats['count']} samples{trial_info})"
            )

    # Plot absolute runtimes with variance
    # plot_data(data, normalized=False)

    # Normalized (max=1) runtimes with variance
    norm_data = normalize_data_to_max(data)
    plot_runtimes(norm_data, normalized=True)
    # plot_compile_times(norm_data, normalized=True)
    # plot_bench_times(norm_data, normalized=True)

    plot_runtimes(data, normalized=False)
    # plot_compile_times(data, normalized=False)
    # plot_bench_times(data, normalized=False)

    generate_trial_table(data)
    generate_tables(data)
