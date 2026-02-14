---
layout: page
title: Graph Theory Problem Set
course: Taught by Kristóf Bérczi
date: 2025-12-01
excerpt: The course begins with an overview of the fundamental concepts of graph theory, followed by a detailed discussion of classical topics in both structural and algorithmic graph theory.
math: true
---

# Problem Set 1

## Problem 1
Decide if there exists a graph with the following degree sequence:


$$1,1,1,2,4,5,6,6,7$$

**Solution**

There does not exist such a graph. The sum of the degrees of a graph's vertices must be even ($2\|E\|$), but here, the sum of the degrees is 33, which is odd.

## Problem 2
Prove that any simple graph on at least 2 vertices contains two vertices having the same degree.

**Proof**

Suppose a simple graph $G = (V,E)$ has $n \geq 2$ vertices. Then for any $v \in V$, $d(v) \leq n-1$ and $d(v) \in \{ 0,\dots,n-1 \}$. Since we have $n$ vertices and $n-1$ degree "options", at least two vertices must fall in the same degree "option". Note that if $d(v)=0$ for some $v \in V$, then you cannot have another vertex $v' \in V$ with $d(v')=n-1$. Thus, there are at least two vertices having the same degree.

## Problem 3
Verify that for any graph $G=(V,E)$, either $G$ or its compliment $\overline{G}$ is connected.

**Proof**

If $G$ is connected, then we are done. Otherwise, if $G$ is not connected, then there exist vertices $u,v \in V$ such that there is no path from $u$ to $v$. This implies that there are two subgraphs $A = (V\_A, E\_A)$ and $B = (V\_B, E\_B)$ of the graph $G = (V, E)$ such that $ V\_A \cap V\_B = \emptyset $ and $ V\_A \cup V\_B = V $ and for every $a \in V\_A$ and $b \in V\_B$, $ab \notin E$. Now, in the compliment $\overline{G} = (\overline{V}, \overline{E})$, for every $a \in V\_A$ and $b \in V\_B$, $ab \in \overline{E}$. Thus there exists paths between any vertex in $V\_A$ and any vertex in $V\_B$, and any vertices $u,v \in V\_B$ has a path via a vertex in $V\_A$ and any vertices $u,v \in V\_A$ has a path via a vertex in $V\_B$. So $\overline{G}$ is connected.

## Problem 4
Prove that if $G=(V,E)$ is a simple graph on $2n$ vertices such that every vertex has degree at least $n$, then $G$ is connected.

**Proof**

We will proceed inductively. For the base case, assume $n=1$. A graph with 2 vertices with a connection between them is connected. Assume a simple graph on $2n$ vertices such that every vertex has degree at least $n > 1$ is connected. We will prove that a graph on $2(n+1)=2n+2$ vertices such that every vertex has at least degree $n+1$ is connected as well. We are taking the connected graph with $2n$ vertices and adding 2 additional vertices. We are also then taking each vertex and adding 1 to it's degree, effectively adding an edge that it previously did not have. Note that these 2 new vertices can either connect to itself, or connect to a vertex that exists within this connected section. Since these vertices each has degree at least $n+1$, each of them must connect back to the connected path of the graph. Thus, this newly constructed graph is connected as well.

## Problem 5
Prove that any connected graph has a vertex whose deletion (together with the edges incident to it) results in a connected graph.

**Proof**

We know that the vertices of a connected graph $G$ can always be enumerated as $v\_1, \dots, v\_n$ so that
$G\_i := G[v\_1, \dots, v\_i]$ is connected for every $i$. Setting $i = n$, we have $G\_n = G[v\_1, \dots, v\_n]$. Consider the vertex $v\_n$. Deleting it results in the graph $G\_{n-1} = G[v\_1, \dots, v\_{n-1}]$ which is still connected.

## Problem 6
Prove that if $G=(V,E)$ is a graph with at least 5 vertices, then either $G$ or $\overline{G}$ contains a cycle.

**Proof**

If $G$ contains a cycle, then we are done. Otherwise, let $G$ be an n vertex graph without a cycle with $n>5$. Then $G$ is a forest with $1 \leq d \leq 5$ trees.
We know then that the number of edges $\|E\_G\| \leq n-1$. In $\overline{G}$, however, we have $\|E\_{\overline{G}}\| = \|E\_{K\_n}\|-\|E\_G\|= \frac{n(n-1)}{2} - \|E\_G\| \geq \frac{n(n-1)}{2} + n - 1$  (Note: We know $\|E\_{K\_n}\| = \frac{n(n-1)}{2}$ because given $n$ vertices, we first connect one of them to the other $n-1$ vertices, then another one to the remaining $n-2$ vertices and so on. In the end we have $\frac{n(n-1)}{2}$.).
Note then that for all $n>5$, $\|E\_{\overline{G}}\| \geq \frac{n(n-1)}{2} + n - 1 > n - 1$. Since this compliment graph has greater than $n-1$ edges, it has more edges that it's spanning tree, and thus is no longer a tree and contains a cycle.

## Problem 7
Determine the tree whose Prüfer code is $(4,4,7,4,1)$.

**Solution**

{% raw %}
\begin{center}
\begin{tikzpicture}[every node/.style={circle,draw,minimum size=7mm,font=\small}]
\node (4) at (0,0) {4};
\node (2) at (-2,1) {2};
\node (3) at (-2,0) {3};
\node (6) at (-2,-1) {6};
\node (1) at (1.8,0) {1};
\node (7) at (3.6,0) {7};
\node (5) at (3.6,-1.6) {5};
\draw (4)--(2);
\draw (4)--(3);
\draw (4)--(6);
\draw (4)--(1);
\draw (1)--(7);
\draw (7)--(5);
\end{tikzpicture}
\end{center}
{% endraw %}

## Problem 8
Characterize those trees whose Prüfer code consists of all different numbers.

**Solution**

If a tree with length $n$ has a Prüfer code has no repeating number, then the tree is just a straight path with length $n$. The code has length $n-2$. In the tree, there are 2 vertices with degree 1, and they don't appear in the code. The other $n-2$ vertices each appear once in the code, which means they have degree 2, and these are the inner vertices of the path.

## Problem 9
Let $T$ be a tree whose Prüfer code consists of the same number. What is the maximum length of a path in $T$?

**Solution**

If the Prüfer code of $T$ consists of the same number, then there is exactly one vertex (whose label is the only number in the Prüfer code) with many leaves. So the maximum length of a path in $T$ is 2, with this maximal path going from a leaf to the main node to another leaf.

## Problem 10
Determine the number of trees on vertices $1, \ldots, n$ in which vertex 1 has degree exactly 2.

**Solution**

We can count the number of Prüfer codes (with length $n-2$) that represent this tree. Since vertex 1 has degree exactly 2, it appears exactly once in the code, and there are $n-2$ choices where it can go. We then have have $n-1$ other labels with $n-3$ positions where they can go. Thus, we have $(n-2)(n-1)^{n-3}$ such trees.

# Problem Set 2

## Problem 1
Let $G = (V, E)$ be a simple, connected graph with adjacency matrix $A$
[\indent (a)]
- Prove that, for any positive integer $k$, the $(i, j)$-th entry of $A^k$ equals the number of walks of length $k$ from vertex $i$ to vertex $j$ in $G$.
- Use this property to show that the number of walks of length 2 starting and ending at vertex $i$ is equal to the degree of $i$.
- Determine the graph $G$ if every entry of the matrix $A + A^2$ is equal.

**Proof**

Suppose $G = (V, E)$ is a simple, connected graph with adjacency matrix $A$.

**a)** Note that for vertices $i$ and $j$, since the $(i, j)$-th entry of $A$ corresponds to the number of edges between $i$ and $j$, it equivalently represents the number of walks of length 1 (an edge) that exists between $i$ and $j$. Additionally, we observe that 

$$ (A^k)\_{ij}=\sum\_{v\_1,v\_2,\dots,v\_{k-1} \in V} A\_{iv\_1} A\_{v\_1v\_2} A\_{v\_2v\_3} \cdots A\_{v\_{k-1}j} $$ 

for any positive integer $k$ where $i,v\_1,\dots,v\_{k-1},j \in V$ are a sequence of vertices. Because we sum over all intermediary vertices $v\_1,v\_2,\dots,v\_{k-1} \in V$, the $(i, j)$-th entry of $A^k$ corresponds to the number of ways to get from vertex $i$ to vertex $j$ through vertices $v\_1,v\_2,\dots,v\_{k-1}$, which is exactly the number of walks of length $k$ from vertex $i$ to vertex $j$ in $G$.

**b)** The number of walks of length 2 starting and ending at vertex $i$ is equivalent to $(A^2)\_{ii}$. Then, observe that 

$$ (A^2)\_{ii}=A\_{i1}A\_{1i}+A\_{i2}A\_{2i}+\dots+A\_{in}A\_{ni}=\sum\_{j=1}^n A\_{ij} A\_{ji} $$

Note that each term $A\_{ij}A\_{ji}$ equals $1$ only when $i$ and $j$ are adjacent, and $0$ otherwise. The summed quantity thus accumulates the number of edges that are connected to vertex $i$, which is exactly the degree of $i$.

**c)**
Observe that $(A+A^2)\_{ij}$ counts the number of walks of length 1 or 2 that exist between vertices $i$ and $j$. Since all entries are constant, then the number of walks that are either length 1 or 2 between any two vertices are the same. Note that since the diagonal entries of $A$ are all 0 and the diagonal entires of $A+A^2$ are equal, then the diagonal entries of $A^2$ must equal the non-diagonal entries of $A+A^2$. Thus, the number of paths of length 2 from any vertex $i$ back to itself must be equal to the number of paths of length 1 or 2 between any two distinct vertices. This is only possible if every pair of distinct vertices is adjacent. Thus, the graph must be complete. Note that the trivial solution $A = 0\_{n \times n}$ also satisifies the condition. Therfore, the graph $G$ must be either a set of vertices with no edges such that $G=(V,\emptyset)$, or the complete graph $G=K\_n$.

