---
layout: page
title: Advanced Combinatorics Problem Set
course: Taught by András Gyárfás
date: 2025-12-01
excerpt: The course provides a comprehensive introduction to the theory of finite set systems (hypergraphs), exploring both classical foundations and modern developments. Emphasis is placed on fundamental proof techniques, particularly linear algebraic and probabilistic methods, that have shaped contemporary combinatorics.
math: true
---

# Problem Set 1

Theorems used in the set (for reference):

**Theorem 1.2:**
Every simple graph is the intersection graph of some hypergraph.

## Problem 1
Prove the following two properties of linear space (V, E):

- $\sum_{e \in E} \binom{\|e\|}{2} = \binom{\|V\|}{2}$ (global property)
- $\sum_{e \ni v} (\|e\|-1) = \|V\| - 1$ for every $v \in V$ (local property)

**Proof**

We will prove both properties separately.

- **Property 1.** In the first property, the left side counts how many ways we can select two vertices from each edge. This is equivalent to the number of ways we can select two vertices from the graph itself, which is represented in the right side. Thus, $\sum_{e \in E} \binom{\|e\|}{2} = \binom{\|V\|}{2}$.

- **Property 2.** In the second property, the left side goes through every vertex $v$ in the graph and counts how many edges contain it, subtracting one. Note that subtracting one counts the number of *other* vertices are connected to $v$. Since we iterate through unique edges, we ultimately count the total number of vertices, except the first one that we started with. This is the same quantity counted by the right side, thus $\sum_{e \ni v} (\|e\|-1) = \|V\| - 1$ for every $v \in V$.

## Problem 2
Give a catalogue of linear spaces with six vertices. (All planar, follow the convention of Figure 1.6)

**Solution**

[Image: hw1_img.jpeg]
*Catalogue of linear spaces with 6 vertices*

## Problem 3
Prove or give a counterexample for the following two statements. Regular linear spaces are uniform. Uniform linear spaces are regular.

**Proof**

We will provide a counterexample for the first statement and a proof for the second.

- **Statement 1.**
Consider the following linear space $H = (V,E)$ with $V = \{a, b, c, d\}$ and $E = \{\{a,b\},\{b,c,d\},\{a,c,d\}\}$. Note that each vertex has the same degree (2), so the linear space is regular, but each $e \in E$ have different cardinalities, thus, it is not uniform.

- **Statement 2.** Consider $H$ to be a uniform linear space. By definition, all edges in $H$ have the same degree, meaning each edge contains the same number of vertices. Additionally, since $H$ is a linear space, each pair $u,v \in V$ has a unique edge that contains them both. This implies that a vertex $u$ has $\|V\|-1$ vertices it is connected to. Additionally, since every edge has the same amount of vertices, say $n$, then the vertex $u$ shares every edge that it is in (call this quantity $m$) with $n-1$ other vertices. So each vertex $u$ is connected to $m(n-1)$ vertices. So we can equate these two expressions to get $m(n-1)=\|V\|-1$, and thus $m = \frac{\|V\|-1}{n-1}$. So the degree of each vertex is the same, and thus, $H$ is regular.

## Problem 4
Prove Theorem 1.2 by induction.

**Proof**

Let $G=(V_G,E_G)$ be a graph. For the base case, assume this graph has 0 edges, and is thus a set of vertices with no connections. For each vertex in $G$, construct $H=(V_H, E_H)$ such that $V_H = V_G$ and $E_H$ = $\{v_i\}$ for each $v_i \in V_G$. These edges have no intersections, so the intersection of $H$ is $G$.
For our inductive hypothesis, we will assume every graph with $n$ edges is the intersection graph of some hypergraph.
Given a graph $G'$ with $n+1$ edges, remove one edge $e$ to get $G$ with $n$ edges. Then, by our inductive hypothesis, $G$ is the intersection graph of some hypergraph $H$.
To construct $G'$, add a new edge to $H$ whose intersection with other edges corresponds exactly to the new edge $e$ in $G'$.
Thus, every graph can be realized as the intersection graph of some hypergraph.

## Problem 5
Prove Theorem 1.2 using the notion of duality.

**Proof**

Let $G=(V,E)$ be a graph. Then, define $H = \big(E, \{F_v \mid v\in V\}\big)$ where $F_v = \{\,e\in E \mid e is incident to  v\,\}$ for all $v\in V$.
In this construction, $H$ is the dual of $G$. Notice that for any two distinct vertices $u,v\in V$, we have
$F_u\cap F_v\neq \emptyset$ only when there exists $e\in E$ incident to both $u$ and $v$. This happens exactly when $\{u,v\}$ is an edge in $G$. So the intersection graph of the hypergraph $H$ and $G$ are the same.

# Problem Set 2

Theorems used in the set (for reference):

**Theorem 1.4:**
Assume $\mathcal{H} = (\mathcal{V}, \mathcal{E})$ is an intersecting linear space not isomorphic to a trivial one or to a near pencil. Then (for some integer $k \geq 2$)
\[
\|\mathcal{E}\| = \|\mathcal{V}\| = k^2 + k + 1, \quad \mathcal{H} is  (k+1)-uniform and  (k+1)-regular
\]

## Problem 6
Work out the details of the proof of Theorem 1.4

**Proof**

Note that if one edge covers all of $V$, clearly then, $H$ is trivial. If there are two edges $e_1,e_2$ that cover all of $V$, due to the fact that $H$ is linear, they meet at a unique vertex $r$. Additionally, without loss of generality, we know one of the edges, say $e_2$, has size $2$. Then $e_1$ contains all but one vertex, and every other edge is an edge with 2 vertices joining $r$ to a vertex of $e_1$. Thus $H$ is a near-pencil.
Now, we will show that for the case where no 2 edge cover all of $V$, a linear intersecting space $G$ implies that $\|V\|=\|E\|=k^2+k+1$ where $G$ is $(k+1)$-uniform and $(k+1)$-regular. Consider $e_1,e_2 \in E$ and suppose $v \in V$ is a vertex such that $v \notin e_1 \cup e_2$. By the definition of linear spaces, every vertex in $e_1$ must be conected to $v$ by a unique edge, and such an edge must not intersect with both $e_1$ and $e_2$. Thus, there exists a bijection between every vertex $v \in e_1$ to another edge that must contain $v$ and one unique vertex in $e_2$. Note that we cannot have the case where such an edge contains more than one unique vertex from $e_1$ and $e_2$ since it would thus violate the conditions of a linear space by creating 2 edges that contain both vertices in $e_1$ or $e_2$. Therefore, $\|e_1\| = \|e_2\|$, and thus all edges have the same size.
Next, we will show that $d(v)=\|e\|$ for any $e \in E$ and $v \in V$. Suppose $G$ is an intersecting linear space. Choose $e \in E$ and $v \in V$ such taht $v \notin e$. Since $G$ is linear, there must be a unique edge containing $v$ and every other vertex in $e$, and thus, $d(v) \geq \|e\|$. Assume for the sake of contradiction that $d(v) > \|e\|$. This implies that there exists $v_1 \in V$ such that $v_1 \notin e$ and $e_1$ such that $v, v_1 \in e_1$. Note that the fact that the edge containing $v, v_1$ cannot intersect with the edge $e$ without violating the definition of a linear space, and thus, no such extra edge exists and $d(v)=\|e\|$.
Finally, we will show that $G$ being $(k+1)$-uniform and $(k+1)$-regular implies $\|V\|=\|E\|=k^2+k+1$. For every vertex $v$, note that there are $k+1$ edges containing it. Each $k+1$ edges has $k$ vertices contained in it excluding $v$. Thus, there are $k(k+1)$ other vertices. With $v$, there are $k(k+1)+1=k^2+k+1$ vertices, and thus, $\|V\|=\|E\|=k^2+k+1$.

