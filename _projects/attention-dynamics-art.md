---
layout: page
title: Attention Dynamics Art
date: 2025-11-04
excerpt: Generative art created from a minimal dynamical system inspired by self-attention mechanisms, producing intricate fractal patterns from algebraic interactions.
math: true
links:
  paper: /assets/docs/Attention_Dynamics_Art.pdf
---

## Abstract

We explore a minimal dynamical system inspired by the mathematical structure of self-attention in neural networks {% cite vaswani2023attentionneed %}. Despite its simple linear-algebraic formulation, the system produces intricate and highly structured visual patterns when its parameters are varied. Each image represents the convergence landscape of this dynamical map across a two-dimensional parameter space, revealing emergent order arising from purely algebraic interactions. Our work is inspired by recent mathematical frameworks that treat self-attention as a dynamical interacting system {% cite geshkovski2025mathematicalperspectivetransformers %}.

## Mathematical Formulation

Let $d = 2$ be the dimension, $n = 20$ the number of points, and $T = 100$ the number of iterations. For each parameter pair $(a,b) \in [r_{\min}, r_{\max}]^2 = [-8,8]^2$, define:

$$
W_K(a,b) = \begin{pmatrix} a & 0 \\ 0 & b \end{pmatrix}, \qquad W_Q, W_V \in \mathbb{R}^{d \times d}
$$

as fixed random matrices. Initialize $X^{(0)}(a,b) = [x^{(0)}_1, \dots, x^{(0)}_n]^\top \in \mathbb{R}^{n\times d}$ with random unit vectors:

$$
\|x^{(0)}_i\|_2 = 1 \quad \forall i.
$$

At each iteration $t = 0, 1, \dots, T-1$, the system evolves according to an attention-like mapping:

$$
\begin{aligned}
Q^{(t)} &= X^{(t)} W_Q^\top, & K^{(t)}(a,b) &= X^{(t)} W_K(a,b)^\top, & V^{(t)} &= X^{(t)} W_V^\top, \\
S^{(t)} &= Q^{(t)} K^{(t)\top}, & A^{(t)} &= \mathrm{softmax}(S^{(t)}), & X^{(t+1)} &= A^{(t)} V^{(t)},
\end{aligned}
$$

followed by per-row normalization:

$$
x^{(t+1)}_i \leftarrow \frac{x^{(t+1)}_i}{\|x^{(t+1)}_i\|_2 + \varepsilon}, \quad \varepsilon = 10^{-8}.
$$

This iterative rule defines a nonlinear dynamical system on $(\mathbb{S}^{d-1})^n$. The softmax interaction couples all points through pairwise similarities determined by $W_Q$ and $W_K(a,b)$.

### Convergence Landscape

After $T$ iterations, convergence is measured via:

$$
\Delta(a,b) = \max_i |x^{(T)}_{i,1} - x^{(T)}_{1,1}|
$$

and a binary label is assigned:

$$
L(a,b) = \begin{cases} 1, & \text{if } \Delta(a,b) < 10^{-5},\\ 0, & \text{otherwise} \end{cases}
$$

Plotting $L(a,b)$ over the $(a,b)$-grid produces a monochrome image. White regions correspond to synchronized convergence, black regions to divergence or oscillatory behavior.

## Methods

Experiments were implemented in `PyTorch` on a NVIDIA Tesla T4 GPU via Google Colab, generating $1500\times1500$-resolution images in under one minute. Each image corresponds to a single random seed determining the initialization of $W_Q$, $W_V$, and $X^{(0)}$.

### Parameter Grid Sampling and Visualization

The $(a,b)$ parameter space is discretized uniformly over $[-8, 8]^2$ with $1500\times1500$ samples. For each grid point $(a,b)$, $W_K(a,b)$ is applied to the same initialized configuration $X^{(0)}$. Grid evaluations are batched and computed in parallel. The binary map $L(a,b)$ is rendered using `matplotlib` with bicubic interpolation and no axes. Pixels with $L(a,b) = 1$ are white, non-convergent regions are black.