## Problem 2
Prove that the edge set of a graph $G = (V, E)$ can be partitioned into two spanning trees if and only if $G$ can be constructed from a single vertex using the following two operations:
[\indent (i)]
- adding a new vertex $v$ together with two edges connecting $v$ to existing vertices,
- subdividing an existing edge $uw$ by introducing a new vertex $v$, replacing $uw$ with $uv$ and $vw$, and connecting $v$ to an existing vertex with an additional edge.

**Proof**

We will prove both directions.
($\implies$) Assume $G$ is constructed from the two operations. We need to show it can be partitioned into 2 spanning trees. We will proceed by induction. For the base case, assume $G$ has no edges yet. Here, it can be partitioned into 2 spanning trees, each spanning tree consisting of 0 edges. Now, assume $G$ can be partitioned into 2 spanning trees $T\_1$ and $T\_2$. If we apply operation 1, we add a vertex $v$ to $G$ connected by two seperate edges $e\_1$ and $e\_2$. $T\_1$ and $T\_2$ can recieve $e\_1$ and $e\_2$ respectively and $T\_1$ and $T\_2$ remain trees. Thus, $G$ remains being able to be partitioned into 2 spanning trees. If instead we apply operation 2, then we consider some edge $uw$, where $uw$ is some edge either in $T\_1$ or $T\_2$. This edge is then replaced with $uv$ and $vw$, connecting $v$ to an existing vertex with an additional edge. Without loss of generality, suppose $uw$ is a member of $T\_2$. The replacement edges $uv$ and $vw$ then will belong to the same tree $T\_2$, allowing $u$, $v$, and $w$ to remain connected in $T\_2$. The final edge placed to connect the new vertex $v$ with any other vertex will then always return to a connected segment of the other tree, $T\_1$, without creating a cycle and thus preserving the partitions. Therefore, any graph $G$ constructed from the two operations can be partitioned into 2 spanning trees.
($\impliedby$) We will reverse the above argument.

## Problem 3
Consider the following graph. Run Kruskal's algorithm step by step to find its minimum-weight spanning tree. At each step, indicate which edge is added and the current total weight of the partial spanning forest.
{% raw %}
\begin{center}
\begin{tikzpicture}[node/.style={circle,draw,minimum size=7mm},>=stealth]
\node[node] (C) at (-0.5,2) {C};
\node[node] (D) at (2.5,2) {D};
\node[node] (A) at (-2,0) {A};
\node[node] (B) at (1,0) {B};
\node[node] (E) at (4,0) {E};
\draw (C) -- (D) node[midway,above] {3};
\draw (A) -- (C) node[midway,left] {2};
\draw (C) -- (B) node[midway,right] {3};
\draw (B) -- (D) node[midway,right] {4};
\draw (D) -- (E) node[midway,right] {4};
\draw (A) -- (B) node[midway,below] {3};
\draw (B) -- (E) node[midway,below] {3};
\end{tikzpicture}
\end{center}
{% endraw %}

**Solution**

[Step 1:]
- Add minimum edge $AC$ with cost 2. Current total cost = 2.
- Add next minimum edge $CB$ with cost 3. Current total cost = 5.
- Add next minimum edge $CD$ with cost 3. Current total cost = 8.
- Add next minimum edge $BE$ with cost 3. Current total cost = 11.
All vertices are now connected and we have avoided cycles. The following is our spanning tree:
{% raw %}
\begin{center}
\begin{tikzpicture}[node/.style={circle,draw,minimum size=7mm},>=stealth]
\node[node] (C) at (-0.5,2) {C};
\node[node] (D) at (2.5,2) {D};
\node[node] (A) at (-2,0) {A};
\node[node] (B) at (1,0) {B};
\node[node] (E) at (4,0) {E};
\draw (C) -- (D) node[midway,above] {3};
\draw (A) -- (C) node[midway,left] {2};
\draw (C) -- (B) node[midway,right] {3};
\draw (B) -- (E) node[midway,below] {3};
\end{tikzpicture}
\end{center}
{% endraw %}

## Problem 4
Let $G = (V, E)$ be a connected graph with distinct edge weights. Prove that the minimum-weight spanning tree of $G$ is unique

**Proof**

Assume for the sake of contradiction that we have two minimum-weight spanning trees of $G$, $A$ and $B$, where $A \ne B$. Without loss of generality, this implies that there exists a set of edges $E = A \setminus B$ with $E \ne \emptyset$. We will then apply the exchange theorem. Let $e \in E$ to be the edge has minimum weight. If we add $e$ to $B$, then we will have formed a cycle. Additionally, there is at least one edge $f$ in this cycle such that $f \in B \setminus A$. Note that since all edge weights of the graph $G$ are distinct, all the edges in this cycle are strictly greater than the weight of the edge $e$, and thus, the weight of $f$ is strictly greater than the weight of $e$. Remove $f$ from this newly constructed $B$ yields a spanning tree $B'$. Note that the total weight of $B' < B$, which implies that $B$ is not minimal, a contradiction. Therefore, $A = B$ and the minimum-weight spanning tree of $G$ is unique.

## Problem 5
Suppose we stop Kruskal's algorithm as soon as we have selected $k-1$ edges, where $k$ is a fixed integer between $1$ and $\|V\|$. Show that the resulting forest is optimal in the sense that it minimizes the total weight among all spanning forests with $k$ connected components.

**Proof**

TODO

## Problem 6
Prove that every connected graph admits a closed walk that uses each edge exactly twice.

**Proof**

Let $G$ be a connected graph. Construct a new graph $G'$ by duplicating and doubling every edge in $G$. Then every vertex of $G'$ has even degree, and $G'$ is connected. Since every vertex has an even degree, we know that $G$ has a Eulerian tour, which is a closed walk that traverses each edge in $G'$ exactly once. Since each edge in $G$ appears twice in $G'$, this walk corresponds to a closed walk in $G$ that traverses each edge in $G$ exactly twice.

## Problem 7
Let $G$ be a graph in which the degree of every vertex is 4. (A graph with all degrees equal to $k$ is called $k-regular$, so G is a 4-regular graph.) Prove that we can color all edges of $G$ with one of the two colors red and blue, such that every vertex becomes incident to exactly two red and two blue edges.

**Proof**

Since every vertex has degree $4$, all vertices have even degree, and thus there exists a Eulerian tour through every edge. Consider a starting vertex $v$ and begin a Eulerian tour through the graph, coloring each red and blue alternating between the two. Now every vertex has 2 colored incident edges, 1 red and 1 blue. If we ignore or remove all these edges from the graph, we are left with a graph where each vertex has degree 2. Note that here, every vertex still has an even degree, and thus, there exists another Eulerian tour through every edge. If we begin another Eulerian tour, coloring each visited red and blue alternating between them, we will have colored all edges, and thus, we are left with a graph where every vertex becomes incident to exactly two red and two blue edges.

## Problem 8
Let $G$ be a graph in which every vertex has even degree. Show that it is possible to label the edges of $G$ with the integers $1,\dots,m$ (where $m = \|E(G)\|$) so that, for every vertex, the greatest common divisor of the labels on its incident edges is 1.

**Proof**

Since $G$ is a graph in which every vertex has even degree, there exists a Eulerian path. Choose an arbitrary starting vertex $v$ and begin a Eulerian tour through every edge. For the first edge, label it 1. Then label the next edge 2, and continue this pattern. That is, for each subsequent edge, label it with an integer that is 1 greater than the previous edge. Observe that through this process, we have labeled the edges of $G$ with the integers $1,\dots,m$ where $m = \|E(G)\|$. Additionally, note that for every edge, there exists an edge with some integer $p$ and another integer $p+1$. The greatest common divisor of the labels is therefore $1$, since for any $p \in \mathbb{Z}\_{>0}$, $\gcd(p, p+1)=1$.

# Problem Set 3

## Problem 1
Prove that Pósa's theorem implies Ore's theorem

**Proof**

For a graph $G=(V,E)$, assume Ore's theorem's condition, that is, assume $d(u)+d(v) \geq n$ for every $u,v \in V$ with $uv \notin E$. Since $uv \notin E$, then $d(u) \leq n-2$, since $u$ cannot be connected to itself and the vertex $v$. Similarly, $d(v) \leq n-2$. Thus, $d(u)+d(v) \leq 2n-4$, and since $d(u) \geq 1$ and $d(v) \geq 1$, we have that $d(u)+d(v) \geq 2$. This implies that $2 \leq d(u)+d(v) \leq 2n-4 \implies 2 \leq 2n-4 \implies n \geq 3$. Now, suppose $1 \leq d\_1 \leq d\_2 \leq \dots \leq d\_n < n$ is the degree sequence. Then, for all $i < j \leq \frac{n}{2}$, $i+j < n$, and since we know that by Ore's condition, $d\_i + d\_j \geq n$, we have that $i < j < d\_i + d\_j$. This implies that for all $d\_i \geq i+1$, which is exactly Pósa's condition, and thus, there exists a Hamilton cycle. Therefore, Pósa's theorem implies Ore's theorem.

## Problem 2
Let $G$ be a graph on $2x+1$ vertices with all degrees at least $x$. Prove that $G$ contains a Hamilton path.

**Proof**

Suppose $G$ is a graph with $n=2x+1$ vertices and all vertices have degree at least $x$. Now, add a vertex $v\_0$ and connect it to all $2x+1$ vertices, and thus, $d(v\_0)=2x+1$. Consequently, we have $n=2x+2$ vertices such that for every vertex $v \in V$, $d(v) \geq x+1 = \frac{2x+2}{2} = \frac{n}{2}$. Thus, by Dirac's theorem, we have a Hamilton cycle. Removing the vertex $v\_0$ from the graph would then leave it without a Hamilton cycle, but a Hamilton path would exist.

