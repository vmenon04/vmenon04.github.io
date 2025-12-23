---
layout: page
title: Some Structures in Transformer Architectures
date: 2025-12-09
math: true
excerpt: Representing decoder-only transformers using Kronecker products to reveal interpretable linear algebraic structure and the introducing the phenomenon of superposition in high-dimensional vector spaces.
links:
  paper: /assets/docs/some_structures_in_transformer_architectures.pdf
---

*This project was completed as part of the Budapest Semesters in Mathematics Advanced Directed Reading Program (Autumn 2025), supervised by Attila Jung at Eötvös Loránd University (ELTE).*

## Abstract
Transformer models have become the backbone of modern large language models due to their unprecedented success and state-of-the-art performance across a wide range of tasks. However, their inner workings have remained difficult to interpret. In this project, we present a more interpretable construction of the decoder-only transformer model, focusing on a simplified, attention-only architecture. We show that the self-attention mechanism of a single attention head can be compactly written as a Kronecker product acting on the input embeddings, which highlights the separable nature of attention and provides a framework for interpreting information flow through zero- and one-layer transformers. Finally, we provide a brief introduction to the phenomenon of superposition in high-dimensional vector spaces, highlighting the increasing complexities as these models scale.

## Introduction

The transformer architecture {% cite NIPS2017_3f5ee243 %} has emerged as a foundational neural network model for a wide range of tasks, most prominently in large language models (LLMs) such as OpenAI's GPT series {% cite brown2020languagemodelsfewshotlearners %}. As these models grow in size and complexity, understanding their internal computations becomes increasingly challenging. In particular, transformers can exhibit unexpected, harmful, or otherwise opaque behavior, motivating the need for systematic approaches to interpretability.

To address this, the field of mechanistic interpretability has emerged as a research program that seeks to uncover how individual components of a model, such as attention heads, neurons, or layers, contribute to its overall function. Often, mechanistic interpretability draws on mathematical tools and theory to guide its analysis. Insights from this line of work are crucial not only for improving model transparency, but also for ensuring AI alignment and safety {% cite bereska2024mechanisticinterpretabilityaisafety %}.

In this project, we will explain the framework introduced by Elhage et al. {% cite elhage2021mathematical %} of Anthropic, which provides an introductory mathematical formulation of transformer circuits and decomposes their operations into interpretable linear and nonlinear components. By expressing attention computations in this compact linear algebraic form, we can better analyze how information propagates across sequence positions and embedding dimensions. We then explore the phenomenon of superposition, which helps explain why transformers are so complex in practice and why their strong performance can be difficult to fully understand. This lays the groundwork for mechanistic interpretability in larger models, where interactions across layers and the superposition of features give rise to complex, intertwined behaviors.

## Preliminaries

Before formally describing the transformer architecture, we establish the mathematical objects it operates on and the structural conventions we will assume. Throughout, we restrict attention to decoder-only transformers for simplicity.

### Neural Network Building Blocks

Before the transformer architecture is formalized, there are standard neural-network building blocks contained within it that are worth discussing first.

**Definition (Softmax).** Let $z = (z_1, \dots, z_K) \in \mathbb{R}^K$ be a vector of real numbers. The *softmax function* $\operatorname{softmax} : \mathbb{R}^K \to [0,1]^K$ is defined componentwise by

$$
\operatorname{softmax}(z)_i := \frac{\exp(z_i)}{\sum_{j=1}^{K} \exp(z_j)} \quad \text{for } i = 1, \dots, K.
$$

Note that the output $\operatorname{softmax}(z)$ is a probability vector; all entries are non-negative and sum to 1. Additionally, softmax is invariant under adding a constant to all entries, that is, $\operatorname{softmax}(z + c) = \operatorname{softmax}(z)$ for any $c \in \mathbb{R}^K$.

**Definition (Embeddings).** Let $V$ be the vocabulary. Each token $t \in V$ is associated with an embedding vector $e_t \in \mathbb{R}^d$. A length-$n$ input sequence $(t_1, \dots, t_n)$ is mapped to an embedding matrix $X \in \mathbb{R}^{d \times n}$, constructed by stacking the embedding vectors as columns:

$$
X = \begin{bmatrix} 
| & | & & | \\ 
e_{t_1} & e_{t_2} & \cdots & e_{t_n} \\ 
| & | & & | 
\end{bmatrix}
$$

**Definition (Layer Normalization).** Given a vector $x \in \mathbb{R}^d$, layer normalization computes

$$
\mathrm{LN}(x) = \frac{x - \mu(x)}{\sigma(x)} \cdot \gamma + \beta,
$$

where $\mu(x)$ and $\sigma(x)$ are the mean and standard deviation across coordinates, $\gamma,\beta \in \mathbb{R}^d$ are learned parameters, and the multiplication with $\gamma$ is element-wise. Layer normalization is applied independently to each sequence position.

**Definition (Multilayer Perceptron).** The MLP is a position-wise feed-forward network applied independently to each sequence position:

$$
\mathrm{MLP}(x) = W_2 \,\sigma(W_1 x + b_1) + b_2,
$$

where $\sigma$ is a nonlinearity (e.g., ReLU or GELU). ReLU$(x) = \max(0, x)$ and GELU$(x) = x \cdot \Phi(x)$, where $\Phi(x)$ is the CDF of the standard normal distribution.

In typical transformer architectures, this consists of two linear layers with a nonlinearity in between (like the above). However, in principle, one could stack additional linear layers and nonlinearities to form a deeper position-wise feed-forward network. Note that the MLP mixes information across embedding dimensions but not across sequence positions.