## Problem 7
The Fano plane has cyclic representation: shift the set \{1,2,4\} (by adding 1 to its elements) six times, using arithmetic (mod 7). Find similar representations for the finite plane of order 3 and order 4.

**Solution**

For a finite plane of order $k$, we need to find a subset $S \subset Z_{k^2+k+1}$ with size $k+1$ such that no two ordered pairs in $S$ have the same difference using arithmetic (mod $k^2+k+1$). Instead of guess and check, we will use the following program to find such a subset.

```python
import itertools

k = 3
num = k**2 + k + 1
Z = list(range(num))
for subset in itertools.combinations(Z, k+1):
    diffset = set()
    for i in subset:
        for j in subset:
            if i != j:
                diffset.add((i - j) % num)
    if len(diffset) == num-1:
        print(subset)
        break
```

We find that for order 3, the representation is the set $\{0, 1, 3, 9\}$
and for order 4, the representation is the set $\{0, 1, 4, 14, 16\}$

## Problem 8
Suppose that $\mathcal{H} = (V,\mathcal{E})$ has no singleton edges and $\|e \cap f\| \ne 1$ for all $e,f \in \mathcal{E}$. Prove that in every ordering of $V$ the greedy algorithm colors $V$ with at most two colors. The proof cannot be longer than three sentences!

**Proof**

Suppose for the sake of contradiction that the algorithm uses color with label 3 at a vertex $v$, and thus, there must be edges $e,f$ that contain $v$ with all vertices in $e$ colored with label 1 and all vertices in $f$ colored with label 2. Since there are no singleton edges, $e$ and $f$ have other vertices other than $v$, and they cannot be disjoint since then $e \cap f = \{v\}$, so they meet at some other vertex $u$. But since $u$ is either colored with a 1 or a 2, one of $e$ or $f$ cannot be monochromatic, which is a contradiction.

## Problem 9
Prove that Steiner triple systems have no proper 2-colorings.

**Proof**

Assume for the sake of contradiction that a Steiner triple system of order $k$ has a proper 2-coloring. We will suppose that the two colors are the integer labels 1 and 2.
Without loss of generality, suppose we choose a vertex $a$ with color 1, and let the set of $B$ be the set of vertices colored 2.
Consider all triples containing $a$.
Note that in a proper 2-coloring, each triple containing $a$ would include exactly one vertex that is colored 1. Additionally, every pair of vertices appears exactly in one triple. Thus, for each pair $\{a, b\}$ with $b \in B$, there is a triple containing both $a$ and $b$, and so for each $b \in B$, the triple containing $a$ and $b$ is determined by the pair $\{a, b\}$.
Since each triple containing $a$ contains exactly 2 pairs, and since there are $v-1$ total pairs, $a$ is contained in $\frac{v-1}{2}$ triples. Since $a$ is colored 1, each of these triples must contain exactly one vertex colored 2. Thus, $\|B\| = \frac{v-1}{2}$. Since same argument above applies to any vertex colored 2, supposing that $A$ is the set of vertices colored 1, we have that $\|A\| = \frac{v-1}{2}$. Then the total number of vertices is $\|A\| + \|B\| = \frac{v-1}{2} + \frac{v-1}{2} = v - 1 \neq v$, which is a contradiction. Therefore, no proper 2-coloring exists for a Steiner triple system.

## Problem 10
Prove that finite planes of order at least 3 have proper 2-colorings.

**Proof**

Suppose we have a finite plane of order $k \geq 3$. Within this plane, we have a set of vertices $V$ and edges $E$ each edge contains $e+1 \geq 4$ vertices. We will then color the vertices with labels that are either a 1 or a 2. Suppose we choose an edge $e \in E$ and color one vertex with a 1 and the rest with a 2. Then, if we take any other vertex on $e$ and look at the other edge $f$ that contains it, we can observe that there are $k+1$ vertices on $f$. Thus, there are at least $3$ other uncolored vertices. Choose a vertex on $f$ and give it the color 1, and the rest the color 2. Repeating this process throughout entire finite planes will provide it a proper 2-coloring since every edge intersects our initial edge $e$ at exactly one vertex. Since $k \geq 3$, there are at least 3 additional vertices to color such that the edge contains both colors. Since every new edge contains at least one previously colored vertex, we can always color remaining points to avoid monochromatic edges. Therefore every edge will contain at least one vertex colored with a 1 and one vertex colored with a 2, so we have a proper 2-coloring.

# Problem Set 3

Theorems used in the set (for reference):

**Theorem 3.10:**
There exists a function $f(n)$ with the following property: if $f(n)$ points of the plane are in general position (no three on a line) then there exists $n$ of these points forming the vertices of a convex $n$-\textup{gon}.

## Problem 11
Show that the $n$-element sets of a $(2n+k)$-element ground set can be partitioned into $k+2$ classes so that each class contains pairwise intersecting sets.

**Proof**

Suppose the ground set is $[2n+k]=\{1,2,\dots,2n+k\}$. Consider all $n$-element subsets of $[2n+k]$. To do so, we will define a proper coloring of the Kneser graph $KG(2n+k,n)$ with $k+2$ colors. Then, the color classes pairwise intersecting sets. To perform such a coloring, give color $i$ to every $n$-subset who's smallest element is $i$ for every $i \in [k+1]$. Note that this uses at most $k+1$ colors. Then, give color $k+2$ for all other $n$-subsets. Through this coloring, we have used $k+2$ colors in total. This coloring is a proper coloring since if two $n$-element sets have the same color $i \leq k+1$, then they must have the same minimum element $i$, and so they are not disjoint and thus, cannot be adjacent in the Kneser graph. This means that any set with a color $i \in [k+1]$ is independent in the Kneser graph. Now, note that every $n$-set colored $k+2$ is in the set $\{k+2,k+3\dots,2n+k\}$, which has $2n-1$ elements. Note that any $n$-subset of a $2n-1$-set is intersecting due to the Pigeonhole Principle, and thus, sets colored $k+2$ are also independent in the Kneser graph. We have then colored this Kneser graph with $k+2$ colors, and thus, the $n$-element sets of a $(2n+k)$-element ground set can be partitioned into $k+2$ classes so that each class contains pairwise intersecting sets.

## Problem 12
Let $t$ be a positive integer. Construct a 2-chromatic (bipartite) graph $G$ such that for some ordering of the vertices of $G$, the greedy algorithm uses $t$ colors for coloring $G$.