## Problem 3
Let $G$ be a regular simple graph on $2025$ vertices that contains a Hamilton cycle. Prove that $G$ also contains a Eulerian circuit. (Reminder: We say that a graph is regular if all of its vertices have equal degree.)

**Proof**

Suppose $G$ is a regular simple graph with $2025$ vertices that contains a Hamilton cycle. To prove that $G$ also contains an Eulerian circuit, we need to show that $G$ is connected and that every vertex in $G$ has an even degree. Since $G$ contains a Hamilton cycle, then we know it must be connected. Furthermore, since the graph is regular, suppose each vertex has degree $d$. Then, for 2025 vertices, the sum of the degrees, $\sum{d(v)}=2025d$. By the Handshake Lemma, we know that this sum must be even, and thus, $d$ must be even. Therefore, $G$ also contains a Eulerian circuit.

## Problem 4
An oriented complete graph is called a tournament. Show that every tournament contains a directed Hamilton path.

**Proof**

We will proceed by induction. For the base case, consider a tournament with 1 vertex. Trivially, there exists a directed Hamilton path. Now for the inductive step, suppose the tournament with $n$ vertices contains a directed Hamilton path enumerated as $v\_1, v\_2, \dots, v\_n$. Consider adding a vertex $u$ and ensuring that all other vertices have a directed edge connecting it. If we have all other vertices outwardly pointing to $u$, then there exists the Hamilton path $v\_1, v\_2, \dots, v\_n, u$. If $u$ has outwardly directed edges to all other vertices, then there exists the Hamilton path $u, v\_1, v\_2, \dots, v\_n$. Consider the first vertex in the sequence $v\_1, v\_2, \dots, v\_n$ that $u$ has an outward edge pointing to. Call this vertex $v\_i$. Note that then, $v\_{i-1}$ points to $u$, and thus, there exists the Hamilton path $v\_1, v\_2, \dots, v\_{i-1}, u, v\_i, \dots, v\_n$. Therefore, every tournament contains a directed Hamilton path.

## Problem 5
Suppose that a graph $G$ can be partitioned into $k$ edge-disjoint spanning trees. Let $s$ be a specified node of $G$. Prove that $G$ can be partitioned into $k$ edge-disjoint spanning trees $T\_1,\dots, T\_k$ in such a way that the trees are equitable at $s$ in the sense that $\|d\_{T\_i}(s) - d\_{T\_j}(s)\| \leq 1$ for every $i, j \in [k]$.

**Proof**

TODO

# Problem Set 4

## Problem 1
Let $D = (V, A)$ be a directed graph and let $c : A \to \mathbb{R}$ be a conservative weight function. Is it true that there always exists a nonnegative feasible potential?

**Proof**

Yes. Let $n = \|V\|$ and let $s \in V$ be some vertex. Suppose $\pi(v) := \min(cost of a walk from s to v with at most  n-1 edges)$. Consider an edge $uv \in A$ and take the minimum walk from $s$ to $u$ with at most $n-1$ edges (which has cost $\pi(u)$) and add the edge $uv$ to the walk. Now we have a walk from $s$ to $v$ with a cost $\pi(u) + c(uv))$ and therfore, $\pi(v) \leq \pi(u) + c(uv)$. Rearranging yields $\pi(v)-\pi(u) \leq c(uv)$ and thus, $\pi$ is a feasible potential. Now, let $\pi'(v) := \pi(v) - m$ where $m$ is the minimum faesible potential among all vertices. Here, we have that $\pi'(v) \geq 0$ for all $v \in V$ and is thus a nonnegative feasible potential, and therefore, there always exists a nonnegative feasible potential.

## Problem 2
Let $D = (V, A)$ be a directed graph and let $c : A \to \mathbb{R}$ be a conservative weight function. Is it true that any subpath of a cheapest $s$-$t$ path is itself a cheapest path between its endpoints?

**Proof**

Yes. Let $\mu(s-t)$ be the minimum cost of an $s$-$t$ path. Let $u \in V$ be a vertex contained inside of this path. Here, $s$-$u$ is an arbitrary subpath of the $s$-$t$ path. Then, since $C(s-t)=\mu(s-t)$, we have that $\mu(s-t) = C(s-u) + C(u-t)$ where $C$ denotes the cost of a path. Note that since $c$ is conservative, there are no negative cycles, and $C$ is therefore well-defined. If $C(s-u)$ was not the minimum cost of an $s$-$u$, then $\mu(s-t)$ would no longer be minimal, thus, $C(s-u)=\mu(s-u)$. Therefore, $\mu(s-u)$ is the cost of the cheapest $s$-$u$ path, which is some subpath of the $s$-$t$ path.

## Problem 3
Let $D = (V, A)$ be a directed graph and let $c : A \to \mathbb{Z}$ be a conservative weight function. Suppose $\pi\_1$ and $\pi\_2$ are both feasible potentials with respect to $c$.
[\indent(a)]
- Prove that $\lfloor (\pi\_1 + \pi\_2)/2
\rfloor$ and $\lceil (\pi\_1 + \pi\_2)/2 \rceil$ are also feasible potentials.
- Prove that $\max(\pi\_1, \pi\_2)$ and $\min(\pi\_1, \pi\_2)$ are feasible potentials.

**Proof**

Assume $\pi\_1(v) - \pi\_1(u) \leq c(uv)$ and $\pi\_2(v) - \pi\_2(u) \leq c(uv)$ for all edges $uv \in A$
[\indent(a)]
- Define $\pi\_{avg} := \frac{\pi\_1+\pi\_2}{2}$. Then, summing up the two inequalities in our assumption and dividing by 2 yields $\frac{\pi\_1(v)+\pi\_2(v)}{2} - \frac{\pi\_1(u)+\pi\_2(u)}{2} \leq c(uv)\implies \pi\_{avg}(v) - \pi\_{avg}(u) \leq c(uv)$, and thus, $\pi\_{avg}$ is feasible. Now, since the costs are integers, we have that $\lfloor \pi\_{avg}(v) \rfloor - \lfloor \pi\_{avg}(u) \rfloor \leq \pi\_{avg}(v) - \pi\_{avg}(u) \leq c(uv)$ and that $\lceil \pi\_{avg}(v) \rceil - \lceil \pi\_{avg}(u) \rceil \leq \pi\_{avg}(v) - \pi\_{avg}(u) \leq c(uv)$. Thus, $\lfloor (\pi\_1 + \pi\_2)/2
\rfloor$ and $\lceil (\pi\_1 + \pi\_2)/2 \rceil$ are feasible potentials.
- Define $\pi\_{max}(v) := \max(\pi\_1(v), \pi\_2(v))$. Note that for any edge $uv \in A$, $\pi\_{max} \leq \max(\pi\_1(u) + c(uv), \pi\_2(u) + c(u,v))$. Since $c(uv)$ is a constant, we have that $\max(\pi\_1(u) + c(uv), \pi\_2(u) + c(u,v)) = \pi\_{max}(u)+c(uv)$. This implies that $\pi\_{max}(v) \leq \pi\_{max}(u) + c(u,v) \implies \pi\_{max}(v) - \pi\_{max}(u) \leq c(u,v)$, and thus, $\pi\_{max}$ is a feasible potential. We will proceed similarly for $\pi\_{min} := \min(\pi\_1(v), \pi\_2(v))$. Observe that $\pi\_{min}(v) \leq \min(\pi\_1(u) + c(uv), \pi\_2(u)+c(uv)) \implies \min(\pi\_1(u)+c(uv),\pi\_2(u)+c(uv)) = \pi\_{min}(u) + c(uv)$. So, $\pi\_{min}(v) \leq \pi\_{min}(u) + c(uv)$ and therefore, $\pi\_{min}(v)-\pi\_{min}(u) \leq c(uv)$. Thus, $\pi\_{min}$ is a feasible potential as well.

## Problem 4
Let $D = (V, A)$ be a directed graph and let $c : A \to \mathbb{Z}$ be a conservative weight function. Furthermore, let $P$ be a cheapest $s$-$t$ path. Reverse the edges of $P$ and negate the costs of these edges. Show that the resulting cost function is also conservative in the graph thus obtained.

**Proof**

TODO

## Problem 5
Develop an algorithm to decide whether a directed graph with a conservative weight function contains a zero-weight cycle.

**Proof**

TODO

## Problem 6
Given a directed graph with a conservative weight function on the edges and a lower and upper bound specified for each vertex, how can one decide whether there exists a feasible potential within the given bounds?

**Proof**

We need to find way to detect if there exists a $\pi$ such that $\pi(v) - \pi(u) \leq c(u,v)$ and $l(v) \leq \pi(v) \leq u(v)$ for all $v \in V$. To do so, apply the following process:
Consider a vertex $v\_0$ with $\pi(v\_0)=0$. Then, $\pi(v) \leq u(v) \implies \pi(v) - \pi(v\_0) \leq u(v)$. Moreover, $\pi(v) \geq l(v) \implies \pi(v\_0) - \pi(v) \leq -l(v)$. Consider these differences as directed edges on a graph, since they are of the same form as the feasible potential constraint $\pi(v) - \pi(u) \leq c(u,v)$.
Represent the inequality $\pi(v) - \pi(v\_0) \leq u(v)$ as an edge from $v\_0$ to $v$ with cost u(v), and represent the inequality $\pi(v\_0) - \pi(v) \leq -l(v)$ as an edge from $v$ to $v\_0$ with cost $-l(v)$. Note that in this graph, if there exists a negative cycle, then $\pi$ is unfeasable and thus, there does not exist a feasible potential within the given bounds. Therefore, we must now detect the existence of negative cycles precisely by using the Bellman-Ford algorithm. If Bellman-Ford detects a negative cycle, no feasible potential exists, otherwise, there is a feasible potential within the given bounds.

## Problem 7
Let $P$ be a path, and let $\mathcal{F}$ be a family of its subpaths. Develop an algorithm that select a collection of edge-disjoint subpaths from $\mathcal{F}$ so that the total length of the selected subpaths is maximized.

