import torch

module = torch.jit.load("intermediate_weights_halide.pt", map_location="cpu")
module.save("intermediate_weights_halide_cpu.pt")