**Proof**

Suppose $t=2$. Consider a 2 vertex graph with one edge connecting the root to its leaf. For the greedy algorithm, order the leaf before the root. Clearly, we need 2 colors to color $G$ through such a greedy algorithm, which is exactly $t$. For $t=3$, consider two copies of the $t=2$ case, and connect the roots. Order the leafs (vertices with degree 1) before their parents, which are the root in this case. Since one of the roots are are adjacent to both the leafs and the other root, it requires a third unique color, and thus, we need 3 colors to color $G$, which is exactly $t$. Through this process of considering 2 copies of the previous case and connecting the roots, we can construct a tree. Note that for any $t$, if we allow the roots of two trees of the $t-1$ case to be adjacent by adding an edge between them, we construct another tree who has two "parent" vertices, both of which have the same color when such an edge is added, and thus, requires one of them to adopt a unique color, leading to $t$ colors to color the graph. Note that since we construct trees, the graph $G$ is always bipartite.

## Problem 13
Prove that $R(3,4)=9$

**Proof**

% TODO: Show $R(3,4) \leq 9$ and $R(3,4) \geq 9$
First, note that $R(3,4) \geq 9$. Below is a colored $K_8$ with edges either red or blue. Note that there are no blue colored $K_3$ subgraphs nor red colored $K_4$ subgraphs.
{% raw %}
\begin{center}
\begin{tikzpicture}[scale=2, every node/.style={circle, fill, inner sep=2pt, draw=none}]
\foreach \i/\ang in {1/0,2/45,3/90,4/135,5/180,6/225,7/270,8/315}{
\node (v\i) at (\ang:1.4) {};
}
\foreach \i in {1,...,8}{
\foreach \j in {1,...,8}{
\ifnum\i<\j
\draw[blue, thick] (v\i) -- (v\j);
\fi
}
}
\draw[red, very thick] (v1) -- (v2);
\draw[red, very thick] (v2) -- (v3);
\draw[red, very thick] (v3) -- (v4);
\draw[red, very thick] (v4) -- (v5);
\draw[red, very thick] (v5) -- (v6);
\draw[red, very thick] (v6) -- (v7);
\draw[red, very thick] (v7) -- (v8);
\draw[red, very thick] (v8) -- (v1);
\draw[red, very thick] (v1) -- (v3);
\draw[red, very thick] (v2) -- (v4);
\draw[red, very thick] (v3) -- (v5);
\draw[red, very thick] (v4) -- (v6);
\draw[red, very thick] (v5) -- (v7);
\draw[red, very thick] (v6) -- (v8);
\draw[red, very thick] (v7) -- (v1);
\draw[red, very thick] (v8) -- (v2);
\end{tikzpicture}
\end{center}
{% endraw %}
Thus, $R(3,4) \geq 9$.
Now we shall show that $R(3,4) \leq 9$.

## Problem 14
Show that $2^r < R(\underbrace{3,3,\dots,3}_{r}) \leq 3r!$

**Proof**

First, we will show  $2^r < R(3,3,\dots,3)$. Suppose we have a graph with $r$ vertices. Enumerate each vertex with a binary $r$-digit number. An edge is colored corresponding to the first differing digit between two vertices. Now, consider a triangle ($K_3$) inside of this graph. If 2 vertices differ at position, then the third vertex cannot be enumerated in this way. Since this construction is impossible, we cannot have this binary vertex enumeration, and thus, we must have strictly more than $2^r$ vertices. Thus, $2^r < R(3,3,\dots,3)$ Finally, we will show $R(3,3,\dots,3) \leq 3r!$. Consider the graph with $K_{3r!}$ with $3r!$ vertices. For a first vertex, it must be connected to $3r!-1$ other vertices. Since there are $r$ colors, by the Pigeonhole Principle, each edge is connected to at least $3(r-1)!$ other vertices. Now continue this process by considering another color, which then has $3(r-2)!$ it is connected to. Continue this process until we have $3$ vertices left, which cannot be colored monochromatically without there existing a monochromatic $K_3$, and thus, $R(3,3,\dots,3) \leq 3r!$

## Problem 15
Show that $R_3(n,n)$ is also a good choice for $f(n)$ in Theorem 3.10 (Hint: color a triple of points $\{a,b,c\}$ according to the parity of the number of points inside the triangle $abc$.)

**Proof**

We will show that if $R_3(n,n)$ points of the plane are in general position, then there exists $n$ of these points forming the vertices of a convex $n$-gon. Let $N \in \mathbb{Z}_{>0}$, and consider the set $P=p_1, \dots, p_N$ in general position. Now consider all triples $\{a,b,c\}$ in P and color the triple red if the number of points of $P$ are inside the triangle and is even and blue if odd. If $N \geq R_3(n,n)$, then we know that there is a monochromatic $n$-subset in $P$. We can call this subset $A$. If all triples in $A$ are monochromatic, then no point of $A$ lies in the convex hull of the others, and thus, the $n$ points in $A$ form a convex $n$-gon.

# Problem Set 4

Solutions courtesy of Richard Li.

## Problem 16

**Proof**

We first hope to prove that in every 2-coloring of the edges of the complete bipartite graph $K_{5,5}$ there is a monochromatic $K_{2,2}$.
Suppose our graph is $A \sqcup B = K_{5,5}$ with colors red and blue.
Consider some $v_1 \in A$, and look at the 5 edges leaving $A$. Some color makes up at least three of these edges. Without loss of generality assume it is red. We now have two cases. Either there exists some $v'$ such that two of the vertices connected to $v_1$ with red edges are also connected to $v'$, in which case there is a red $K_{2,2}$, or there is no such vertex. If there is no such vertex $v_2$, this means that for each $v_i \in A$, $i \neq 1$, there are at least two blue edges from the at least three vertices connected to $v_1$ with a red edge. However, see that since $\binom{3}{2} = 3$, at least one choice of two edges must be repeated among two different vertices, $v_i$ and $v_j$, which is a blue $K_{2,2}$ as desired. The same statement is not true for $K_{5,4}$. Consider the following graph:
\begin{center}
\begin{tikzpicture}[scale=2, every node/.style={circle, fill, inner sep=1.5pt, draw=none}]
% Top row (4 vertices)
\node (t1) at (-3/2, 1) {};
\node (t2) at (-1/2, 1) {};
\node (t3) at (1/2, 1) {};
\node (t4) at (3/2, 1) {};
% Bottom row (5 vertices)
\node (b1) at (-2, 0) {};
\node (b2) at (-1, 0) {};
\node (b3) at (0, 0) {};
\node (b4) at (1, 0) {};
\node (b5) at (2, 0) {};
\draw[red] (t1) -- (b3);
\draw[red] (t1) -- (b4);
\draw[red] (t1) -- (b5);
\draw[red] (t2) -- (b1);
\draw[red] (t2) -- (b3);
\draw[red] (t3) -- (b1);
\draw[red] (t3) -- (b2);
\draw[red] (t3) -- (b4);
\draw[red] (t4) -- (b2);
\draw[red] (t4) -- (b5);
\draw[blue] (t1) -- (b1);
\draw[blue] (t1) -- (b2);
\draw[blue] (t2) -- (b2);
\draw[blue] (t2) -- (b4);
\draw[blue] (t2) -- (b4);
\draw[blue] (t3) -- (b3);
\draw[blue] (t3) -- (b5);
\draw[blue] (t4) -- (b1);
\draw[blue] (t4) -- (b3);
\draw[blue] (t4) -- (b4);
\end{tikzpicture}
\end{center}

