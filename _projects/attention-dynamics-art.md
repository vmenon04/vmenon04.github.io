---
layout: page
title: Attention Dynamics Art
date: 2025-11-04
excerpt: Generative art created from a minimal dynamical system inspired by self-attention mechanisms, producing intricate fractal patterns from algebraic interactions.
math: true
links:
  paper: /assets/docs/Attention_Dynamics_Art.pdf
---

## Overview
This project explores a minimal **dynamical system** inspired by the mathematical structure of **self-attention** in neural networks. Despite its simple linear-algebraic formulation, the system produces intricate, highly structured visual patterns that emerge from purely algebraic interactions.

## Key Features
- Defined a two-dimensional dynamical map based on attention-like matrix updates over a parameter grid $(a,b) \in [-8,8]^2$.
- Implemented the iterative rule $X_{t+1} = \mathrm{softmax}\left( X_t W_Q^\top (X_t W_K^\top)^\top \right) (X_t W_V^\top)$ with normalization on the unit sphere.
- Generated high-resolution **convergence landscapes** visualizing stable and chaotic regions in the parameter space of $W_K$.
- Observed emergent patterns resembling **organic textures** and **fractal boundaries** between synchronized and divergent regimes.
- Implemented in **PyTorch** with GPU acceleration and full tensor vectorization for efficient image generation.

## Gallery

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