**Definition (Residual Connections).** Given an input $x$ and a sublayer $F$, transformers compute the residual update

$$
x + F(\mathrm{LN}(x)).
$$

Note that here we describe the Pre-LN variant used in modern LLMs, which differs slightly from the Post-LN formulation in the original Transformer paper.

**Definition (Self-Attention Head).** Given an input matrix $X \in \mathbb{R}^{d \times n}$, a single self-attention head is specified by learned projection matrices

$$
W_Q,\, W_K,\, W_V \in \mathbb{R}^{d_k \times d}, \qquad W_O \in \mathbb{R}^{d_k \times d}.
$$

It computes

$$
Q = W_Q X, \qquad K = W_K X, \qquad V = W_V X,
$$

$$
A = \operatorname{softmax}\!\left(\frac{Q^\top K}{\sqrt{d_k}}\right), \qquad H = V A^\top, \qquad \operatorname{Attn}(X) = X + W_O H.
$$

The softmax matrix $A$ introduces the only nonlinearity; all other operations are linear in $X$.

**Definition (Multi-Head Attention).** Let $\operatorname{Attn}_1(X), \dots, \operatorname{Attn}_h(X)$ denote $h$ independent self-attention heads, each with its own learned parameters $(W_Q^{(i)}, W_K^{(i)}, W_V^{(i)}, W_O^{(i)})$. Their outputs are concatenated and linearly combined:

$$
\operatorname{MHA}(X) = X + W_O^{\mathrm{mh}} \big[\, \operatorname{Attn}_1(X)\;\|\;\cdots\;\operatorname{Attn}_h(X) \,\big],
$$

where $W_O^{\mathrm{mh}}$ maps the concatenated output back into $\mathbb{R}^{n \times d}$. Each head attends to a different learned subspace of the embedding.

### Transformer

We now formalize the full decoder-only transformer model used in LLMs. A transformer with $L$ layers, hidden dimension $d$, and $m$ attention heads per layer processes an input $X_0$ using the recurrence

$$
X_{\ell}' = X_\ell + \mathrm{MultiHeadAttn}(\mathrm{LN}(X_\ell)),
$$

$$
X_{\ell+1} = X_\ell' + \mathrm{MLP}(\mathrm{LN}(X_\ell')).
$$

Each layer alternates between attention and MLP blocks, each preceded by layer normalization and wrapped in residual connections. The output of the final layer $X_L$ is passed into an unembedding matrix $W_\text{out}$ followed by a softmax to produce token logits:

$$
\mathrm{logits} = \text{softmax}(X_L W_\text{out}^{\top}).
$$

In the context of text generation, the procedure below is what is typically followed:

**Algorithm (Text Generation in a Decoder-Only Transformer).**
- **Input:** Initial token sequence $(t_1,\dots,t_n)$
- **Parameters:** Embedding matrix $E$, transformer $T(\cdot)$, unembedding matrix $W_{\text{out}}$
- **Output:** Generated sequence $(t_1,\dots,t_{n+k})$

1. Convert the input tokens to embeddings: $X_0 = \begin{bmatrix} E[t_1] \\ \vdots \\ E[t_n] \end{bmatrix}$

2. For step $j = n+1$ to $n+k$:
   - Compute hidden states: $X_L = T(X_0)$.
   - Extract the final position's logits: $\ell = (X_L W_{\text{out}}^{\top})_{j-1}$.
   - Convert logits into a probability distribution: $p = \operatorname{softmax}(\ell)$.
   - Sample the next token: $t_j \sim p$.
   - Append $t_j$ to the sequence and update $X_0$ by concatenating $E[t_j]$.

For a more complete description of the standard transformer, we refer the reader to Vaswani et al {% cite NIPS2017_3f5ee243 %} and Brown et al. {% cite brown2020languagemodelsfewshotlearners %}.

### Simplified Transformer

To isolate the mathematical structure of attention and reduce architectural complexity, we introduce a *simplified transformer model*, in which feedforward networks, normalization, multiple heads, and scaling factors are omitted, leaving only the linear self-attention operation. This model captures the essential behavior of attention while removing nonlinearities that complicate analysis.

In particular, we make the following assumptions:

1. **No MLPs:** We omit MLPs to isolate attention dynamics.
2. **Linear maps only:** All affine transformations are linear; biases can be absorbed by augmenting input vectors with a constant component.
3. **No layer normalization:** Normalization can be approximately absorbed into adjacent linear maps.
4. **Single attention head and no scaling:** We drop the $\sqrt{d_k}$ factor and restrict to a single head.

**Definition (Simplified Transformer).** Under these assumptions, a single simplified transformer layer is

$$
\mathrm{Attn}(X) = X + W_O A(X), \quad A(X) = \mathrm{softmax}\big( (W_Q X)^\top(W_K X) \big) W_V X.
$$

An $L$-layer simplified transformer is the composition

$$
T^{(L)}(X) = T_L \circ T_{L-1} \circ \dots \circ T_1 (X).
$$

This minimal model captures the core structure of self-attention and is sufficient for the Kronecker product formulation discussed in this project.

## Kronecker Product

We leverage the Kronecker product {% cite Graham1981-bs %} operation to express attention matrix computations in a concise and elegant manner.

**Definition (Kronecker Product).** Let $A = [a_{ij}] \in \mathbb{R}^{m \times n}$ and $B \in \mathbb{R}^{p \times q}$. The *Kronecker product* of $A$ and $B$, denoted $A \otimes B$, is defined as