**Solution**

The algorithm will run as follows. First, take $\mathcal{F}$ and sort it so that each subpath is ordered based on the position of its ending vertex in $P$ where the smallest ending vertex is first. Then, initialize an empty list and iterate through every subpath $s$. Add $s$ to a list if $s$ does not share any edges with subpaths already in the list, otherwise, skip it. The collection of subpaths in the list will be the selection of edge-disjoint subpaths from $\mathcal{F}$ such that the total length of the selected subpaths is maximized.

## Problem 8
Let $D = (V, A)$ be a directed graph and let $c : A \to \mathbb{Z}$ be a conservative weight function. Recall that $\pi\_{c}^{n}(v)$ denotes the minimum cost of a walk of length at most $n$ ending at $v$. Prove that among all nonpositive feasible potentials, $\pi\_{c}^{n}(v)$ is the largest; that is, for any feasible potential $\pi$, we have $\pi(v) \leq \pi\_{c}^{n}(v)$ for all $v \in V$.

**Proof**

Let $\pi$ be a nonpositive feasible potential. Let $W=(v\_0, v\_1,\dots,v\_k)$ with $v\_k = v$ and $k \leq n$ denote a walk of length at most $n$ ending at $v$. We know that $\pi(v\_i)-\pi(v\_{i+1}) \leq c(v\_i, v\_{i+1})$ for all $i$. Then, $\pi(v)-\pi(v\_0) \leq \sum\_{i=0}^{k-1} c(v\_i, v\_{i+1}) = C(W)$. Since $\pi$ is nonpositive, we have that $\pi(v\_0) \leq 0$ and thus $\pi(v) \leq C(W)$. Since this holds for all walks of length at most $n$ ending at $v$, it also holds for the minimum cost walk, and thus, $\pi(v) \leq \pi\_{c}^{n}(v)$ for all $v \in V$.

# Problem Set 5

## Problem 1
Let $G = (S, T; E)$ be a bipartite graph. Suppose that $G$ has a matching covering $X \subseteq S$ and another matching covering $Y \subseteq T$. Prove that $G$ contains a matching that covers every vertex in $X \cup Y$.

**Proof**

Denote the matching covering $X \subseteq S$ by $M\_S \subseteq E$ and the matching covering $Y \subseteq T$ by $M\_T \subseteq E$. Consider $M = M\_S \cup M\_T$. Note that every vertex is either an isolated vertex or has degree 1 or 2, in which case it is part some even cycle or path. Consequently, we have 3 distinct components, either an even cycle $C$, a path $P$, or isolated vertices. We can safely ignore all isolated vertices since isolated vertices are incident to no edges and is thus not covered by $M\_S$ nor $M\_T$, implying that is is not an element of $X \cup Y$. Consider the component $C$, which contains edges that alternative between $M\_S$ and $M\_T$. Without loss of generality, choose $M\_T$ and take all the $M\_T \cap C$. Here, all vertices in $C$ are covered by this choice of edges. Now consider the component $P$. If both endpoints of $P$ are in $X$, choose $M\_S \cap P$. Here, these chosen edges alternate in the path $P$ but still cover $X \cap P$. If both endpoints of $P$ are in $Y$, choose $M\_T \cap P$ by the same logic. In this way, we have essentially chosen a matching $M = M\_S \cup M\_T$ that covers $X \cup Y$, and thus, $G$ contains a matching that covers every vertex in $X \cup Y$.

## Problem 2
Let $G = (S, T; E)$ be a bipartite graph, and for each $v \in S \cup T$, let $\prec\_v$ be a linear order on the edges incident to $v$. Let $e = uv$ be the edge most preferred by $u$ with respect to $\prec\_u$. Furthermore, assume that $e \prec\_v f$ for some edge $f$. Prove that the sets of stable matchings of $G - f$ and $G$ coincide.

**Proof**

We will show that the sets of stable matchings of $G - f$ and $G$ coincide, that is, $f \notin M$ for any stable matching $M$ of $G$. Let $M$ be a stable matching of $G$. Assume $f \in M$ for the sake of contradiction. Then, we have $f=vw$ for some vertex $w$. Clearly, $e \notin M$. Since both $u$ and $v$ prefer $e$ over their current matching edge, $e$ is a blocking edge, and consequently, $M$ is not a stable matching, a contradiction. Thus, $f \notin M$, implying that the sets of stable matchings of $G - f$ and $G$ coincide.

## Problem 3
The outcome of the Gale-Shapley (proposal) algorithm is boy-optimal, meaning that each boy receives the best possible partner he can obtain in any stable matching, and girl-pessimal, meaning that each girl is matched to the worst possible partner she can obtain in any stable matching.

**Proof**

TODO

## Problem 4
Show that any two stable matchings cover the same set of vertices.

**Proof**

Suppose $M\_1$ and $M\_2$ are two matchings that do not cover the same vertices. So there exists some vertex $v$ that is matched in $M\_1$ but not in $M\_2$.
Let $v$ be matched to the vertex $u$ and so $uv \in M\_1$. Since $v$ is unmatched in $M\_2$, $uv \notin M\_2$ and thus $u$ is matched in $M\_2$ to some other vertex $w$. Note that $u$ cannot be unmatched in $M\_2$ since that would lead to $uv$ being unmatched edge with both endpoints unmatched in $M\_2$, contradicting stability. Consider $u$ being matched to $w \ne v$. Since $uv \in M\_1$, $u$ prefers $v$ over being unmatched and maybe even over $w$. If $u$ prefers $v$ over $w$, then $uv$ is a blocking edge in $M\_2$. If $u$ prefers $w$ over $v$, then $v$ is matched to $u$ but may prefer another option in $M\_1$, but in $M\_2$, since $v$ is unmatched, $v$ would prefer $u$ over being unmatched. Either way, $uv$ is a blocking edge in $M\_2$, and thus $M\_2$ matching is not stable. Therefore, no vertex can be matched in $M\_1$ and unmatched in $M\_2$. Symmetrically, no vertex can be matched in $M\_2$ and unmatched in $M\_1$. So, the set of matched matched vertices is identical in $M\_1$ and $M\_2$ and thus, any two stable matchings cover the same set of vertices.

## Problem 5
If $M\_1$ and $M\_2$ are stable matchings in the bipartite graph $G$, and each boy chooses from $M\_1 \cup M\_2$ the edge he prefers more, then we obtain a stable matching $M\_1 \lor M\_2$, in which each girl is matched via the less preferred edge from $M\_1 \cup M\_2$. If, on the other hand, the girls choose their preferred edge, then we obtain stable matching $M\_1 \land M\_2$, in which each boy is matched via the less preferred edge from $M\_1 \cup M\_2$.

**Proof**

TODO

## Problem 6
Let $G = (V, E)$ be a (not necessarily bipartite) graph, and for each $v \in V$, let $\prec\_v$ be a linear order on the edges incident to $v$. A matching $M \subseteq E$ is called stable if there is no edge $e = uv \in E \setminus M$ such that both $u$ and $v$ prefer $e$ to their respective edges in $M$. Prove that if $G$ is not bipartite, then there exists an assignment of preference lists to the vertices of $G$ for which no stable matching exists.

**Proof**

If $G$ is not bipartite, it must contain a cycle of odd length. Denote this cycle by $C=(v\_0,...v\_{n-1})$ where $n$ is an odd integer. For any vertex $v\_i$, place the vertex appearing directly to its clockwise direction $v\_{i+1}$ first and the vertex behind it $v\_{i-1}$ second in the preference lists. Populate the rest of the preference list arbitrarily. Assume for the sake of contradiction that there exists a stable matching $M$. Because two adjacent edges cannot be in $M$ and the cycle is odd, then there must exist two adjacent edges that do not belong in $M$. In other words, there are two edges in the cycle $e\_j = v\_jv\_{j+1}$ and $e\_{j+1} = v\_{j+1}v\_{j+2}$ which are both not in $M$. Here, the vertex $v\_{j+1}$ is not matched to neither its direct clockwise vertex nor its direct counterclockwise vertex and is therefore matched with some other vertex further down its preference list. The vertex $v\_j$ prefers the edge $e\_j$ connecting it to $v\_{j+1}$ but since $e\_j \notin M$, it is connected elsewhere. We then have two vertices $v\_j$ and $v\_{j+1}$ that prefer the edge $e\_j$ over their current match which implies the matching is not stable, a contradiction.

## Problem 7
Let $k, n$ be positive integers satisfying $k < n/2$. Prove that for every $k$-element subset $A$ of $[n] = \{1, \dots, n\}$, one can add an element from $[n] \setminus A$ to $A$ in such a way that the resulting $\binom{n}{k}$ $(k + 1)$-element subsets of $[n]$ are all different.

**Proof**

Let $S$ be the collection of all $k$-element subsets of $[n]$ and let $T$ be the collection of all $(k+1)$-element subsets of $[n]$. We will use $S$ and $T$ to construct a disjoint graph $G$. The edges between $S$ and $T$ represents the "adding an element" process in our statement.
Consider $A \in S$ to be a $k$-element subset and $B \in T$ to be a $(k+1)$-element subsets. Add an edge between $A$ and $B$ if and only if $A \subset B$. Note that the degree of $A$ is $n-k$ and the degree of $B$ is $k+1$.
Now consider an arbitrary subset $X \subseteq S$ and let $\Gamma(X)$ denote the neighborhood of $X$ in $G$. There are $\|X\|(n-k)$ total edges incident to $Z$ and $\|\Gamma(X)\|(k+1)$ total edges incident $\Gamma(X)$. We then have $\|X\|(n-k) \leq \|\Gamma(X)\|(k+1)$ and thus $\frac{\|X\|}{\|\Gamma(X)\|} \leq \frac{k+1}{n-k}$. Moreover, since we have that $k < n/2$, $n-k > k+1$ and thus $\frac{k+1}{n-k} \leq 1$. Consequently, $\frac{\|X\|}{\|\Gamma(X)\|} \leq 1$, implying $\|X\| \leq \|\Gamma(X)\|$. By our Corollary (Note: Given $G=(S,T;E)$, there exists a matching covering S if and only if for all $X \subseteq S$, $\|\Gamma(X)\| \geq \|X\|$), this implies that there exists an $S$ matching. Therefore, for every $k$-element subset of $[n]$, there exists a $(k+1)$-element subset that is the result of appending a seperate element from $[n]$. Thus, we have proven that for every $k$-element subset $A$ of $[n] = \{1, \dots, n\}$, one can add an element from $[n] \setminus A$ to $A$ in such a way that the resulting $\binom{n}{k}$ $(k + 1)$-element subsets of $[n]$ are all different.

