---
layout: page
title: A Mathematical Description of Transformers via Kronecker Products
date: 2025-12-01
excerpt: A mathematical reformulation of the Transformer architecture using Kronecker products, revealing attention as a separable linear operator across sequence and feature dimensions.
math: true
links:
  paper: /assets/docs/Transformers_Kronecker.pdf
---

## Overview
This project provides a **mathematical formulation** of the **Transformer** architecture. We reformulate the self-attention mechanism using the **Kronecker product**, revealing how attention can be viewed as a separable but coupled linear operator acting across both the **sequence** and **feature** dimensions.

## Key Contributions
- Derived a **simplified transformer model** that isolates attention as a purely linear map without MLPs, biases, or normalization.
- Formulated attention as $\mathrm{Attn}(X) = X + W_O \, \mathrm{softmax}((W_Q X)(W_K X)^\top) W_V X$.
- Proved that attention can be compactly represented as a single Kronecker operator $(A \otimes (W_O W_V)) X$, where $A$ governs token interactions and $W_O W_V$ acts across feature space.
- Presented **algebraic proofs** for key Kronecker identities, including the mixed-product property and matrix equivalence $MXN = (I \otimes M)(N^\top \otimes I)X$.
- Interpreted this formulation as a step toward **mechanistic interpretability**, linking matrix structure to functional behavior in transformers.

## Significance
This work bridges **deep learning** and **linear algebra**, showing that complex neural computations can often be expressed as elegant tensor products, a step toward understanding the mathematical essence of attention.