## Problem 17

**Proof**

We hope to show that $R(p,q) \leq \binom{p+q-2}{p-1}$.
To do so, we use strong induction on $p + q$. For our base case, note that for $p = 1$, $R(1,q) = 1$, and $\binom{1 + q-2}{0} = 1$. The same holds for $q = 1$. So, suppose the inequality holds for all $p',q'$ such that $p' + q' < p + q$.
See that $R(p,q) \leq R(p-1,q) + R(p,q-1)$
where, by our inductive hypothesis
$R(p,q) \leq \binom{p+q-3}{p-2} + \binom{p+q-3}{p-1}.$
Then, since
$\binom{p+q-3}{p-2} + \binom{p+q-3}{p-1} = \binom{p+q-2}{p-1}$
we have that
$R(p,q) \leq \binom{p+q-2}{p-1}$
as desired.

## Problem 18

**Proof**

We hope to prove that $R_3(4,4) \leq 19$.
To do so, we use the identity that
$R_{t+1}(p,q) \leq R_t(R_{t+1}(p-1,q), R_{t+1}(p,q-1))+1.$
So, we have that
$R_{3}(4,4) \leq R_2(R_{3}(3,4), R_{3}(4,3))+1.$
Notably, $R_3(3,4) = R_3(4,3) = 4$ since $K^3\_3$ can simply have a red edge, but $K^3\_4$ must either be monochromatic red, or contain a blue edge which is a monochromatic blue $K_3^3$.
So,
$R_{3}(4,4) \leq R_2(4, 4)+1 = 18 + 1 = 19$
as desired.

## Problem 19

**Proof**

We hope to prove that $R(n) \leq R_3(6,n)$.
To do so, consider the graph $K_{R_3(6,n)}$ and any edge coloring on it, say $C$.
We now construct an edge coloring of $K_{R_3(6,n)}^3$ as follows. We color an edge blue if the corresponding vertices in $C$ form a monochromatic triangle. Otherwise, we color the edge red. See that it is impossible to have a red $K_6$, since this would imply that within 6 vertices, there exists no monochromatic $K_3$ in $C$, which is impossible since $R(3) = 6$.
So, there exists some blue $K^3_n$. See that this must correspond to a monochromatic $K_n$ in our coloring $C$ since if there were two different colors, there would be some red edge.

## Problem 20

**Proof**

We hope to prove that a simple intersecting hypergraph on $n$ vertices has at most $2^{n-1}$ edges.
To see why this is the case, see that we have $2^n$ possible edges, since this is the cardinality of the power set of $[n]$ elements. Then, see if we have some $e \in E$, $e^C \notin E$ since $e \cap e^C = \varnothing$.
Hence, since every element has a unique complement, we can have at most half the $2^n$ possible edges, which is $2^{n-1}$.

# Problem Set 5

## Problem 21
Assume that $n \geq 3r!$. Prove that every $r$-coloring of the numbers in $[n]$ there is $x,y,z \in [n]$ such that they have the same color and $x+y=z$ ($x=y$ is permitted).

**Proof**

Consider the complete graph $K_{n+1}$ on vertices $V = \{0, 1, 2, \dots, n\}$.
For each pair of vertices $\{i, j\}$ with $i < j$, color the edge $\{i, j\}$ by the color assigned to the integer $j - i$ in the given coloring of $[n]$. This defines an $r$-coloring of the edges of $K_{n+1}$. Next, note that from HW \#14, we know that $R(3,\dots,3 ($r$ times)) \le 3r! \le n+1$. By the definition of the Ramsey number, every $r$-coloring of the edges of $K_{n+1}$ must contain a monochromatic triangle. Let the vertices of this monochromatic triangle be $a < b < c$.
Since the triangle is monochromatic, all three edges $\{a, b\}$, $\{b, c\}$, and $\{a, c\}$ have the same color. From the way we colored the edges, this means that the three differences $b - a, c - b, c - a$ are all assigned the same color in $[n]$. But these satisfy the equation $(b - a) + (c - b) = c - a$. Thus, if we set $x = b - a$, $y = c - b$, and $z = c - a$, then $x, y, z \in [n]$ are of the same color and satisfy $x + y = z$.

## Problem 22
Prove that the vertices of any transitive tournament $T_n$ can be labeled with $1,2,\dots,n$ so that each edge is oriented from a smaller label to a larger label.

**Proof**

We will proceed by induction. For the base case $n=1$, the statement is trivial. For the inductive hypothesis, assume that the statement holds for some $n-1 \geq 1$. Now let $T_n$ be a transitive tournament on $n$ vertices. Note that a transitive tournament does not contain cycles, and thus has a "start" vertex (a source) and an "end" vertex (a sink) (Note: For a transitive tournament $T$, pick any vertex $x$. If $x$ is not a source, then there exists a vertex $u_1 \to x$. If $u_1$ is not a source, then there exists a $u_2 \to u_1$ and so on. Because the tournament does not contain a cycle, this sequence must terminate, and thus, we must reach a vertex with no incoming edges, which is the source. Similarly, there exists a vertex with no outgoing edges, which is the sink.). Now, let $v_{min}$ be the source and let $v_{max}$ be the sink. Consider removing the sink to yield $T_n - v_{max}$, which is still a transitive tournament on $n-1$ vertices. By our inductive hypothesis, we can label the vertices $T_n - v_{max}$ with labels $1, \dots, n-1$ such that all edges go from smaller to larger labels. Now if we put $v_{max}$ back, all edges can go into it, and thus we can assign  $v_{max}$ the largest label $n$, preserving the property that every edge goes from smaller to larger label. By induction, the claim holds for all $n \geq 1$. Thus, the vertices of any transitive tournament $T_n$ can be labeled with $1,2,\dots,n$ so that each edge is oriented from a smaller label to a larger label.

## Problem 23
Prove that every tournament has a king: a vertex where any other vertex can be reached by a directed path with at most two edges.

**Proof**

Let $v$ be a vertex of maximum outdegree (the number of vertices with an incoming edge from $v$) in the tournament. Let $d$ be this outdegree. Define the set $\Gamma(v) = \{u : v \to u\}$ as the set of all vertices that have an incoming edge from $v$. Clearly, $\|\Gamma(v)\| = d$. Suppose, for the sake of contradiction, that there is a vertex $w$ that is not reachable from $v$ by any path of length $\leq 2$. That means the edge $v \to w$ does not exist and thus $w \to v$ exists, and no vertex $u \in \Gamma(v)$ has the edge $u \to w$ and thus for every $u \in \Gamma(v)$, we have $w \to u$. Therefore, $w$ has directed edges to $v$ and to every vertex in $\Gamma(v)$, and so the outdegree of $w$ is at least $d+1$. This contradicts the fact that $v$ is a vertex of maximum outdegree $d$. Thus, no such $w$ exists and every vertex is at distance at most $2$ from $v$, implying that $v$ is a king.