# Problem Set 6

Throughout, let $D = (V, A)$ be a digraph and $s, t \in V$ .

## Problem 1
Let $c \colon A \to \mathbb{R\_+}$ be a capacity function, and let $x$ and $x'$ be maximum flows. Prove that if there exists an augmenting path from $s$ to some vertex $v$ in $D\_x$, then there also exists one in $D\_{x'}$.

**Proof**

First, since $x$ and $x'$ are both maximum flows, the MFMC theorem implies that they carry their maximum capacities through all minimum cuts. Let $(S, V \setminus S)$ be the set of vertices reachable from $s$ in $D\_x$ with $v \in S$. Now consider the minimum cut $(S, V \setminus S)$. Because $x'$ is also a maximum flow, it must carry the maximum flow through this same cut. That is, for any edge $(u,w)$ with $u \in S$ and $w \in V \setminus S$, we have $x'(u,w) = c(u,w)$. Consequently, in the graph $D\_{x'}$, no forward edge crosses from $S$ to $V \setminus S$, but backward edges may exist. Now, for any vertex $u \in S$, there exists a path from $s$ to $u$ in $D\_x$. Since $x'$ also maximizes flow across the same cut, the capacities within $S$ (edges between vertices in $S$) remain identical to $x$. Therefore, the same path from $s$ to $v$ that exists in $D\_x$ exists in $D\_{x'}$ restricted to $S$. Thus, there exists an augmenting path from $s$ to $v$ in $D\_{x'}$ as well.

## Problem 2
Suppose that, in addition to the edge capacities $c \colon A \to \mathbb{R\_+}$, each vertex is assigned an upper bound specifying the maximum amount of flow that may pass through it. Design an algorithm that computes a maximum flow subject to these vertex capacity constraints.

**Solution**

Our algorithm will augment $D$ to construct a new $D'=(V',A')$ in which we can run a known algorithm on. For each vertex $v \in V$, split it into two vertices $a\_v,b\_v$ and add a directed edge $(a\_v,b\_v)$ from $a\_v$ to $b\_v$ with the capacity $m(v)$, which will denote its maximum flow upper bound. To preserve the original edges and their capacities, for every $(u,v) \in A$ with capacity $c(u,v)$, add the edge $(b\_u, a\_v)$ with the same capacity $c(u,v)$. These changes contruct a new $V'$ and $A'$. We will then run the Edmond-Karp algorithm (Note: Section 3.5 in Frank's book) which will then compute the maximum flow subject to the vertex capacity constraints. This ensures that any flow through $v$ in $D$ corresponds to a flow from $a\_v$ to $b\_v$ in $D'$, which is upper-bounded by $m(v)$.

## Problem 3
Let $c\_1, \dots, c\_k$ be capacity functions on the edges. Give an algorithm for deciding whether there exists an $s$-$t$ cut $S$ that is simultaneously a minimum cut for every $g\_i$.

**Solution**

TODO (what is $g\_i$?)

## Problem 4
Given a capacity function $c \colon A \to \mathbb{R\_+}$, design an algorithm that decides whether the minimum $s$-$t$ cut is unique.

**Solution**

First, compute a maximum $s$-$t$ flow $x$ and construct the graph $D\_x$. Now, let $A = { v \in V : v is reachable from  s in  D\_x }$. Note that now the cut $(A, V \setminus A)$ is minimum, since in $D\_x$, the edge $(u,v)$ is present if we can send more flow along it, and if $v \in V \setminus A$, then $v$ is not reachable from $s$ in $D\_x$, and all edges from $A$ to $V \setminus A$ are at maximimum capacity with all edges going the other way having zero flow, implying that the total flow across the cut is maximal, and by the MFMC theorem, it is then a minimum cut.
Next, let $B = { v \in V : t is reachable from  v in  D\_x }$.
For any minimum cut $(S, V \setminus S)$, observe that every vertex in $A$ must be in $S$, since vertices reachable from $s$ in $D\_x$ cannot be on the $T$ side of a minimum cut, and that no vertex in $B$ can be in $S$, since vertices that can reach $t$ in $D\_x$ must lie on the $T$ side of every minimum cut because sending them to $S$ would create a non-maximal edge crossing the cut, which contradicts the minimality of the cut.
So for any minimum cut $S$, we have that $A \subseteq S \subseteq V \setminus B$.
Consider the case $A \neq V \setminus B$, so there exist vertices outside $A \cup B$, which can be assigned either to $S$ or $T$ without changing the capacity of the cut, implying that the minimum cut is not unique.
If $A = V \setminus B$, then there are no vertices outside $A \cup B$, so the only way to satisfy $A \subseteq S \subseteq V \setminus B$ is when $S = A$, implying that the minimum cut is unique.
This means that the minimum cut $(A, V \setminus A)$ is unique if and only if every vertex belongs to $A \cup B = V$.
Now we will construct an algorithm to create the sets $A$ and $B$. The algorithm is as follows:
- Compute a maximum flow $x$ (using Edmonds-Karp).
- Construct the residual graph $D\_x$.
- Run BFS/DFS from $s$ in $D\_x$ to find $A$.
- Run BFS/DFS from $t$ in the reversed $D\_x$ to find $B$.
- If $A \cup B = V$ (equivalently $A = V \setminus B$), output that the minimum cut is unique; otherwise, it is not unique.

## Problem 5
Give an algorithm that finds all edges for which any positive increase in capacity results in an increase in the value of the maximum flow. Does such an edge always exist? How can these edges be identified?

**Solution**

TODO (use $D\_x$)

# Problem Set 7

A connected graph $G=(V,E)$ is *2-edge-connected* if $G-e$ remains connected for any $e \in E$, and *2-vertex-connected* if $\|V\| \geq 3$ and $G-v$ remains connected for any $v \in V$. An *ear-decomposition* of $G$ is a sequence of subgraphs $(P\_0, P\_1, \dots, P\_k)$ such that:
- $P\_0$ is a cycle in $G$;
- for each $i \geq 1$, $P\_i$ is a path or a cycle in $G$ such that
\begin{itemize}
\item[-] if $P\_i$ is a path, then its end vertices lie in $\bigcup\_{j < i} P\_j$, but its internal vertices are not contained in $\bigcup\_{j < i} P\_j$;
\item[-] if $P\_i$ is a cycle, then it meets $\bigcup\_{j < i} P\_j$ in exactly one vertex, and its other vertices are not contained in $\bigcup\_{j < i} P\_j$.
\end{itemize}
- $G = \bigcup\_{i=0}^k P\_i$.

## Problem 1
Prove that if $P\_0,P\_1, \dots, P\_k$ is an ear-decomposition of a graph $G=(V,E)$, then $\|E\|=\|V\|+k$.

**Proof**

We will proceed inductively. Assume $P\_0$ is the ear-decomposition of $G$. Note that $k=0$. Then $G$ is entirely a cycle $C=v\_1,e\_1, v\_2, e\_2, \dots, v\_{n}, e\_{n}, v\_1$. Here, $\|E\| = n$ and $\|V\| = n$, and thus, $\|E\|=\|V\|+k$ holds true. Now assume that $P\_0,P\_1, \dots, P\_{k-1}$ is the ear-decomposition of $G$ and $\|E\_{k-1}\|=\|V\_{k-1}\|+(k-1)$. Add another subgraph (ear) $P\_k$ with $q$ edges. If $P\_k$ is a cycle, then it meets the graph at exactly one vertex and so it adds its $q-1$ internal vertices.
Else, if $P\_k$ is a path, then it meets the graph at two vertices (both of the endpoints), and thus it also introduces $q-1$ vertices. Now, we have that $\|E\_k\| = \|E\_{k-1}\| + q$ and $\|V\_k\| = \|V\_{k-1}\| + (q-1)$. Rearranging gives $\|E\_{k-1}\| = \|E\_k\| - q$ and $\|V\_{k-1}\| = \|V\_k\| - (q-1)$ Substituting these values in $\|E\_{k-1}\|=\|V\_{k-1}\|+(k-1)$ yields $\|E\_k\| - q=\|V\_k\| - (q-1)+(k-1)$. Simplifying gives $\|E\_k\| = \|V\_k\| + k$. Thus, by induction, if $P\_0,P\_1, \dots, P\_k$ is an ear-decomposition of a graph $G=(V,E)$, then $\|E\|=\|V\|+k$.

## Problem 2
Let $G$ be a connected undirected graph. Prove the following equivalences.
[\indent(a)]
- $G$ is 2-edge-connected if and only if it has an ear-decomposition
- $G$ is 2-vertex-connected if and only if it has an open ear-decomposition with $\|P\_0\| \geq 3$.
- $G$ is factor-critical if and only if it has an odd ear-decomposition

**Proof**