$$
A \otimes B = \begin{bmatrix}
a_{11}B & a_{12}B & \cdots & a_{1n}B \\
a_{21}B & a_{22}B & \cdots & a_{2n}B \\
\vdots  & \vdots  & \ddots & \vdots  \\
a_{m1}B & a_{m2}B & \cdots & a_{mn}B
\end{bmatrix} \in \mathbb{R}^{mp \times nq}.
$$

In words, $A \otimes B$ is the block matrix obtained by replacing each entry $a_{ij}$ of $A$ with the matrix $a_{ij}B$.

**Remark.** When applying Kronecker products to matrices (as opposed to vectors), we interpret them as column-wise operators acting jointly on both dimensions. Concretely, for matrices $P$ and $Q$ of compatible sizes, $(P \otimes Q)$ acts by applying $Q$ along the feature dimension (rows) and $P$ along the sequence dimension (columns). This convention aligns with the identity proved later, and will be used consistently throughout.

**Example.** The following is a brief visual example of the Kronecker Product. Let

$$
A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}, \qquad B = \begin{bmatrix} 0 & 5 \\ 6 & 7 \end{bmatrix}.
$$

Then

$$
A \otimes B = \begin{bmatrix} 1B & 2B \\ 3B & 4B \end{bmatrix} = \begin{bmatrix}
0 & 5 & 0 & 10 \\
6 & 7 & 12 & 14 \\
0 & 15 & 0 & 20 \\
18 & 21 & 24 & 28
\end{bmatrix}.
$$

In fact, there are some elegant properties we can use to further simplify our mathematical formulation of attention.

**Lemma (Mixed-Product Property).** Let $A \in \mathbb{R}^{m \times n}$, $B \in \mathbb{R}^{p \times q}$, $C \in \mathbb{R}^{n \times r}$, and $D \in \mathbb{R}^{q \times s}$. Then

$$
(A \otimes B)(C \otimes D) = (AC) \otimes (BD) \in \mathbb{R}^{mp \times rs}.
$$

*Proof.* We interpret the Kronecker product as a block matrix and compute using block multiplication rules.

By definition,

$$
A\otimes B = \begin{bmatrix}
a_{11}B & a_{12}B & \cdots & a_{1n}B \\
a_{21}B & a_{22}B & \cdots & a_{2n}B \\
\vdots  & \vdots  & \ddots & \vdots  \\
a_{m1}B & a_{m2}B & \cdots & a_{mn}B
\end{bmatrix}, \qquad C\otimes D = \begin{bmatrix}
c_{11}D & c_{12}D & \cdots & c_{1r}D \\
c_{21}D & c_{22}D & \cdots & c_{2r}D \\
\vdots  & \vdots  & \ddots & \vdots  \\
c_{n1}D & c_{n2}D & \cdots & c_{nr}D
\end{bmatrix}.
$$

The $(i,k)$-th block of $(A\otimes B)(C\otimes D)$ is

$$
\big[(A\otimes B)(C\otimes D)\big]_{ik} = \sum_{j=1}^{n} (a_{ij}B)(c_{jk}D) = \sum_{j=1}^{n} a_{ij}c_{jk}(BD) = (AC)_{ik}(BD).
$$

Hence, the result is

$$
(A\otimes B)(C\otimes D) = \begin{bmatrix}
(AC)_{11}(BD) & (AC)_{12}(BD) & \cdots & (AC)_{1r}(BD) \\
(AC)_{21}(BD) & (AC)_{22}(BD) & \cdots & (AC)_{2r}(BD) \\
\vdots & \vdots & \ddots & \vdots \\
(AC)_{m1}(BD) & (AC)_{m2}(BD) & \cdots & (AC)_{mr}(BD)
\end{bmatrix},
$$

which, by definition, equals $(AC)\otimes(BD)$. ∎

**Lemma (Standard Matrix Identity).** For conformable matrices $M, X, N$,

$$
M X N = (I \otimes M)\,(N^\top \otimes I)\,X,
$$

where each Kronecker product acts naturally on the row and column spaces of $X$ as indicated. Equivalently, the combined action of left-multiplying by $M$ and right-multiplying by $N$ is represented by the Kronecker product $N^\top \otimes M$.

*Proof.* We verify that both sides act identically on the standard basis.

Let $E_{ij}$ denote the elementary matrix with a $1$ in position $(i,j)$ and zeros elsewhere. Then any $X$ can be written as $X = \sum_{i,j} X_{ij} E_{ij}$. Hence, it suffices to check the identity for $E_{ij}$.

Compute the left-hand side:

$$
M E_{ij} N = M (e_i e_j^\top) N = (M e_i)(N^\top e_j)^\top.
$$

This produces a rank-one matrix whose columns are scalar multiples of $M e_i$, and whose column scalars are given by entries of $N^\top e_j$.

Now examine the right-hand side. By the defining property of the Kronecker product,

$$
(N^\top \otimes M)\,E_{ij}
$$

acts by the same rule: it multiplies each column of $E_{ij}$ by the corresponding scalar from $N^\top e_j$, and replaces the standard basis vector $e_i$ with its image $M e_i$. Thus, the two expressions coincide entrywise for every $i,j$.

Since the equality holds on all basis elements $E_{ij}$ and both sides are linear in $X$, it holds for all $X$. ∎

**Claim.** Let $X\in\mathbb{R}^{d\times n}$, and let

$$
W_V\in\mathbb{R}^{d_k\times d}, \qquad W_O\in\mathbb{R}^{d\times d_k}, \qquad A\in\mathbb{R}^{n\times n}
$$

be the usual value, output and attention matrices for a single head. Define