## Problem 24
A tournament is called *strong* if there is a directed path from any vertex to any other. Prove that any strong tournament has a directed Hamiltonian cycle.

**Proof**

First, we will show that every tournament on $n$ vertices has a Hamiltonian path. We proceed by induction on the number of vertices $n$. For the base case $n = 1$ the statement is trivial. For the inductive step, suppose that every tournament on $n-1$ vertices has a Hamiltonian path. Let $T$ be a tournament on $n$ vertices, and remove an arbitrary vertex $v$. By the induction hypothesis, $T - v$ has a Hamiltonian path $P = u_1 \to u_2 \to \cdots \to u_{n-1}$. Now insert $v$ into this path. If $v \to u_1$, then $v \to u_1 \to u_2 \to \cdots \to u_{n-1}$ is a Hamiltonian path of $T$. Otherwise, there exists an index $i$ with $u_i \to v$ and $v \to u_{i+1}$. Then $u_1 \to \cdots \to u_i \to v \to u_{i+1} \to \cdots \to u_{n-1}$ is a Hamiltonian path of $T$. Such an $i$ must exist since each pair of vertices is connected in exactly one direction. Thus, every tournament on $n$ vertices has a Hamiltonian path.
Now, let $T$ be a strong tournament, and let $P = v_1 \to v_2 \to \cdots \to v_n$ be a Hamiltonian path (which we showed above). If $v_n \to v_1$ is an edge, then $v_1 \to v_2 \to \cdots \to v_n \to v_1$ is already a Hamiltonian cycle. Otherwise, assume $v_1 \to v_n$. Since $T$ is strong, there exists a directed path from $v_n$ back to $v_1$: $v_n = w_0 \to w_1 \to \cdots \to w_k = v_1$. Let $w_j$ be the first vertex on this path that also belongs to the Hamiltonian path $P$. Then $w_j = v_i$ for some $1 \le i \le n-1$. The edge entering $v_i$ on the path above is $w_{j-1} \to v_i$. Now, one of the two edges $v_{i-1} \to w_{j-1}$ or $w_{j-1} \to v_{i-1}$ must exist in $T$. In either case, we can connect the paths together to obtain a directed cycle containing all vertices: $v_1 \to \cdots \to v_{i-1} \to w_{j-1} \to \cdots \to v_n \to v_1$. Thus, $T$ contains a directed Hamiltonian cycle.

## Problem 25
Assume (a real life situation) that "knowing each other" is not necessarily symmetric. Prove that at a party of nine persons one can always find either three strangers (no one knows any other) or three persons A,B,C such that A knows B and C and B knows C (a transitive triple). Show that the statement is not true for eight persons.

**Proof**

First, consider $R(3,4) \leq 9$. Suppose we utilize the colors white and black and an unoriented graph. Here, we know that any coloring of $K_9$, there exists a monochromatic (white) triangle ($K_3$) or a monochromatic (black) "complete square" ($K_4$). Consider each vertex as a person and white edges as "not knowing each other" and black edges as "knowing each other". Clearly, at a party of nine persons, there are three strangers who do not know each other (due to the existence of the white triangle). Additionally, there are four strangers that are part of a "complete square" ($K_4$). Consider the four vertices of this clique $\{a,b,c,d\}$. To prevent transitivity, we will construct cycles. Orient $a \to b \to c \to a$. Next, orient $b \to d \to a$. The edge between $c$ and $d$ are now unconnected, but any orientation of $c$ and $d$ (both $c \to d$ and $d \to c$) will result in $\{b,c,d\}$ being a transitive triple. Thus, orienting this 4 vertex clique $K_4$ will always result in a transitive triple.
Now, to show that the statement is not true for eight persons, consider the following graph with $8$ vertices:
{% raw %}
\begin{center}
\begin{tikzpicture}[scale=2,
every node/.style={circle,fill=black,inner sep=2pt},
->,
>=Stealth,
>={Stealth[length=5pt,width=4pt]}  % bigger arrowheads
]
\node (v0) at (0:2cm) {};
\node (v1) at (45:2cm) {};
\node (v2) at (90:2cm) {};
\node (v3) at (135:2cm) {};
\node (v4) at (180:2cm) {};
\node (v5) at (225:2cm) {};
\node (v6) at (270:2cm) {};
\node (v7) at (315:2cm) {};
\foreach \i/\j in {0/2,0/3,1/3,1/4,2/4,2/5,3/5,3/6,4/6,4/7,5/7,5/0,6/0,6/1,7/1,7/2}
\draw[->, shorten >=6pt, shorten <=6pt] (v\i) -- (v\j);
\end{tikzpicture}
\end{center}
{% endraw %}
Here, the arrows denote the "knowing each other" relationship. An arrow from vertex $a$ to vertex $b$ means that person $a$ knows person $b$. Note that there does not exist three strangers nor does there exist a transitive triple.

# Problem Set 6

Theorems used in the set (for reference):

**Theorem 4.14 [Local Lemma]:**
Assume that $A_1, A_2, \dots, A_n$ are events with dependency bound $D$ and $pr(A_i) \leq \frac{1}{4D}$ for $1 \leq i \leq n$. Then

$$ pr \left( \bigcap\limits_{i=1}^{n} \overline{A_i} \right) > 0 $$


**Theorem 4.18:**
$R(n)>m$ if  $4 \binom{n}{2} \binom{m}{n-2} < 2^{\binom{n}{2}-1}$

**Theorem 4.19 [Joke]:**
The graph $K_3$ is $2$-chromatic.

**Proof**

Let $V = [3]$ be the vertex set of triangle $T$. The probability space is the $2$-colorings of $V$ ($N = 8$ elements). Let $A_{ij}$ be the event that the edge $ij$ is monochromatic. Clearly, $pr(A_{ij}) = \frac{1}{2}$ for all the three choices of index pairs. Any pair of events is independent, for example, $pr(A_{12}A_{13})=pr(A_{12})pr(A_{13})=\frac{1}{4}$.

## Problem 26
Assume that $T_n$ is a regular tournament, i.e. $d^+(v)=d^-(v) = \frac{n-1}{2}$ for every vertex $v$. Let $X \cup Y$ be a partition of the vertex set of $T_n$ into two parts. Show that the number of edges from $X$ to $Y$ is the same as the number of edges from $Y$ to $X$.

**Proof**