The following are the proofs for the three equivalences.
(a) We will prove both directions.
\begin{adjustwidth}{2em}{0pt}
\begin{direction}($\Rightarrow$) Assume $G$ is 2-edge-connected.
We will construct an ear-decompo\-sition. Since $G$ is 2-edge-connected, the minimum degree is at least 2, so $G$ contains a cycle. Let $C\_0$ be this cycle. Suppose we have constructed a subgraph $C\_k$ which is an ear-decomposition. If $C\_k = G$, we are done. If $V(C\_k) \subset V(G)$ or $E(C\_k) \subset E(G)$, since $G$ is connected, there exists an edge $e \in E(G) \setminus E(C\_k)$ with at least one endpoint in $C\_k$. If both endpoints of $e$ are in $C\_k$, then $e$ itself forms an ear (a path of length 1). If $e = uv$ with $u \in C\_k, v \notin C\_k$, then because $G$ is 2-edge-connected, the edge $e$ is not a bridge in $G$. Therefore, $G - e$ is connected, which implies that there is a path from $v$ to $C\_k$ in $G - e$. Let $P$ be a shortest such path. Then $P \cup \{e\}$ forms a path starting and ending in $C\_k$ with all internal vertices not in $C\_k$, which is a valid ear. We can then add this ear to form $C\_{k+1}$. Finally, repeat this until $G$ is fully reconstructed.
\end{direction}
\begin{direction}($\Leftarrow$) Assume $G$ has an ear-decomposition $G=P\_0, P\_1, \dots, P\_k$.
We will now proceed inductively on the number of ears $k$. We know that $P\_0$ is a cycle, which is clearly 2-edge-connected. Now assume that $P\_i$ is 2-edge-connected. Let $P\_{i+1}=P\_i \cup Q$, where $Q$ is an ear that is attached to the vertices $u,v \in V(P\_i)$. Suppose now that we remove an edge $e$ from $P\_{i+1}$. Then, if $e \in Q$, then $P\_i$ is unaffected and is still connected. The removal of $e$ from $Q$ disconnects the path $Q$, but the vertices of $Q$ are still connected to $P\_i$ through the remaining parts of the path attached to $u$ or $v$. Thus, $P\_{i+1}-e$ is connected. If $e \in P\_i$, then since $P\_i$ is 2-edge-connected, $P\_i-e$ remains connected. The path $Q$ remains attached to $P\_i-e$ at $u$ and $v$, so the whole graph remains connected. Thus, $G$ is 2-edge-connected.
\end{direction}
\end{adjustwidth}
(b) We will prove both directions.
\begin{adjustwidth}{2em}{0pt}
\begin{direction}($\Rightarrow$) Assume $G$ is 2-vertex-connected.
% ...
\end{direction}
\begin{direction}($\Leftarrow$) Assume $G$ has an open ear-decomposition with $\|P\_0\|\ge 3$.
We will proceed inductively on the number of ears $k$. We know that $P\_0$ is a cycle of length $\geq 3$, and this is clearly 2-vertex-connected. Now, assume that $P\_i$ is 2-vertex-connected. We create $P\_{i+1}$ by adding the open ear $Q$ with distinct endpoints $u,v \in V(P\_i)$. Let $w$ be any vertex in $P\_{i+1}$. We need to show that $P\_{i+1}-w$ is connected. If $w$ is an "internal" vertex of the new ear $Q$, then $Q-w$ breaks into two components, but both are attached to $P\_i$. Since $P\_i$ is unaffected and still connected, the entire graph remains connected. Now, if $w \in V(P\_i)$, then $P\_i-w$ is connected by our inductive hypothesis. $Q$ has endpoints $u,v$, and even if $w=u$, the ear is still connected to $P\_i$ at $v$ (since $u$ and $v$ are distinct), and so the vertices of $Q$ stay connected to the graph.
\end{direction}
\end{adjustwidth}
(c) We will prove both directions.
\begin{adjustwidth}{2em}{0pt}
\begin{direction}($\Rightarrow$) Assume $G$ is factor-critical.
% ...
\end{direction}
\begin{direction}($\Leftarrow$) Assume $G$ has an odd ear-decomposition.
We will proceed inductively. $P\_0$ is an odd cycle $C\_{2k+1}$. Then, removing any vertex $v$ leaves a path $Q\_{2k}$, which has a perfect matching (since we can take alternate edges and add it to the matching). Thus, $P\_0$ is factor-critical. Now, assume that $P\_i$ is factor-critical. We create $P\_{i+1}$ by adding $Q$ where $Q$ is an odd ear. We need to show that for any $x in V(P\_{i+1})$, $P\_{i+1}-x$ has a perfect matching. We can proceed with case work. For the first case, suppose $x \in V(P\_i)$. Since $P\_i$ is factor-critical, $P\_i-x$ has a perfect matching $M$. The ear $Q$ has an odd number of edges, and thus has an even number of internal vertices. The path $Q$, excluding the endpoints, consists of disjoint edges convering all internal vertices. Let this matching be $M\_Q$. Then $M \cup M\_Q$ is a perfect matching of $P\_{i+1}-x$. For the second case, assume $x$ is an internal vertex of $Q$. Here, removing $x$ splits $Q$ into two paths, $Q\_1$, which is attached to $u$, and $Q\_2$, which is attached to $v$, where $u,v$ are distinct endpoints of the path. Since the total edges in $Q$ was odd, one of these paths has an odd length (with even vertices), and the other has even length (with odd vertices). We can match all vertices in $Q\_1$ internally except the endpoint $u$ and we can match all the vertices in $Q\_2$ similarly. Now, we need to match $u$ inside $P\_i$. Since $P\_i$ is factor-critical, $P\_i-u$ has a perfect matching $M'$. Combing these will then give a perfect matching for $P\_{i+1}-x$.
\end{direction}
\end{adjustwidth}

## Problem 3
[(a)]
- Prove that a connected graph $G=(V,E)$ is 2-edge-connected if and only if for every edge $e \in E$ there exists a cycle in $G$ containing $e$.
- Prove that a connected graph $G$ is 2-vertex-connected if and only if for every pair of edges $e,f \in E$ there exists a cycle in $G$ containing both $e$ and $f$.

**Proof**

Firstly, consider the following claim:
\begin{claim*}
In a 2-vertex-connected graph $G$, for any cycle $C$ and any vertex $z \notin V(C)$, there exist two internally vertex-disjoint paths from $z$ to $C$ whose endpoints on $C$ are distinct.
\end{claim*}
\begin{claimproof}
If every $z-C$ path met $C$ at the same vertex $v$, then removing $v$ would separate $z$ from the rest of the graph, contradicting 2-vertex-connectivity.
\end{claimproof}
(a) We will prove both directions.
\begin{adjustwidth}{2em}{0pt}
\begin{direction}($\Rightarrow$) Assume $G$ is 2-edge-connected. Then, for any edge $e$, $G-e$ is still connected. This means that $e$ is not a bridge (cut-edge). Note that an edge is a bridge when it does not lie on any cycle, and thus, every edge lies on some cycle.
\end{direction}
\begin{direction}($\Leftarrow$) Suppose that for every edge $e \in E$, there exists a cycle in $G$ containing $e$. Let $e=uv$ be an arbitrary edge. Since $e$ lies on a cycle $C$, there is a path in $C$ from $u$ to $v$ that does not use $e$. Thus even after removing $e$ there remains a $u$-$v$ path, and so $G-e$ is still connected. Since this holds for every $e$, $G$ is 2-edge-connected.
\end{direction}
\end{adjustwidth}
(b) We will prove both directions.
\begin{adjustwidth}{2em}{0pt}
\begin{direction}($\Rightarrow$) Assume $G$ is $2$-vertex-connected. Take two edges $e$ and $f$. By the same argument in part (a) every edge lies on some cycle. So, pick a cycle $C$ that contains $e$. If $f$ is on $C$, then we are done. Else, let $f = xy$ be an edge not on $C$. Apply our above claim to the endpoints $x$ and $y$ relative to $C$. Thus, we have that
[1)]
- There exist two internally disjoint paths from $x$ to $C$ meeting $C$ at some vertex $p$
- There exist two internally disjoint paths from $y$ to $C$ meeting $C$ at
some vertex $q$.
If we can choose those paths so that the attachment vertices $p$ and $q$ on $C$ are distinct, then we can take the edge of $C$ that is between $p$ and $q$ that contains the edge $e$ (one of the two edges between $p$ and $q$ along the cycle must contain $e$). Concatenating that edge with the two paths from $x$ and $y$ to $p$ and $q$ and the edge $xy$ creates a cycle that contains both $e$ and $f$.
Now we need to eliminate the possibility that every choice of $x$-$C$ and $y$-$C$ paths meet $C$ only at the same vertex $r$. If that were the case, removing $r$ would then separate $x$ (and $y$) from the cycle $C \setminus \{r\}$, so $r$ would be a cut-vertex of $G$, contradicting our 2-vertex-connectivity property. Thus, we can choose paths with distinct endpoints on $C$, and the argument above completes the proof that some cycle contains both $e$ and $f$.
\end{direction}
\begin{direction}($\Leftarrow$)
Suppose that for every pair of edges $e,f$ there is a cycle containing both. We will show $G$ has no cut-vertex. Suppose, for the sake of contradiction, that $v$ is a cut-vertex. Then, there are at least two components in $G - v$. Now, pick two distinct components $A$ and $B$ and then pick edges $e$ and $f$ with $e$ entirely inside $A \cup \{v\}$ and $f$ entirely inside $B \cup \{v\}$. This is possible because each component has at least one edge unless it is a single isolated vertex. If a component is a single vertex, then pick the other component that has an edge. Any cycle that contains both $e$ and $f$ would have to then contain $v$ and also include a path from $A$ to $B$ avoiding $v$, which is impossible because $v$ separates $A$ and $B$. This contradiction shows no cut-vertex exists, so $G$ is 2-vertex-connected.
\end{direction}
\end{adjustwidth}

## Problem 4
Let $G=(V,E)$ be a 2-edge-connected 3-regular graph. Prove that $G$ admits a perfect matching.

**Proof**

Let

$$
\begin{aligned}
D(G) &= \{ v \in V \mid \exists a maximum matching  M s.t.  v is not covered by  M \}
A(G) &= \Gamma(D(G)) \setminus D(G)
\end{aligned}
$$