$$
V := W_V X \in \mathbb{R}^{d_k\times n}, \qquad R := V A^\top \in \mathbb{R}^{d_k\times n}, \qquad H := W_O R \in \mathbb{R}^{d\times n}.
$$

Then the head output $H$ can be written as a single Kronecker action on $X$:

$$
H = (A \otimes (W_O W_V))\, X
$$

where the operator $A\otimes (W_O W_V)$ acts on matrices by the rule $(P\otimes Q)\,X = Q\,X\,P^\top$. Equivalently (reading the ordinary matrix product),

$$
H = W_O W_V X  A^\top.
$$

*Proof.* First note the three elementary operator identities (all verified column-wise):

- $(I_n\otimes W_V)X = W_V X = V$ (apply $W_V$ to each column of $X$),
- $(A\otimes I_{d_k})V = V A^\top = R$ (mix columns of $V$ according to $A$),
- $(I_n\otimes W_O)R = W_O R = H$ (apply $W_O$ to each column of $R$).

Chaining these three operators gives the representation

$$
H = (I_n\otimes W_O)\,(A\otimes I_{d_k})\,(I_n\otimes W_V)\,X.
$$

Now apply the Mixed-Product Property:

$$
(P_1\otimes Q_1)(P_2\otimes Q_2)=(P_1P_2)\otimes(Q_1Q_2).
$$

Using this twice,

$$
(I_n\otimes W_O)(A\otimes I_{d_k})(I_n\otimes W_V) = (I_n A I_n)\otimes(W_O I_{d_k} W_V) = A\otimes (W_O W_V).
$$

Therefore,

$$
H = (A\otimes (W_O W_V))\,X,
$$

which is exactly the identity. Writing this back in ordinary matrix multiplication yields the equivalent form $H = W_O W_V\, X\, A^\top$, as claimed. ∎

Finally, recall from the Definition (Simplified Transformer) that

$$
\operatorname{Attn}(X) = X + W_O \, \operatorname{softmax}\!\left( (W_Q X)(W_K X)^\top \right) W_V X.
$$

Denoting

$$
A := \operatorname{softmax}\!\left( (W_Q X)(W_K X)^\top \right),
$$

our previous derivation shows that this transformation can be expressed as a single Kronecker operator acting on $X$:

$$
H = (A \otimes (W_O W_V))\,X.
$$

Thus, the complete attention formula can be equivalently written as

$$
\operatorname{Attn}(X) = X + (A \otimes W_O W_V)X,
$$

where $A$ governs interactions across the sequence dimension and $W_O W_V$ acts across the feature dimension. The Kronecker product $(A \otimes W_O W_V)$ therefore captures the separable yet coupled nature of attention, a key mathematical insight for interpretability.


## Virtual Weights and Tensor Representations

While the Kronecker product formulation describes how attention acts on the input matrix $X$, it is often useful to analyze the *effective* linear transformation imposed by a circuit, independent of the specific input sequence. We call these *virtual weights*.

To represent these weights, we lift the smaller weight matrices (which operate on the embedding dimension $d$) into the full sequence space (operating on $n \times d$) using the Kronecker product with the identity matrix.

**Definition (Virtual Weight Construction).** Let $W \in \mathbb{R}^{d \times d}$ be a weight matrix operating on the embedding space. The virtual weight $\tilde{W}$ operating on the full sequence space is given by:

$$
\tilde{W} = I_n \otimes W = \begin{bmatrix}
W & 0 & \dots & 0 \\
0 & W & \dots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \dots & W
\end{bmatrix} \in \mathbb{R}^{nd \times nd}
$$

where $I_n$ is the identity matrix of size $n \times n$. This represents applying the same transformation $W$ locally at every token position.

**Remark (Effective OV Weight).** Using this notation, we can express the effective output-value weight for a specific head $h$ as the Kronecker product of the identity (preserving sequence position) and the OV circuit (processing features):

$$
W_{OV}^{h, \text{eff}} = I_n \otimes \underbrace{(W_O^h W_V^h)}_{\text{OV Circuit}}
$$

This matrix captures the fact that the OV circuit operates on semantic information (embeddings) identically at every position, before the attention pattern moves that information between positions.

## Zero-Layer Transformers

Before analyzing attention, we will first consider the simplest case: a *zero-layer transformer*. This model consists solely of a token embedding and an unembedding, without any attention or feedforward layers. Formally, given a token sequence represented as one-hot vectors, the zero-layer transformer predicts logits as $T = W_U W_E$. Using our Kronecker notation on the full sequence, this operation is:

$$
T_{\text{zero}}(x) = (I_n \otimes W_U W_E) x
$$

**Remark (The Bigram Model).** Since there are no attention layers ($A \otimes \dots$), the model cannot incorporate information from other tokens. The operator $I_n \otimes W_U W_E$ maps each token independently to a prediction for the next token. Thus, a zero-layer transformer acts purely as a bigram model: it predicts $P(t_{i+1} \| t_i)$ based on static statistics of adjacent token pairs.

## One-Layer Attention-Only Transformers

We now introduce a single layer of attention. We claim that one-layer attention-only transformers can be understood as an ensemble of a bigram model and several "skip-trigram" models. Intuitively, this is because each attention head can selectively attend from the present token ("B") to a previous token ("A") and copy information to adjust the probability of possible next tokens ("C").

The goal of this section is to rigorously show this correspondence by converting the raw weights of a transformer into interpretable tables of skip-trigram probability adjustments.