Let $e(X,Y)$ denote the number of edges directed from $X$ to $Y$, and $e(Y,X)$ the number from $Y$ to $X$. We need to show that $e(X,Y)=e(Y,X)$. For a vertex $v$, let $\Gamma^+\_X(v)$ be the number of out-neighbors of $v$ in $X$, and define $\Gamma^-\_X(v)$, $\Gamma^+\_Y(v)$, $\Gamma^-\_Y(v)$ similarly. Since $T_n$ is regular, $\Gamma^+(v) = \Gamma^-(v)$ for every $v$. Summing over all $v \in X$ gives
$\sum_{v \in X} ( \Gamma^+(v) - \Gamma^-(v) ) = 0$. Splitting each degree into contributions inside $X$ and to $Y$ yields $\sum_{v \in X} ( \Gamma^+\_X(v) - \Gamma^-\_X(v) ) + \sum_{v \in X} ( \Gamma^+\_Y(v) - \Gamma^-\_Y(v) ) = 0$. The first sum is zero because edges entirely inside $X$ contribute $+1$ to one endpoint and $-1$ to the other. The second sum equals $\sum_{v \in X} \Gamma^+\_Y(v) - \sum_{v \in X} \Gamma^-\_Y(v) = e(X,Y) - e(Y,X)$. So, $e(X,Y) - e(Y,X) = 0$, and thus $e(X,Y) = e(Y,X)$.

## Problem 27
Prove that any strong tournament $T_n$ contains a directed cycle $C_k$ for every $3 \leq k \leq n$.

**Proof**

We will proceed inductively. For the base case, assume $k=3$. For the sake of contradiction, suppose that $T_n$ does not contain $C_k$. This implies that the entire tournament is transitive, and by my reasoning from Problem 22, we have a source vertex. However, we assumed that $T_n$ is strong, but there is no vertex that points to the source vertex, a contradiction. Now, assume that the tournament contains a cycle $C_k$ of length $k$ (where $3 \leq k < n$). Let the vertices of the existing cycle be $C_k = v_1 \to v_2 \to \dots \to v_k \to v_1$. Since $k < n$, there exists at least one vertex $u$ that is not in the cycle. There are two possible cases regarding the vertices outside of this cycle. For the first case, assume there exists a vertex $u$ with mixed (Note: $u$ has at least one edge pointing from the cycle to $u$ and at least one edge pointing from $u$ to the cycle.) edges to $C_k$. Because $u$ has both incoming and outgoing edges with the set $\{v_1, ..., v_k\}$, and because we are traversing a cycle, there must be a point where the direction switches. So, there must be an index $i$ such that $v_i \to u$ and $u \to v_{i+1}$, meaning that we can insert $u$ into the cycle between $v_i$ and $v_{i+1}$. This yields a new cycle $v_1 \to \dots \to v_i \to u \to v_{i+1} \to \dots \to v_1$, which is a a cycle of length $k+1$, $C_{k+1}$. For the other case, assume no vertex has "mixed" edges. So, for every vertex $x$ outside the cycle, $x$ either dominates all vertices in $C_k$ or is dominated by all vertices in $C_k$. We can divide the vertices outside the cycle into two sets: $S$ and $T$. Let $S$ be vertices that dominate $C_k$, and let $T$ be the vertices dominated by $C_k$. Note that these sets are nonempty, since otherwise it would violate the fact that $T_n$ is strong. Additionally, since the tournament is strong, there must be a path from $T$ to $S$. This implies there must be at least one edge $t \to s$ where $t \in T$ and $s \in S$. Now we will construct a cycle. Start at $s$ and go to $v_1$ and follow the cycle path $v_1 \to v_2 \to \dots \to v_{k-1}$. Then, go to $t$ and use the edge $t \to s$ to finish back at $s$. This constructs a cycle $s \to v_1 \to v_2 \to \dots \to v_{k-1} \to t \to s$. The length of this cycle is $k+1$, and so we have constructed a cycle $C_{k+1}$. Thus, by induction, any strong tournament $T_n$ contains a directed cycle $C_k$ for every $3 \leq k \leq n$.

## Problem 28
Prove Theorem 4.18 applying Theorem 4.14.

**Proof**

Consider the graph $K_m$. Color each edge red with probability $\frac{1}{2}$ and blue with probability $\frac{1}{2}$. Now, for every $n$ sized subset $i \subset [m]$, let $A_i$ denote the event that $K_n$ is monochromatic. Then, $pr(A_i)$ denotes the probabilty that all $\binom{n}{2}$ edges of $i$ is the same color. Thus, $pr(A_i) = pr(A_i is fully blue ) + pr(A_i is fully red ) = \frac{1}{2}^{\binom{n}{2}} + \frac{1}{2}^{\binom{n}{2}} = 2 \cdot 2^{-\binom{n}{2}} = 2^{1-\binom{n}{2}}$. Now, consider the dependency bound $D$. Two events $A_i$ and $A_j$ are dependent if they share at least one edge (or two vertices). Since we can pick one of $\binom{n}{2}$ edges from $i$ to be the shared edge and one of $\binom{m}{n-2}$ other vertices in $j$, we have that $D \leq \binom{n}{2} \binom{m}{n-2}$ is an upper bound. By the Theorem 4.14 (Local Lemma), we have that if for every $A_i$, $pr(A_i) \leq \frac{1}{4D}$, then $pr( \bigcap_{i=1}^{n} \overline{A_i}) > 0$. That is, if $A_i$, $pr(A_i) \leq \frac{1}{4D}$, then there exists a 2-coloring with no monochromatic $K_n$ in $m$ vertices ($R(n) > m$). Substituting in our values for $pr(A_i)$ and $D$, we have $2^{1-\binom{n}{2}} \leq (4\binom{n}{2} \binom{m}{n-2})^{-1}$, and so, $\binom{n}{2} \binom{m}{n-2} \leq 2^{\binom{n}{2}-1}$. Thus, $R(n)>m$ if $ 4 \binom{n}{2} \binom{m}{n-2} < 2^{\binom{n}{2}-1}$, which is exactly Theorem 4.18.

## Problem 29
Prove that a fixed $k$-term A.P. in $[n]$ can intersect at most $\frac{k^2(n-1)}{k-1}$ other $k$-term A.P. in $[n]$.

**Proof**

First, note that for a $k$-term A.P. in $[n]$ with common difference $d$, we have that $(k-1)d \leq n-1$, and thus, $d \leq \frac{n-1}{k-1}$. Thus, $d$ can be any positive integer $1,\dots,\lfloor \frac{n-1}{k-1} \rfloor$. Now, let $x \in [n]$. For a fixed $d$, there are at most $k$ different $k$-term A.P. in $[n]$ that contain $x$, since $x$ can be any one of the $k$ positions in the progression. Thus, the number of $k$-term A.P. in $[n]$ that contain $x$ is at most $k \cdot \lfloor \frac{n-1}{k-1} \rfloor \leq k \cdot \frac{n-1}{k-1}$. Now, let $A$ be some fixed $k$-term A.P. in $[n]$. Every other $k$-term A.P. in $[n]$ would then intersect at least one of the $k$ elements in $A$. By summing over all $k$ elements $x \in A$, we can count the number of $k$-element A.P.s that intersect $A$ *at least* once. Thus, we have that $\sum_{x \in A} \|\{A.P. containing x\}\| \leq k \cdot (k \cdot \frac{n-1}{k-1}) = \frac{k^2(n-1)}{k-1}$ is an upper bound for the number of A.P. meeting $A$. Thus, a fixed $k$-term A.P. in $[n]$ can intersect at most $\frac{k^2(n-1)}{k-1}$ other $k$-term A.P. in $[n]$.