Now, for the sake of contradiction, assume $G$ does not have a perfect matching. Since there are vertices that must be left out of any matching, we know that $D(G)$ is not empty. Now, let $D = D(G)$ be the set of vertices missed by at least one maximum matching and let $A = N(D) \setminus D$ be the neighbors of $D$ in the rest of the graph. Then let $K\_1, K\_2, \dots, K\_q$ be the connected components of the subgraph formed by the vertex set $D$. By Gallai's Lemma, each of these components must then be factor-critical. This means that $\|V(K\_i)\|$ is odd, since removing 1 vertex produces a perfect matching, and there are no edges between $D$ and the rest of the graph except for those going to $A$. Now, we can count the number of edges $m$ connecting the set $D$ and the set $A$. For any component $K\_i \subseteq D$, since $G$ is 3-regular, we have that $\sum\_{v \in K\_i} \deg(v) = 3\|K\_i\|$. Moreover, since $\|K\_i\|$ is odd, this sum is odd. Additionally, The sum of degrees is also equal to $2 \cdot (edges inside  K\_i) + (edges leaving  K\_i)$. The sum being odd implies that the number of edges leaving $K\_i$ must then be odd. We know that since $G$ is 2-edge-connected (implying there are no bridge edges, see problem 2), the number of edges leaving $K\_i$ cannot then be 1. Thus, there are at least 3 edges leaving every component $K\_i$. If we let $q$ be the number of connected components in the set $D(G)$ and $m$ be the number of edges connecting the set $D$ to the set $A$, we then have that $m \ge 3q$. Furthermore, these $m$ edges must connect to vertices in $A$. Since $G$ is 3-regular, the vertices in $A$ can take at most 3 edges each, and so we have that $m \le 3\|A\|$. Combining the bounds, we have that $3q \le m \le 3\|A\|$, which implies that $q \le \|A\|$. However, we know that from the definition of maximum matchings that if we delete $A$, the graph breaks into the components $K\_i$. A maximum matching must match vertices in $A$ to vertices in distinct components of $D$, which leaves at least $q - \|A\|$ vertices unmatched. Since we originally assumed $G$ has no perfect matching, we have that $q - \|A\| > 0$ and thus, $q > \|A\|$, which is a contradiction. Thus, our assumption was false, and $G$ must therefore have a perfect matching.

## Problem 5
Let $G$ be a graph on $n$ vertices with minimum degree at least $n/2$. Show that if $n$ is even, $G$ contains a perfect matching.

**Proof**

Note that if $n=2$, we have $G=K\_2$, which trivially has a perfect matching. So now suppose that $n \geq 3$. Since we have that for all $n$ vertices $v \in G$, $d(v) \geq \frac{n}{2}$, we satisfy Dirac's condition, which then implies that there exists a Hamiltonian cycle $C$ in $G$. Let the vertices of this cycle in order be $v\_1, v\_2, \dots, v\_{2k}$. We can proceed through this cycle and select every alternating edge to construct the matching $M = \{ (v\_1, v\_2), (v\_3, v\_4), \dots, (v\_{2k-1}, v\_{2k}) \}$. Since the cycle covers all vertices exactly once, the set $M$ hits every vertex exactly once. Thus, $M$ is a perfect matching.

# Problem Set 8

## Problem 1
Determine the chromatic number of the complement of a cycle on $n$ vertices.

**Proof**

Let $C\_n$ be the cycle on $n$ vertices. We know that a proper coloring of the complement graph $\overline{C\_n}$ assigns different colors to vertices that are adjacent in $\overline{C\_n}$. Vertices are adjacent in $\overline{C\_n}$ if and only if they are not adjacent in $C\_n$. Therefore, a set of vertices can share the same color in $\overline{C\_n}$ if and only if they are "pairwise non-adjacent" in $\overline{C\_n}$, which means they must be "pairwise adjacent" (or the same vertex) in $C\_n$. So a valid color class in $\overline{C\_n}$ corresponds to a complete subgraph (clique) in $C\_n$. The only cliques in a cycle $C\_n$ ($n \ge 4$) are single vertices ($K\_1$) and edges ($K\_2$). There are no cliques of size 3 or larger. Thus, coloring $\overline{C\_n}$ is equivalent to partitioning the vertex set $V$ into disjoint edges and vertices. To minimize the number of colors (cliques), we must maximize the number of vertices paired up into edges. Let $k$ be the number of edges ($K\_2$) used in the partition. These edges must be disjoint, so $k$ cannot exceed the matching number $\nu(C\_n) = \lfloor \frac{n}{2} \rfloor$. The remaining $n - 2k$ vertices must be colored individually (as $K\_1$s). The total number of colors used is $\chi(\overline{C\_n}) = k + (n - 2k) = n - k$. To minimize this quantity, we must maximize $k$. We choose a maximum matching, so $k = \lfloor \frac{n}{2} \rfloor$, and thus the chromatic number $ \chi(\overline{C\_n}) = n - \lfloor \frac{n}{2} \rfloor = \lceil \frac{n}{2} \rceil $. For $n=1$, we have that $\overline{C\_n}$ is a single vertex, so the chromatic number is $1=\lceil \frac{1}{2} \rceil$. For $n=2$, we have that $\overline{C\_2}$ consists of 2 vertices with no edge between them, so the chromatic number is $1=\lceil \frac{2}{2} \rceil$. For $n=3$, we have $C\_3$, which is a triangle $K\_3$, and the complement $\overline{C\_3}$ is the empty graph on 3 vertices ($3K\_1$), where chromatic number is $\chi(\overline{C\_3}) = 1 \neq \lceil \frac{3}{2} \rceil$, which is the only exception. Thus, the chromatic number of the complement of a cycle on $n$ vertices is $\lceil \frac{n}{2} \rceil $ for all $n \neq 3$, and when $n=3$, the chromatic number is $1$.

## Problem 2
Let $G$ be a bipartite graph. Prove that for its complementary graph $\overline{G}$ we have $\chi (\overline{G}) = \omega(\overline{G})$.

**Proof**

Let $G$ be a bipartite graph with $n$ vertices. First, observe that a clique in $\overline{G}$ corresponds to an independent set in $G$. Thus, the "clique number" (the size of the largest clique) of the complement is the independence number of the original graph, $\omega(\overline{G}) = \alpha(G)$. Next, consider the chromatic number $\chi(\overline{G})$. As shown in the proof for Problem 1, a valid coloring of $\overline{G}$ partitions the vertices of $G$ into cliques of $G$. Since $G$ is bipartite, it contains no cliques of size 3 or greater. Thus, we are partitioning the vertices into disjoint edges and single vertices. If we select a matching $M$ of size $\|M\|$ in $G$, we can use the edges of $M$ as $\|M\|$ color classes. The remaining $n - 2\|M\|$ vertices must be colored individually. The total number of colors is $ \|M\| + (n - 2\|M\|) = n - \|M\| $. To find the chromatic number, we need to minimize this sum, which is the same as maximizing the matching size $\|M\|$. Thus, we use a maximum matching $\nu(G)$, and so $ \chi(\overline{G}) = n - \nu(G) $. In any bipartite graph, the size of the maximum independent set plus the size of the maximum matching equals the total number of vertices, so $ \alpha(G) + \nu(G) = n \implies \alpha(G) = n - \nu(G)$. Combining our results yields $ \chi(\overline{G}) = n - \nu(G) = \alpha(G) = \omega(\overline{G}) $.

## Problem 3
Draw some lines in the plane so that no three of them go through the same point. Consider their points of intersection as the vertices of a graph and the segments between neighbouring intersection points on each line as edges. Prove that the chromatic number of the resulting graph is at most $3$.

**Proof**

Let the graph created from the process be $G=(V,E)$. The vertices $V$ are the intersection points of the lines. We know that two vertices are connected by an edge if they are consecutive intersection points along one of the lines. Assume that no lines are vertical (since we can rotate the plane a tiny amount if needed). This allows us to order the vertices by their $x$-coordinate. We will show that every subgraph has a vertex of degree at most 2, which would imply that the graph is $3$-colorable. Suppose we have the vertex ordering $v\_1, v\_2, \dots, v\_n$ based on increasing $x$-coordinates. Any vertex $v\_i$ is the intersection of exactly two lines, say $L\_a$ and $L\_b$. Looking to the right of $v\_i$ (vertices with higher index), the line $L\_a$ continues to its next intersection point, and $L\_b$ continues to its next intersection point. So $v\_i$ is connected to at most two vertices with an index higher than $i$. This ordering proves that $G$ is 2-degenerate. A coloring algorithm using the reverse of this order (coloring from $v\_n$ down to $v\_1$) ensures that when we color $v\_i$, it has at most 2 neighbors that have already been colored (its "future" neighbors in the $x$-ordering). Since there are 3 available colors, there is always a color free for $v\_i$. Thus, $\chi(G) \le 3$.

## Problem 4
For a positive integer $t$, let $f(t)$ denote the minimum number $k$ for which there exists a graph $G$ with $\chi(G) = t$ and $\|E(G)\| = k$. Determine the value of $f(t)$ for all positive integers $t$.

**Proof**

We want the minimum number of edges in a graph with chromatic number $t$. Consider a $t$-critical graph, that is, a graph $G$ with $\chi(G)=t$ such that removing any edge decreases the chromatic number. We know that in a $t$-critical graph, every vertex has degree at least $t-1$. Thus, for $n$ vertices, we have that $\|E(G)\| \ge \frac{n(t-1)}{2}$. Now, to minimize the number of edges, take the smallest number of vertices possible. A $t$-chromatic graph must have at least $t$ vertices, and the complete graph $K\_t$ achieves $\chi(K\_t)=t$ with $\|E(K\_t)\| = \frac{t(t-1)}{2}$. Thus, for all positive integers $t$, $f(t) = \frac{t(t-1)}{2}$

## Problem 5
Let $G$ be a simple graph on $n$ vertices and $\overline{G}$ be its complementary graph. Prove that $\chi(G)\chi(\overline{G}) \geq n$.

**Proof**