To understand the information flow end-to-end, we look at the full operation of the transformer, mapping one-hot tokens to output logits. We can express this as a composition of three linear operators acting on the sequence space: the Embedding, the Attention Layer, and the Unembedding.

Let $x$ be the input represented as a concatenation of one-hot vectors. The model operation $T(x)$ is:

$$
T(x) = \underbrace{(I \otimes W_U)}_{\text{Unembed}} \cdot \underbrace{\left( (I \otimes I) + \sum_{h=1}^H (A^h \otimes W_O^h W_V^h) \right)}_{\text{Attention Layer}} \cdot \underbrace{(I \otimes W_E)}_{\text{Embed}} \cdot x
$$

Here, $(I \otimes I)$ represents the residual connection (the identity path).

**Proposition (Path Expansion).** We can distribute the terms to see the individual paths. Using the Mixed-Product Property of the Kronecker product ($(P \otimes Q)(R \otimes S) = PR \otimes QS$), we calculate the contribution of each term.

1. **The Direct Path Term:**

$$
(I \otimes W_U) (I \otimes I) (I \otimes W_E) = (I \cdot I \cdot I) \otimes (W_U \cdot I \cdot W_E) = (I \otimes W_U W_E)
$$

2. **The Attention Head Terms:**

$$
(I \otimes W_U) (A^h \otimes W_O^h W_V^h) (I \otimes W_E) = (I \cdot A^h \cdot I) \otimes (W_U \cdot W_O^h W_V^h \cdot W_E)
$$

Combining these gives us the full Path Expansion equation:

$$
T(x) = \underbrace{(I \otimes W_U W_E)x}_{\text{Bigram Path}} + \sum_{h=1}^H \underbrace{(A^h \otimes W_U W_O^h W_V^h W_E)x}_{\text{Skip-Trigram Paths}}
$$

This expansion reveals that the model is a sum of interpretable terms. The direct path ($I \otimes W_U W_E$) corresponds to the Zero-Layer Bigram model derived previously. It fills in "missing gaps" in statistics that require no context. The attention terms, however, capture complex dependencies.

The attention head terms in the path expansion equation involve complex products of matrices. We can separate these into two distinct mechanisms that operate on the vocabulary space.

**Definition (The QK and OV Circuits).** For a head $h$, we define:

1. The Query-Key (QK) Circuit:

$$
W_{QK}^h = W_E^\top W_Q^{h\top} W_K^h W_E \in \mathbb{R}^{n_{\text{vocab}} \times n_{\text{vocab}}}
$$

This matrix governs the attention pattern $A^h$. It determines where the head looks. Each entry describes how much a specific query token wants to attend to a specific key token.

2. The Output-Value (OV) Circuit:

$$
W_{OV}^h = W_U W_O^h W_V^h W_E \in \mathbb{R}^{n_{\text{vocab}} \times n_{\text{vocab}}}
$$

This matrix governs the effect on the logits. It determines what information is transmitted. Each entry describes how observing a specific source token affects the probability of a specific output token.

It is useful to think of the OV and QK circuits separately. The QK circuit is a bilinear function determining which "source" token the present "destination" token attends back to. The OV circuit describes what the resulting effect on the "out" predictions for the next token is.

**Remark (The Frozen Attention Thought Experiment).** One might ask if it is principled to separate them. Consider running the model in two passes. First, run the model and collect the attention patterns $A^h$ (determined solely by the QK circuit). Second, replace the attention mechanism with these "frozen" patterns. This transforms the model into a purely linear function of the tokens governed by the OV circuit. This separation allows us to factorize the non-linear transformer into tractable linear components.

By multiplying out the OV and QK circuits, we contextualize the neural network parameters. Instead of abstract weights, we obtain relationships between tokens. Together, the three tokens involved form a "skip-trigram" of the form:

$$
[\text{source}] \;\dots\; [\text{destination}] \to [\text{out}]
$$

**Theorem (Transformer as an Ensemble).** A one-layer attention-only transformer acts as an ensemble of heuristics.

- The Bigram Model (Direct Path) predicts $B \to C$.
- The Skip-Trigrams (Head Paths) predict that if we are at $B$ and attended to $A$, the next token is likely $C$.

*Proof.* Recall the path expansion equation:

$$
T(x) = (I \otimes W_U W_E)x + \sum_{h=1}^H (A^h \otimes W_{OV}^h)x
$$

To understand the contribution of each term to the logits at position $i$ (predicting token $t_{i+1}$), we analyze the two components separately.

The first term, $(I \otimes W_U W_E)$, is block-diagonal, meaning it operates independently on each position. Consequently, at position $i$, the output depends solely on the input at that same position:

$$
\text{Logits}_{\text{direct}} = W_U W_E \cdot x_i
$$

This mirrors the definition of a Bigram Model, where the probability of the next token relies exclusively on the current token $x_i$, without regard for context.

The second component involves the head paths, where the term $(A^h \otimes W_{OV}^h)$ introduces positional mixing. The output at position $i$ becomes a weighted sum over source positions $j$:

$$
\text{Logits}_{\text{head } h} = \sum_{j \le i} A_{ij}^h \cdot (W_{OV}^h \cdot x_j)
$$

In this formulation, $A_{ij}^h$ represents the source selection mechanism (driven by the QK circuit), while $W_{OV}^h x_j$ governs the information copied from that source (driven by the OV circuit).

Combining these components, the total logit is the sum:

$$
\text{Logits} = \text{Bigram}(x_i) + \sum_{h} \sum_{j} \text{Skip-Trigram}(x_j \to x_i)
$$

Thus, the model structurally functions as an ensemble of these heuristics. ∎