## Problem 30
What is the mistake in the proof of Theorem 4.19?

**Solution**

The proof shows that the events $A_{ij}$ are pairwise independent; however, it assumes that this implies that all the events are mutually independent as well. Note that in a triangle with vertex set $V = [3]$, if edge $1$-$2$ is monochromatic and edge $1$-$3$ is also monochromatic, then edge $2$-$3$ must be monochromatic. The probability of this intersection is then $pr(A_{12} \cap A_{13} \cap A_{23})=\frac{1}{4}$. However, if they were mutually independent, we would have that $pr(A_{12} \cap A_{13} \cap A_{23}) = pr(A_{12})pr(A_{13})pr(A_{23}) = \frac{1}{2} \cdot \frac{1}{2} \cdot \frac{1}{2} = \frac{1}{8} \neq \frac{1}{4}$. This shows that the probability of none of the events occurring (a proper 2-coloring) is zero.

# Problem Set 7

Theorems used in the set (for reference):

**Theorem 5.6:**
If $(\mathcal{E}, \mathcal{F})$ is cross-intersecting, then $m \leq \binom{p+q}{p}$.

**Theorem 5.10:**
Assume $\mathcal{H}$ is a hypergraph with maximum degree $t$. Then $disc(\mathcal{H}) \leq 2t-1$.

**Proof**

Assume $V = [n]$, $\mathcal{E} = \{ e_1, e_2, \dots, e_m \}$. We allow $\Psi$ to take real values from the interval $[-1, +1]$. A vertex $x$ is called *bad* for $\Psi$ if $\Psi(x) \in (-1, +1)$. An edge $e_j$ is called *bad* for $\Psi$ if it has *more than* $t$ bad vertices. We shall define a procedure to get a $\Psi$ with no bad edges and at each step the following condition will be preserved for all bad edges:
\begin{equation*}\tag{6}
\sum_{x \in e_j} \Psi(x) = 0
\end{equation*}
The procedure starts with $\Psi \equiv 0$ which clearly satisfies equation:thm_5_10_condition6. For the general step, assume that there exist bad edges $e_1, e_2, \dots, e_r$ for $\Psi$ and let $1,2,\dots,s$ be the bad vertices of $\mathcal{H}$ for $\Psi$.
Now, we claim $r<s$. Consider the unknowns $y_1, y_2, \dots, y_s$. Using the claim, the system of $r$ homogeneous linear equations
\[
\sum_{i \in e_j} y_i = 0
\]
has a non-trivial solution $y_1, y_2, \dots, y_s$. Select $\lambda$ so that for all $i$, $1 \leq i \leq s$, the values $\Psi (i)+\lambda y_i$ are all in $[-1, +1]$ and at least one of them becomes $+1$ or $-1$. Then a new $\Psi$ can be defined by changing the values $\Psi(i)$ to $\Psi(i) + \lambda y_i$ for all $i$, $1 \leq i \leq s$. It is left as an exercise to show that the required $\lambda$ exists and the new $\Psi$ satisfies the condition in equation:thm_5_10_condition6.
The procedure eventually terminates with a $\Psi$ with no bad edges because the set $\{ i \in V : \Psi (i) \in \{ +1, -1 \} \}$ increases at each step. At this point, the final $\Psi$ is defined by setting all values $\Psi$ to 1 at the remaining bad vertices. It is easy to see (Problem 34) that this final $\Psi$ satisfies $\| \sum_{x \in e_j} \Psi(x) \| \leq 2t-1$ for all $j$, $1 \leq j \leq m$.

## Problem 31
Assume that $q$ is a prime power and $H=(V,E)$ is a hypergraph in which the edge sizes are not divisible by $q$, but each pair of edges has intersection size divisible by $q$. Prove that $\|E\| \leq \|V\|$. Hint: prove the linear independence of incidence vectors over the field of rational numbers.

**Proof**

Let $H=(V,E)$ be a hypergraph. Let $V=[n]$, and For each edge $e \in E$, let $x_e \in \mathbb{Q}^n$ be its incidence vector over $\mathbb{Q}$, where $x_e^i = 1$ if $v_i \in e$ and $x_e^i = 1$ otherwise. Now, suppose for the sake of contradiction that there exists a nontrivial rational linear combination of the incidence vectors that equals zero. That is, suppose $\sum_{e \in E} c_e x_e = 0$ where for all $e \in E$, $c_e \in \mathbb{Q}$. Now, pick any edge $f \in E$ and take the dot product of both sides with $x_f$, giving $x_f \cdot \left( \sum_{e \in E} a_e x_e \right) = \sum_{e \in E} a_e (x_f \cdot x_e) = 0$. Note that $x_f \cdot x_e = \|f \cap e\|$. Thus, the equation becomes
$a_f \|f\| + \sum_{e \neq f} a_e \|f \cap e\| = 0$. Since $\|f\|$ is not divisible by $q$ and the second sum is divisible by $q$, the only way this can hold over $\mathbb{Q}$ is if $a_f = 0$. Repeating this argument for all $f \in E$, we have that $a_e = 0$ for all $e \in E$. Thus, the incidence vectors $\{x_e : e \in E\}$ are linearly independent over $\mathbb{Q}$. Since these vectors are in $\mathbb{Q}^{\|V\|}$, whose dimension is $\|V\|$, the number of linearly independent vectors cannot exceed the dimension, and thus, $\|E\| \le \|V\|$.

## Problem 32
Assume that we want to cover the edge set of the complete graph $K_n$ by the edges of complete bipartite graphs (allowing to cover an edge many times). At least how many bipartite graphs do we need?

**Proof**

Let $m$ be the number of complete bipartite graphs covering $K_n$, denoted by $G_1, \dots, G_m$, where $G_k$ has parts $L_k$ and $R_k$. Let $A$ be the adjacency matrix of $K_n$. We can then express $A$ as the sum of the adjacency matrices of the bipartite graphs, so $A = \sum_{k=1}^m A(G_k)$. Now, consider the quadratic form associated with these matrices for a vector $x \in \mathbb{R}^n$, $ x^T A x = \sum_{1 \le i \neq j \le n} x_i x_j = \left( \sum_{i=1}^n x_i \right)^2 - \sum_{i=1}^n x_i^2 $. For each bipartite graph $G_k$, we have the quadratic form is $ x^T A(G_k) x = 2 \left( \sum_{i \in L_k} x_i \right) \left( \sum_{j \in R_k} x_j \right) $. Combining these, we get that $ \sum_{i=1}^n x_i^2 = \left( \sum_{i=1}^n x_i \right)^2 - \sum_{k=1}^m 2 \left( \sum_{i \in L_k} x_i \right) \left( \sum_{j \in R_k} x_j \right) $. Now, suppose for the sake of contradiction that $m < n-1$. Note that the following homogeneous system of linear equations $ \sum_{i=1}^n x_i = 0 $ and $ \sum_{i \in L_k} x_i = 0, \quad for  k=1, \dots, m $ has $m+1$ equations. Since $m+1 < n$, there exists a non-trivial solution $x \neq 0$. Substituting this solution into our identity, the right-hand side becomes $0^2 - \sum 2(0)(\dots) = 0$. This then implies that $\sum_{i=1}^n x_i^2 = 0$, which means that $x = 0$, contradicting that $x$ is a non-trivial solution. Thus, we must have $m \ge n-1$.

