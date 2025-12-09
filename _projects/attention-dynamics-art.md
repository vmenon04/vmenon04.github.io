---
layout: page
title: Attention Dynamics Art
date: 2025-11-04
excerpt: Cool plots created from a dynamical system inspired by self-attention mechanisms.
math: true
links:
  paper: /assets/docs/Attention_Dynamics_Art.pdf
---

As part of some research I was doing, I was reading a paper about the mathematics of transformers {% cite geshkovski2025mathematicalperspectivetransformers %}. In it, they define transformers as a dynamical system, formulated as follows:

$$
\dot{x}_i(t) = P^{\perp}_{x_i(t)}\!\left( 
    \frac{1}{Z_{\beta,i}(t)} 
    \sum_{j=1}^{n} 
        e^{\beta \langle Q(t)x_i(t), K(t)x_j(t)\rangle}
        V(t)x_j(t)
\right),\quad Z_{\beta,i}(t) = \sum_{k=1}^{n} e^{\beta \langle Q(t)x_i(t), K(t)x_k(t)\rangle}
$$

where $P^{\perp}_{x_i(t)}y = y - \langle x_i(t), y \rangle x_i(t)$ denotes the orthogonal projection onto the tangent space of the sphere at $x_i(t)$.

I was interested in the "convergence" of these dynamics, that is, if I input a $n$ points, do they all eventually end up at one value? To test this, I made some simplifications:

Let $d = 2$ be the dimension, $n = 20$ the number of points, and $T = 100$ the number of iterations. We will set $W_K(a,b)$ as a matrix with $a$ and $b$ on the diagonal and randomize $W_Q, W_V$. Then, initialize $X^{(0)}(a,b) = [x^{(0)}_1, \dots, x^{(0)}_n]^\top \in \mathbb{R}^{n\times d}$ with random unit vectors. At each iteration $t = 0, 1, \dots, T-1$, we will "evolve" the system as follows:

$$
\begin{aligned}
Q^{(t)} &= X^{(t)} W_Q^\top, & K^{(t)}(a,b) &= X^{(t)} W_K(a,b)^\top, & V^{(t)} &= X^{(t)} W_V^\top, \\
S^{(t)} &= Q^{(t)} K^{(t)\top}, & A^{(t)} &= \mathrm{softmax}(S^{(t)}), & X^{(t+1)} &= A^{(t)} V^{(t)},
\end{aligned}
$$

and then we normalize

$$
x^{(t+1)}_i \leftarrow \frac{x^{(t+1)}_i}{\|x^{(t+1)}_i\|_2}
$$

After doing so, we create a plot with the values of $a$ on the x-axis and the values of $b$ on the y-axis. If they covnerge, we color them white, else, black. It turns out that this process creates some super cool plots. See them below! Also, read the paper if you're more interested in the details.

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

---

## References

{% bibliography --cited %}