Searching for large entries in the joint $W_{QK}$ and $W_{OV}$ matrices reveals interpretable behavior, such as copying, induction, or simple grammatical completion, as shown in the table below.

**Examples of Skip-Trigrams in One-Layer Transformers:**

| Source Token | Destination Token | Out Token | Example Skip-Trigrams |
|--------------|-------------------|-----------|----------------------|
| "perfect" | "are", "looks", "is" | "perfect", "super", "absolute" | "perfect... are perfect", "perfect... looks super" |
| "large" | "contains", "using", "specify" | "large", "small", "very", "huge" | "large... using large", "large... contains small" |
| "two" | "One", "\n", "has" | "two", "three", "four", "five" | "two... One two", "two... has three" |
| "lambda" | "$\\\\", "}{\\\\" , "+\\\\" | "lambda", "sorted", "operator" | "lambda... $\\\\ lambda", "lambda... +\\\\ lambda" |
| "nbsp" | "&", "\\&", "}&" | "nbsp", "01", "gt", "nbs" | "nbsp... &nbsp", "nbsp... >&nbsp" |
| "Great" | "The", "The", "the" | "Great", "great", "poor" | "Great... The Great", "Great... the great" |

*The QK circuit identifies the Source given the Destination; the OV circuit promotes the Out token given the Source. Reproduced from Elhage et al., 2021. {% cite elhage2021mathematical%}.*

## Beyond a Single Layer

When we extend the model to two or more layers, the mathematical elegance of the independent "Skip-Trigram" paths gives way to significantly higher complexity. In a one-layer model, every head attends to the raw input embeddings. In a two-layer model, however, the heads in Layer 2 attend to a residual stream that is already a linear combination of the input and the outputs of Layer 1. Mathematically, this introduces *composition*. If Layer 1 implements a function $f_1(x)$ and Layer 2 implements $f_2(x)$, the effective path is no longer just a sum of independent heads, but includes composed terms like $f_2(f_1(x))$.

- **Explosion of Paths:** A two-layer model allows for paths where a Layer 2 head acts on the output of a Layer 1 head. This creates "Head-to-Head" circuits.
- **Induction Mechanisms:** Elhage et al. hypothesize that these composed circuits are responsible for more complex behaviors, such as *induction heads*, which allow the model to perform in-context learning by searching for previous occurrences of the current token and copying the token that followed it.

While our simplified formulations above give a clear and compact representation of attention phenomena, it is important to recognize their limitations. Even with one or two layers, attention-only transformers are already significantly simpler than the full models used in practice.

In a standard transformer, multiple layers of attention interact with large feedforward networks (MLPs) at each layer (for instance, a modern transformer like GPT-3 has 96 such layers, alternating between attention blocks and MLP blocks), and residual connections carry information across the network in complex ways. Adding these components back in introduces nonlinearities and interactions that make the behavior of individual neurons and attention heads much harder to interpret.

Nonetheless, studying the linear, attention-only case establishes a foundation: it highlights the core mechanisms by which information flows through attention and how heads interact with embeddings. As we reintroduce MLPs, we encounter phenomena such as *superposition*, where multiple features are represented simultaneously within the same neurons or vector dimensions, further complicating interpretability. Understanding these effects is a key step toward analyzing and reverse-engineering the behavior of larger, more realistic transformers.

## Superposition

To discuss superposition, we must first formalize the notion of neurons, neural networks, and multilayer perceptrons (MLPs). While in the Definition (Multilayer Perceptron) we introduced transformer MLPs as two-layer position-wise feedforward blocks, here we adopt a more general view of an MLP as a sequence of fully connected layers.

A *neuron* is a scalar-valued function $n : \mathbb{R}^d \to \mathbb{R}$ of the form

$$
n(x) = \sigma(w^\top x + b),
$$

where $w \in \mathbb{R}^d$ is the neuron's weight vector, $b \in \mathbb{R}$ is a bias term, and $\sigma$ is a nonlinearity. The weight vector $w$ defines a direction in the representation space, and $n(x)$ measures how strongly the input $x$ aligns with that direction.

A *neural layer* maps an input vector $x \in \mathbb{R}^d$ to an output vector $h \in \mathbb{R}^k$ by applying many such neurons in parallel:

$$
h = \sigma(W x + b),
$$

where $W \in \mathbb{R}^{k \times d}$ is the weight matrix whose rows correspond to individual neurons, and $b \in \mathbb{R}^k$ is a bias vector. Each row of $W$ defines a direction in the layer's representation space, and the layer's output describes how strongly the input aligns with each of these directions.

In deeper networks, layers compose these transformations to build increasingly abstract *features*, which, for our purposes, can be considered as specific directions or subspaces in the activation space that encode meaningful patterns. In large language models, features can align with interpretable semantic directions, such as sentiment or gender associations.

The idea of the *superposition hypothesis* is that neural networks often represent more features than they have neurons. In other words, multiple features can be encoded simultaneously within the same neurons or vector dimensions, allowing the network to efficiently use its limited representational capacity {% cite elhage2022superposition %}.

One reason this strategy is plausible comes from the geometry of high-dimensional spaces. In an $n$-dimensional space, we can only have $n$ vectors that are perfectly orthogonal. However, as the dimensionality grows, it becomes possible to arrange exponentially many vectors that are *almost orthogonal*. Before formalizing the high-dimensional geometry that permits this, we present a concrete toy model demonstrating how $N=5$ features can be compressed into $d=2$ neurons and recovered without error.

**Example (The Pentagon Superposition Network).** We construct a toy neural network that compresses $5$ distinct features into a $2$-dimensional hidden space and then reconstructs them. The network has the form