## Problem 33
A transversal of a hypergraph $H=(V,E)$ is a set $T \subseteq V$ such that $T \cap e \neq \emptyset$ for all $e \in E$. The transversal number of $H$, $\tau(H)$ is defined as the minimum $\|T\|$ for which $T$ is a transversal of $H$. A hypergraph is called $(p+1)$-critical if $\tau(H)=p+1$ but if any edge is removed from $E$ then the transversal number becomes $p$. Prove (applying Theorem 5.6) that any $(p+1)$-critical $t$-uniform hypergraph has at most $\binom{p+1}{t}$ edges. Is equality possible (for every $p,t$)?

**Proof**

Let $H=(V,E)$ be a $(p+1)$-critical $t$-uniform hypergraph with edges $E = \{e_1, \dots, e_m\}$. By the definition of $(p+1)$-criticality, we have that $\tau(H) = p+1$ and for any edge $e_i \in E$, $\tau(H-e_i) \le p$. This second condition implies that for each $i \in [m]$, there exists a set $T_i \subseteq V$ of size at most $p$ that is a transversal of $E \setminus \{e_i\}$. Because $\tau(H) > p$, the set $T_i$ cannot be a transversal of the entire hypergraph $H$, and so $T_i$ must fail to intersect the only remaining edge, $e_i$. This gives us a family of pairs $(T_i, e_i)_{i=1}^m$ which satisfies $\|T_i\| \le p$ and $\|e_i\| = t$, $T_i \cap e_i = \emptyset$, and $T_i \cap e_j \neq \emptyset$ for all $j \neq i$. Note that these fulfill the conditions of Theorem 5.6. After applying the theorem, we get that $ m \le \binom{p+t}{t} $. Thus, any $(p+1)$-critical $t$-uniform hypergraph has at most $\binom{p+1}{t}$ edges. Additionally, equality is possible. Let $X$ be a set of size $p+t$. Let $E$ be the family of all $\binom{p+t}{t}$ subsets of size $t$. The transversal number is $p+1$ (any set of size $p$ leaves $t$ elements untouched, which form an edge), but removing any edge allows a transversal of size $p$.

## Problem 34
Show that the final $\psi$ in the proof of Theorem 5.10 satisfies
\[
\Big\| \sum_{x \in e_j} \psi(x) \Big\| \leq 2t-1,
\]
for every $j \in [m]$

**Proof**

Let $e\_j \in \mathcal{E}$ be any edge. The procedure guarantees that when the process terminates, $e\_j$ is not a bad edge, that is, it contains at most $t$ bad vertices. Let $U\_j \subseteq e\_j$ be the set of bad vertices where $\Psi(x) \in (-1, 1)$ when the procedure terminates. We know $\|U\_j\| \le t$. Moreover, the vertices in $F\_j = e\_j \setminus U\_j$ are those where $\Psi(x) \in \{-1, 1\}$. Consider the moment $e\_j$ stopped being a "bad edge". At this moment, the condition in equation:thm\_5\_10\_condition6 must have been preserved by the procedure on $e\_j$, $\sum\_{x \in e\_j} \Psi(x) = \sum\_{x \in F\_j} \Psi(x) + \sum\_{x \in U\_j} \Psi(x) = 0$. Also note that since the variables in $F\_j$ are fixed at $\pm 1$, the first term $\sum\_{x \in F\_j} \Psi(x)$ remains constant until the end of the procedure. From the condition in equation:thm\_5\_10\_condition6, we can isolate the sum of the fixed vertices, $\sum\_{x \in F\_j} \Psi(x) = - \sum\_{x \in U\_j} \Psi(x)$. The final step (as described in the original proof of Theorem 5.10) is to define the final coloring $\Psi\_{final}$ by setting $\Psi\_{final}(x) = 1$ for all remaining bad vertices $x \in U\_j$. The final sum for edge $e\_j$ is $\sum\_{x \in e\_j} \Psi\_{final}(x) = \sum\_{x \in F\_j} \Psi(x) + \sum\_{x \in U\_j} \Psi\_{final}(x)$, and $\sum\_{x \in e\_j} \Psi\_{final}(x) = \sum\_{x \in F\_j} \Psi(x) + \|U\_j\|$. Substituting the expression for the fixed vertices, we have that $\sum\_{x \in e\_j} \Psi\_{final}(x) = \left( - \sum\_{x \in U\_j} \Psi(x) \right) + \|U\_j\| = \sum\_{x \in U\_j} (1 - \Psi(x))$. Since $\Psi(x) \in (-1, 1)$ for all $x \in U\_j$, we have that $0 < 1 - \Psi(x) < 2$. Since $\|U\_j\| \le t$, the sum is strictly bounded, so $\left\| \sum\_{x \in e\_j} \Psi\_{final}(x) \right\| < 2\|U\_j\| \le 2t$. Since the final sum is an integer, the largest possible magnitude is $2t-1$. Thus, the final $\psi$ in the proof of Theorem 5.10 satisfies $\Big\| \sum\_{x \in e\_j} \psi(x) \Big\| \leq 2t-1$ for every $j \in [m]$

## Problem 35
Prove that there is only one (3,6)-cage (and find it).

**Proof**

TODO.
{% raw %}
\begin{center}
\begin{tikzpicture}[every node/.style={circle,fill=black,inner sep=1.5pt}, ->, >=stealth]
% parameters
\def\n{14}                   % number of vertices
\def\radius{2.5cm}          % radius
\def\startangle{90+360/28}         % start at top
\def\step{360/\n}           % step angle
% --- Nodes: start at top and descend clockwise ---
\foreach \i in {0,...,13} {%
\edef\nodename{v\i}%
\node (\nodename) at ({\startangle - \step*\i}:\radius) {};%
}
\draw[-] (v0) -- (v1);
\draw[-] (v1) -- (v2);
\draw[-] (v2) -- (v3);
\draw[-] (v3) -- (v4);
\draw[-] (v4) -- (v5);
\draw[-] (v5) -- (v6);
\draw[-] (v6) -- (v7);
\draw[-] (v7) -- (v8);
\draw[-] (v8) -- (v9);
\draw[-] (v9) -- (v10);
\draw[-] (v10) -- (v11);
\draw[-] (v11) -- (v12);
\draw[-] (v12) -- (v13);
\draw[-] (v13) -- (v0);
\draw[-] (v0) -- (v5);
\draw[-] (v1) -- (v10);
\draw[-] (v2) -- (v7);
\draw[-] (v3) -- (v12);
\draw[-] (v4) -- (v9);
\draw[-] (v6) -- (v11);
\draw[-] (v8) -- (v13);
\end{tikzpicture}
\end{center}
{% endraw %}