Let $\chi(G)=a$ and $\chi(\overline G)=b$. Color $G$ with $a$ colors and $\overline G$ with $b$ colors. Here, each vertex is assigned an ordered pair $(i,j)$ where $i\in\{1,\dots,a\}$ is its $G$-color and $j\in\{1,\dots,b\}$ its $\overline G$-color. Note that two distinct vertices cannot share the same pair, since if they did, they would be in the same color class in both $G$ and $\overline G$, so they would be nonadjacent in both $G$ and $\overline G$, which is impossible. Therefore, each of the $n$ vertices receives a distinct pair, giving $ab \ge n$. Thus, $\chi(G)\chi(\overline G) \ge n$.

# Problem Set 9

## Problem 1
Prove that if $G$ is a graph on $11$ vertices then at least one of $G$ and its complementary graph $\overline{G}$ is not planar.

**Proof**

We proceed by contradiction. Assume that both $G$ and its complement $\overline{G}$ are planar graphs. Let $n = 11$ be the number of vertices and let $m$ be the number of edges in $G$. The number of edges in the complement $\overline{G}$ is the total number of possible edges in $K\_{11}$ minus $m$, so $ \|E(\overline{G})\| = \binom{11}{2} - m = 55 - m $. Now, note that for a graph with $n \ge 3$ vertices to be planar, we need that $\|E\| \le 3n - 6$. Since we assumed that $G$ is planar, we have that $ m \le 3(11) - 6 = 27 $, and since we assumed $\overline{G}$ is planar, we have that  $55 - m \le 3(11) - 6 = 27 $. Now, summing these two inequalities yields $ m + (55 - m) \le 27 + 27 \implies 55 \le 54 $, which is a contradiction. Therefore, the assumption that both graphs are planar must be false, and so at least one of them must be non-planar. Thus, if $G$ is a graph on $11$ vertices then at least one of $G$ and its complementary graph $\overline{G}$ is not planar.

## Problem 2
What is the minimum number of edge crossings with which the graph $K\_{4,4}$ can be drawn on the plane?

**Proof**

Let $c$ be the crossing number of $K\_{4,4}$. If we remove $c$ edges from the graph (one edge from each crossing), we get a planar subgraph $G'$. The graph $K\_{4,4}$ is a bipartite graph with $n=8$ vertices and $m=16$ edges. The planar subgraph $G'$ will have $m' = 16 - c$ edges. Now, for any bipartite planar graph with $n \ge 3$, the number of edges satisfies $\|E\| \le 2n - 4 $. If we apply this to $G'$, we have that $ 16 - c \le 2(8) - 4 \implies c \ge 4 $, and so the crossing number is at least 4. Thus, the minimum number of edge crossings with which the graph $K\_{4,4}$ can be drawn on the plane is 4.

## Problem 3
Determine the edge-chromatic number of the $d$-dimensional hypercube $Q\_d$, where the vertices of $Q\_d$ correspond to the elements of $\{0, 1\}^d$ and two vertices are connected if their Hamming distance is $1$.

**Proof**

We will first discuss some properties of the graph $Q\_d$. Since vertices correspond to the elements of $\{0, 1\}^d$, we have that $\|V(Q\_d)\|=2^d$, and $\|E(Q\_d)\|=d(2^{d-1})$. We will proceed by induction on $d$. For the base case where $d=1$, the graph $Q\_1$ is a single edge, which requires 1 color. Thus, $\chi'(Q\_1) = 1$. Now for the inductive step, assume $\chi'(Q\_d) = d$. The graph $Q\_{d+1}$ consists of two copies of $Q\_d$. By the inductive hypothesis, we can color the edges within both copies using $d$ colors. The edges that connect the two copies join each vertex in the first copy to its corresponding vertex in the second. Since these connecting edges are a perfect matching, we can assign all of them a single new color, $d+1$. Thus, we have colored $Q\_{d+1}$ with $d+1$ colors. Since every vertex has degree $d+1$, we cannot use fewer colors. Therefore, $\chi'(Q\_{d+1}) = d+1$.

## Problem 4
Prove that $R(3, 3) = 6$, where $R(k, \ell)$ denotes the Ramsey number corresponding to $k$ and $\ell$.

**Proof**

We first claim that there exists a coloring $K\_5$ with neither a red triangle nor a blue triangle, implying that $R(3,3) > 5$. Consider the following colored $K\_5$ with no red triangles or blue triangles.
{% raw %}
\begin{center}
\begin{tikzpicture}[scale=1, every node/.style={circle, fill, inner sep=2pt, draw=none}]
\def\n{5}
\def\radius{2.5cm}
\def\startangle{90+360/5}
\def\step{360/\n}
\foreach \i in {0,...,4} {%
\edef\nodename{v\i}%
\node (\nodename) at ({\startangle - \step*\i}:\radius) {};%
}
\draw[blue, very thick] (v0) -- (v1);
\draw[red, very thick] (v0) -- (v2);
\draw[red, very thick] (v0) -- (v3);
\draw[blue, very thick] (v0) -- (v4);
\draw[blue, very thick] (v1) -- (v2);
\draw[red, very thick] (v1) -- (v3);
\draw[red, very thick] (v1) -- (v4);
\draw[blue, very thick] (v2) -- (v3);
\draw[red, very thick] (v2) -- (v4);
\draw[blue, very thick] (v3) -- (v4);
\end{tikzpicture}
\end{center}
{% endraw %}
Now, we claim that $R(3,3) \leq 6$ (Note: We can prove this easier by considering the fact that $R(k, \ell) \leq R(k, \ell - 1) + R(k-1, \ell)$. Applying the result here yields $R(3, 3) \leq R(3,2) + R(2,3)$. Trivially, we know that $R(2,3) = R(3,2) = 3$, and thus $R(3, 3) \leq 3 + 3 = 6$. However, from the wording of Problem 5, I assume an explicit argument is desired). Consider a complete graph $K\_6$ where every edge is colored either red or blue. We will show that there exists either a red triangle or a blue triangle. First, pick any vertex $v$ in the graph. Since the graph is $K\_6$, vertex $v$ is incident to 5 edges. By the Pigeonhole Principle, since there are 5 edges and only 2 colors, at least $\lceil 5/2 \rceil = 3$ edges incident to $v$ must be of the same color. Assume that there are three edges incident to $v$ that are colored blue (without loss of generality) and let the other endpoints of these edges be $u\_1, u\_2,$ and $u\_3$. Consider the edges connecting $u\_1, u\_2,$ and $u\_3$. There are two possible cases, either at least one edge among $\{u\_1, u\_2, u\_3\}$ is blue or none of the edges among $\{u\_1, u\_2, u\_3\}$ are blue. For the first case, suppose the edge $(u\_1, u\_2)$ is blue. Since the edges $(v, u\_1)$ and $(v, u\_2)$ are also blue (by our assumption), and so the vertices $\{v, u\_1, u\_2\}$ form a blue triangle. For the second case, if none of the edges among $\{u\_1, u\_2, u\_3\}$ are blue, then this implies that all edges connecting these vertices must be red, and so the edges $(u\_1, u\_2)$, $(u\_2, u\_3)$, and $(u\_3, u\_1)$ form a red triangle on the vertices $\{u\_1, u\_2, u\_3\}$. In both cases, the graph $K\_6$ contains a monochromatic triangle. Thus, $R(3,3) \leq 6$. Since $R(3,3) \leq 6$ and $R(3,3) > 5$, we have that $R(3,3) = 6$

## Problem 5
Show that $R(4, 3) \leq 10$ by proving that every red/blue coloring of the edges of $K\_{10}$ contains either a red $K\_4$ or a blue triangle.

**Proof**

We proceed by contradiction. Assume there exists a 2-coloring (Red and Blue) of the edges of the complete graph $K\_{10}$ that contains neither a red $K\_4$ nor a blue triangle ($K\_3$). Let $v$ be an arbitrary vertex in $K\_{10}$. Since the graph has 10 vertices, we have that $\deg(v)=9$. Let $R\_v$ be the set of neighbors connected to $v$ by red edges, and $B\_v$ be the set of neighbors connected to $v$ by blue edges. Thus, we have $ \|R\_v\| + \|B\_v\| = 9 $. Now, we know that $R(3,3) = 6$ and $R(4,2) = 4$. For the first case, suppose $\|B\_v\| \geq 4$. The subgraph induced by the vertices in $B\_v$ contains at least 4 vertices. Since $R(4,2)=4$, this subgraph must contain either a red $K\_4$ or a blue $K\_2$ (a blue edge). If it contains a red $K\_4$, we have found a red $K\_4$, else, if f it contains a blue edge between two neighbors $u, w \in B\_v$, then the vertices $\{v, u, w\}$ form a blue triangle (since edges $vu$ and $vw$ are blue). Since we assumed neither exists, we must have $\|B\_v\| \leq 3$. Now, for the second case, suppose $\|R\_v\| \geq 6$. The subgraph induced by the vertices in $R\_v$ contains at least 6 vertices. Since $R(3,3)=6$, this induced subgraph must contain either a red $K\_3$ or a blue $K\_3$. If it contains a blue $K\_3$, we have found a blue triangle, else if it contains a red $K\_3$ formed by neighbors $\{x, y, z\}$, then adding $v$ creates the set $\{v, x, y, z\}$ which forms a red $K\_4$ (since edges $vx, vy, vz$ are red). Since we assumed neither exists, we must have $\|R\_v\| \leq 5$. To avoid a contradiction, every vertex $v$ must satisfy both $\|B\_v\| \leq 3$ and $\|R\_v\| \leq 5$. Summing them up yields $\|R\_v\| + \|B\_v\| \leq 5 + 3 = 8 $, but we know the degree of $v$ is 9, and  $9 \leq 8 $, which is a contradiction. Therefore, no such coloring exists, and any 2-coloring of $K\_{10}$ must contain either a red $K\_4$ or a blue triangle. Thus, $R(4, 3) \leq 10$.