$$
\hat{x}(x) = \mathrm{ReLU}\!\big(W_2 \,\mathrm{ReLU}(W_1 x + b_1) + b_2\big),
$$

where $W_1 \in \mathbb{R}^{2\times 5}$, $b_1 \in \mathbb{R}^2$, $W_2 \in \mathbb{R}^{5\times 2}$, $b_2 \in \mathbb{R}^5$.

Let $e_1, \dots, e_5$ be the standard basis in $\mathbb{R}^5$. Define five unit vectors in $\mathbb{R}^2$ positioned at the vertices of a regular pentagon:

$$
v_k = \left( \cos\frac{2\pi k}{5},\;\sin\frac{2\pi k}{5} \right), \quad k=1,\dots,5.
$$

We set the encoder weights to contain these vectors as columns:

$$
W_1 = [v_1 \mid \dots \mid v_5].
$$

To ensure the hidden activations remain positive after ReLU, we add a bias

$$
b_1 = \begin{bmatrix}0.82\\ 0.97\end{bmatrix},
$$

so that for every $k$,

$$
h_k := \mathrm{ReLU}(W_1 e_k + b_1) = v_k + b_1 \quad (>0 \text{ entrywise}).
$$

We can then decode using

$$
W_2 = W_1^\top.
$$

Let $\mathbf{1}_5$ be the vector of all ones in $\mathbb{R}^5$. Choose a scalar $\beta = 0.5$ and define the output bias

$$
b_2 = - W_2 b_1 - \beta \mathbf{1}_5,
$$

so that for input $e_k$,

$$
z_k := W_2 h_k + b_2 = W_2 v_k - \beta\mathbf{1}_5,
$$

and the $j$-th coordinate equals

$$
(z_k)_j = \langle v_j,\, v_k\rangle - \beta.
$$

Because

$$
\langle v_k, v_k\rangle = 1 \quad\text{and}\quad \max_{j\neq k} \langle v_j, v_k\rangle = \cos(72^\circ)\approx 0.309 < \beta,
$$

the final ReLU yields

$$
\hat{x}(e_k) = \mathrm{ReLU}(z_k) = 0.5\, e_k.
$$

Thus, the network reliably maps each input basis feature $e_k$ through a $2$-dimensional superposition space and back to a unique, sparsely-decoded output, despite heavy compression:

$$
e_k \;\longmapsto\; v_k \;\longmapsto\; 0.5 e_k.
$$

While the toy model relies on specific geometric arrangements (regular polygons), the phenomenon generalizes to high dimensions via the geometry of random projections. In fact, the following result from Johnson-Lindenstrauss (JL) guarantees that a cloud of points in a high-dimensional space can be projected into a much lower-dimensional space while approximately preserving distances (and therefore angles/correlations). Additionally, it is proven using *random* projections, suggesting that superposition does not require handcrafted algebraic constructions but can instead emerge from standard random weight matrices used in neural network initialization.

**Theorem (Johnson-Lindenstrauss).** Let $0 < \varepsilon < 1$ and let $Z$ be a set of $N$ points in $\mathbb{R}^{n}$. Then there exists a linear map $f: \mathbb{R}^{n} \to \mathbb{R}^{m}$ with

$$
m = O\Big(\frac{\log N}{\varepsilon^2}\Big)
$$

such that for all $x, y \in Z$,

$$
(1-\varepsilon)\|x - y\|_2^2 \le \|f(x) - f(y)\|_2^2 \le (1+\varepsilon)\|x - y\|_2^2.
$$

*Proof.* Let $Z=\\{z^1,\dots,z^N\\}\subset\mathbb{R}^n$ be the given set of points. Fix $0<\varepsilon<1$. Choose independent random vectors $x^1,\dots,x^m\in\mathbb{R}^n$ by letting each coordinate

$$
x^k_\ell \in \left\{\sqrt{\frac{1+\varepsilon}{m}},\ -\sqrt{\frac{1+\varepsilon}{m}}\right\}
$$

with probability $1/2$ each. Define a linear map $f:\mathbb{R}^n\to\mathbb{R}^m$ by

$$
f(z) = \big(z\cdot x^1,\ z\cdot x^2,\ \dots,\ z\cdot x^m\big).
$$

Fix two distinct points $z^i,z^j\in Z$ and set

$$
z := z^i - z^j, \qquad u := f(z^i)-f(z^j)=f(z).
$$

Then

$$
\|u\|_2^2 = \sum_{k=1}^m (x^k\cdot z)^2.
$$

For each $k=1,\dots,m$, define the random variable

$$
X_k := (x^k\cdot z)^2.
$$

Since the coordinates of $x^k$ are independent, mean zero, and satisfy

$$
\mathbb{E}[(x^k_\ell)^2] = \frac{1+\varepsilon}{m},
$$

we get

$$
\mathbb{E}[X_k] = \sum_{\ell=1}^n z_\ell^2\,\mathbb{E}[(x^k_\ell)^2] = \frac{1+\varepsilon}{m}\,\|z\|_2^2.
$$

Thus,

$$
\mathbb{E}[\|u\|_2^2] = \sum_{k=1}^m \mathbb{E}[X_k] = (1+\varepsilon)\|z\|_2^2.
$$

Each $X_k$ depends on a sum of independent $\pm$ variables and is therefore sufficiently concentrated. In particular, there exist constants $c_1,c_2>0$ such that for any $0<\beta<1$,

