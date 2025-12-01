---
layout: page
title: Solving PDEs with Neural Networks
date: 2025-05-12
excerpt: Physics-Informed Neural Networks approach to solving the 1D heat equation by minimizing PDE residuals and initial condition losses.
math: true
links:
  paper: /assets/docs/PINN_Attempt1.pdf
---

## Overview
This project uses Physics-Informed Neural Networks (PINNs) to solve the 1D heat equation, a classic partial differential equation (PDE). The neural network learns to approximate the solution by minimizing the residual of the PDE and the initial condition loss simultaneously.

## Methodology
- Defined the PDE and initial conditions: $u_t = 9u_{xx}, \quad u(x, 0) = e^{-x^2}$
- Constructed a fully connected neural network with differentiable activation functions using PyTorch.
- Used automatic differentiation to compute spatial and temporal derivatives.
- Trained the model using the Adam optimizer to minimize combined PDE and initial condition loss functions.
- Compared the PINN output with the exact solution and observed a close match at time $t = 0.25$.