## Selected Artworks (Gallery)

Gallery of convergence landscapes. Top left is generated with seed 1 and $W_K = W_Q = I$. The rest are generated with random seeds (left to right, top to bottom): 1679700, 5227590, 6306593, 6549664, 8012376. 

<div class="art-gallery">
  <img src="/assets/images/art1_Large.png" alt="Attention Dynamics Art 1" onclick="openLightbox(this.src)">
  <img src="/assets/images/art1679700_Large.png" alt="Attention Dynamics Art 2" onclick="openLightbox(this.src)">
  <img src="/assets/images/art5227590_Large.png" alt="Attention Dynamics Art 3" onclick="openLightbox(this.src)">
  <img src="/assets/images/art6306593_Large.png" alt="Attention Dynamics Art 4" onclick="openLightbox(this.src)">
  <img src="/assets/images/art6549664_Large.png" alt="Attention Dynamics Art 5" onclick="openLightbox(this.src)">
  <img src="/assets/images/art8012376_Large.png" alt="Attention Dynamics Art 6" onclick="openLightbox(this.src)">
</div>

<div id="lightbox" class="lightbox" onclick="closeLightbox()">
  <span class="lightbox-close">&times;</span>
  <img class="lightbox-content" id="lightbox-img">
</div>

<script>
function openLightbox(src) {
  document.getElementById('lightbox').style.display = 'flex';
  document.getElementById('lightbox-img').src = src;
  document.body.style.overflow = 'hidden';
}

function closeLightbox() {
  document.getElementById('lightbox').style.display = 'none';
  document.body.style.overflow = 'auto';
}

document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    closeLightbox();
  }
});
</script>

## Code Listing

Minimal reference implementation:

```python
import torch
import numpy as np
import matplotlib.pyplot as plt

seed = 1
torch.manual_seed(seed)
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

num_samples = 1500
num_points = 20
num_iterations = 100
range_min, range_max = -8, 8
d = 2

WQ = torch.randn(d, d, device=device)
WV = torch.randn(d, d, device=device)

a_vals = np.linspace(range_min, range_max, num_samples)
b_vals = np.linspace(range_min, range_max, num_samples)
A, B = np.meshgrid(a_vals, b_vals)

ab_grid = torch.tensor(np.stack([A.ravel(), B.ravel()], axis=-1), device=device, dtype=torch.float32)
num_grid = ab_grid.shape[0]

X_grid = torch.randn(num_grid, num_points, d, device=device)
X_grid /= X_grid.norm(dim=-1, keepdim=True)

WK_grid = torch.zeros(num_grid, d, d, device=device)
WK_grid[:, 0, 0] = ab_grid[:, 0]
WK_grid[:, 1, 1] = ab_grid[:, 1]

for _ in range(num_iterations):
    Q = X_grid @ WQ.T
    K = X_grid @ WK_grid.transpose(1, 2)
    V = X_grid @ WV.T
    scores = torch.matmul(Q, K.transpose(1, 2))
    attn = torch.softmax(scores, dim=-1)
    X_grid = torch.matmul(attn, V)
    X_grid = X_grid / (X_grid.norm(dim=-1, keepdim=True) + 1e-8)

# Check convergence
diff_grid = (X_grid[..., 0] - X_grid[:, 0, 0:1]).abs().max(dim=1).values
labels_grid = (diff_grid < 1e-5).int().cpu().numpy().reshape(num_samples, num_samples)

extent = [range_min, range_max, range_min, range_max]
plt.figure(figsize=(5,5))
plt.imshow(labels_grid.T, origin='lower', extent=extent, cmap='gray', interpolation='bicubic', alpha=1.0)
plt.axis('off')
plt.tight_layout()
plt.show()
```

---

## References

{% bibliography --cited %}