$$
\Pr\big[\|u\|_2^2 > (1+\beta)(1+\varepsilon)\|z\|_2^2\big] < e^{-c_1\beta^2 m},
$$

$$
\Pr\big[\|u\|_2^2 < (1-\beta)(1+\varepsilon)\|z\|_2^2\big] < e^{-c_2\beta^2 m}.
$$

Therefore, for some constant $c>0$,

$$
\Pr\Big[\big|\|u\|_2^2 - (1+\varepsilon)\|z\|_2^2\big| > \beta(1+\varepsilon)\|z\|_2^2\Big] < e^{-c\beta^2 m}.
$$

There are $\binom{N}{2}$ pairs $(i,j)$. Choose $\beta=\varepsilon/2$. By the union bound, the probability that *any* pair has its squared distance distorted by more than a factor $1\pm\beta$ is at most

$$
\binom{N}{2} e^{-c\varepsilon^2 m /4} \le N^2 e^{-c'\varepsilon^2 m}
$$

(for a possibly different constant $c'>0$). Choose

$$
m \ge \frac{C\log N}{\varepsilon^2}
$$

with $C$ large enough. Then the above probability is $<1$, so there exists a choice of $x^1,\dots,x^m$ such that *all* pairs satisfy

$$
(1-\tfrac{\varepsilon}{2})(1+\varepsilon)\|z^i-z^j\|_2^2 \le \|f(z^i)-f(z^j)\|_2^2 \le (1+\tfrac{\varepsilon}{2})(1+\varepsilon)\|z^i-z^j\|_2^2.
$$

For $0<\varepsilon<1$,

$$
(1-\tfrac{\varepsilon}{2})(1+\varepsilon) \ge 1, \qquad (1+\tfrac{\varepsilon}{2})(1+\varepsilon) \le (1+\varepsilon)^2.
$$

Thus,

$$
\|z^i-z^j\|_2^2 \le \|f(z^i)-f(z^j)\|_2^2 \le (1+\varepsilon)^2\|z^i-z^j\|_2^2.
$$

Taking square roots:

$$
\|z^i-z^j\|_2 \le \|f(z^i)-f(z^j)\|_2 \le (1+\varepsilon)\|z^i-z^j\|_2.
$$

This proves the Johnson-Lindenstrauss lemma for $m = O\left(\frac{\log N}{\varepsilon^2}\right)$. ∎

**Corollary.** Let $Z \subset \mathbb{R}^n$ and $f:\mathbb{R}^n \to \mathbb{R}^m$ be as in the Johnson-Lindenstrauss (JL) theorem. Then for any two distinct nonzero points $x,y \in Z$, let $\theta$ be the angle between $x$ and $y$, and $\theta_f$ the angle between $f(x)$ and $f(y)$. Then

$$
\bigl|\cos\theta_f - \cos\theta\bigr| \le \frac{4\varepsilon}{1-\varepsilon}.
$$

In particular, if $x$ and $y$ are unit vectors,

$$
\bigl|\langle f(x), f(y) \rangle - \langle x, y \rangle \bigr| \le 3\varepsilon.
$$

*Proof.* Assume $x$ and $y$ are unit vectors; the general case follows by normalizing. By the polarization identity,

$$
\langle x, y \rangle = \frac{\|x\|_2^2 + \|y\|_2^2 - \|x-y\|_2^2}{2}, \qquad \langle f(x), f(y) \rangle = \frac{\|f(x)\|_2^2 + \|f(y)\|_2^2 - \|f(x)-f(y)\|_2^2}{2}.
$$

Since JL preserves pairwise distances:

$$
|\|f(x)-f(y)\|_2^2 - \|x-y\|_2^2| \le \varepsilon \|x-y\|_2^2 \le 4\varepsilon
$$

and similarly for $\|x\|^2$ and $\|y\|^2$. Therefore,

$$
|\langle f(x),f(y)\rangle - \langle x,y\rangle| \le 3 \varepsilon.
$$

Finally, using the fact that $\cos \theta_f = \frac{\langle f(x), f(y) \rangle}{\|f(x)\|\|f(y)\|}$ and $\|f(x)\|,\|f(y)\|\in [\sqrt{1-\varepsilon},\sqrt{1+\varepsilon}]$, we get

$$
|\cos\theta_f - \cos\theta| \le \frac{4\varepsilon}{1-\varepsilon}.
$$ ∎

## Conclusion

In this project, we have introduced the Transformer architecture and subsequently simplified it to reveal interpretable, linear algebraic structure that govern how information flows through the network. Without the additional architectural complexities used in practice, such as layer normalization and feed-forward networks, we have shown that the attention mechanism can be compactly represented using the Kronecker product. This notation not only simplifies the algebraic formulation, but also reveals the separable nature of the transformer's operations.

Using this framework, we introduced the "circuit" interpretation of one-layer attention-only transformers. We showed that instead of being considered "black boxes", they can be considered as an ensemble of Bigram and Skip-Trigram heuristics. The Query-Key and Output-Value circuits allow us to read off the model's behavior directly from its weights, identifying how specific tokens attend to and influence one another.

Crucially, however, this interpretability encounters significant issues as model depth increases, leading to a combinatorial explosion of such "circuit" paths. The introduction of MLPs result in the phenomenon of superposition, which allows the network to compress features into low-dimensional subspaces, further obscuring interpretability. While the linear algebraic tools presented here provide a solid foundation, understanding the emergent complexity of deeper, non-linear transformers remains a critical task. Continued research is essential not only for optimizing model performance but for ensuring the transparency and safety of the powerful AI systems increasingly integrated into our society.

---

## References

{% bibliography --cited %}