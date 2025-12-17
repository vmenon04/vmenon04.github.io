---
layout: page
title: Learning Optimal Strategies in Kuhn Poker via Reinforcement Learning
date: 2025-12-17
excerpt: Training RL agents to learn a simplified version of poker called Kuhn Poker to examine whether agents can learn the optimal strategy.
math: true
---

*This project was completed as part of the Budapest Semesters in Mathematics Deep Learning Class (Autumn 2025), supervised by Pál Zsámboki at The Alfréd Rényi Institute of Mathematics.*

## Introduction

Kuhn Poker is a simplified version of poker designed by Harold W. Kuhn as a "fascinating problem for the game theoretician" {% cite kuhn1950simplified %}. It is a form of poker played between two players, with three possible hands and only a single round of betting. In fact, Kuhn showed that the game has a mixed-strategy Nash equilibrium, where both players can play equilibrium strategies.

The game proceeds as follows: a single card is dealt face-down to each of the two players from a three-card deck $\{J, Q, K\}$, leaving one card undistributed and unknown to both players.

Player 1 acts first and may either check or bet; subsequently, Player 2 may respond by checking, calling, or folding depending on the preceding action. There are only two rounds of betting for the first player and one for the second, and no further cards are dealt or public information revealed during play.

- If a pass occurs, the other player gets a chance to bet or pass.
- If a bet occurs, the other player gets a chance to respond by folding or calling.
- If a fold occurs, the remaining player immediately wins the pot.
- On a call, the cards are revealed at showdown, and the player holding the higher ranked card wins the pot.

| Player 1 | Player 2 | Player 1 | Payoff                         |
|----------|----------|----------|--------------------------------|
| Pass     | Pass     | —        | 1 to holder of higher card     |
| Pass     | Bet      | Pass     | 1 to Player 2                  |
| Pass     | Bet      | Bet      | 2 to holder of higher card     |
| Bet      | Pass     | —        | 1 to Player 1                  |
| Bet      | Bet      | —        | 2 to holder of higher card     |

In this project, we aim to train Reinforcement Learning (RL) models to learn the optimal solution. We chose Kuhn Poker as the variant of poker to study as it is much simpler. Other, more complex variants of poker have significantly more chance events and hidden information due to multi-round betting and public cards, resulting in exponentially larger game trees. As a result, they present a substantially more difficult learning problem for RL algorithms. Therefore, compared to other variants, Kuhn Poker is easier to study under the context of RL.

## Optimal Strategies in Kuhn Poker

Kuhn showed that there are infinitely many optimal strategies for the first player, each depending on the selection of a parameter $\alpha \in [0, 1/3]$. The existence of infinitely many optimal strategies for Player 1 arises from the ability to vary the bluffing frequency while maintaining the ratio of bluffs to value bets required to keep Player 2 indifferent.

For Player 1, the strategy is defined by the parameter $\alpha$, which represents the probability of betting with the weakest hand, the Jack. To prevent Player 2 from exploiting this bluff, Player 1 must balance it with value bets using the strongest hand, the King, at a ratio of 3:1.

- Jack: Bet with probability $\alpha$ (bluff) and check otherwise.
- Queen: Always check.
- King: Bet with probability $3\alpha$ (value) and check otherwise.

If Player 1 checks and Player 2 responds with a bet, Player 1 should call with a King, fold a Jack, and call with a Queen with probability $\frac{1}{3} + \alpha$ to prevent Player 2 from bluffing and making a profit.

Player 2 has a unique optimal strategy that does not depend on the value of $\alpha$ chosen by Player 1.

- If Player 1 bets: Player 2 acts to make Player 1 indifferent to bluffing: folding with a Jack, calling with a Queen with probability $\frac{1}{3}$, and always calling with a King.

- If Player 1 checks: Player 2 must bet for value while balancing with bluffs: betting with a Jack with probability $\frac{1}{3}$ (bluff), checking with a Queen, and betting with a King (value).

The interaction between these strategies results in the game value of $-1/18$ for Player 1. As $\alpha$ increases (Player 1 plays more aggressively), they capture more pots uncontested when Player 2 folds, but lose more often when Player 2 calls with a superior hand; these factors perfectly cancel out in equilibrium, giving Player 2 a game value of $+1/18$.

This characterization of the equilibrium strategies provides a clear target for learning: an RL agent should recover these mixed strategies purely through repeated interaction with the environment. We conduct two experiments:

1. Experiment 1 (Fixed Optimal Opponent): Player 2 is fixed to play the Nash equilibrium strategy, and we evaluate whether Player 1 learns the corresponding optimal response.

2. Experiment 2 (Self-Play): Player 1 and Player 2 are trained simultaneously through multi-agent self-play, with each agent learning solely from interactions with the other.

## Setup

Since Kuhn poker is a two-player game, the environment must accept actions from both players and return observations for each of them. A player can encounter only 12 possible states, given by the number of cards (3) multiplied by the number of non-terminal game histories (4). We therefore represent each state using a one-hot encoding. At each step, the environment outputs a pair of player states, the corresponding rewards for both players, and a single terminal flag indicating whether the game has ended.

Since the game has only 12 states and the model outputs a single probability between 0 and 1, we can use a simple fully connected architecture with no hidden layers. Specifically, we use a linear model of size $(12,1)$ followed by a sigmoid activation. The model therefore has 12 weights, each corresponding directly to the probability of betting or calling in a given state, which makes the model highly interpretable.

Explicitly, our model is as follows: 

$$y(x) = \sigma(w^\top s)$$

where $\sigma(x)=\frac{1}{1+e^{-x}}$ is the sigmoid activation function, $w \in \mathbb{R}^{12}$, and $s\in\{0,1\}^{12}$ is the one-hot encoded state vector.

## Experiment 1: Fixed Optimal Opponent

In the first experiment, we aim to encode the optimal strategy for Player 2 directly into its model and train a Player 1 through RL to test if Player 1 learns the corresponding optimal response.

### Coding Optimal Player 2

As discussed in the Setup, there is a one-to-one correspondence between game states and model weights. We manually set the model's weights so that, for each state, the output probability matches the optimal betting or calling behavior.Let $i = \arg\max_j s_j$ denote the active state index. Player 2 makes decisions only in states that follow either a check or a bet by Player 1.After Player 1 checks ($i \in \{3,4,5\}$):Player 2 chooses whether to bet. Writing $c = i - 3 \in \{J,Q,K\}$ for the card held by Player 2, the equilibrium betting probabilities are:

$$\pi_2^{\text{bet}}(c) =
\begin{cases}
    \tfrac{1}{3}, & c = J, \\
    0,            & c = Q, \\
    1,            & c = K.
\end{cases}$$

After Player 1 bets ($i \in \{9,10,11\}$):Player 2 chooses whether to call or fold. With $c = i - 9 \in \{J,Q,K\}$, the equilibrium calling probabilities are:

$$\pi_2^{\text{call}}(c) =
\begin{cases}
    0,            & c = J, \\
    \tfrac{1}{3}, & c = Q, \\
    1,            & c = K.
\end{cases}$$

All other states are unreachable for Player 2's decision process and are therefore never queried. This hard-coded policy directly implements the Nash equilibrium strategy

We initialize the optimal Player 2 and 100 instances of a model to learn the ideal Player 1 strategy. We give 3200 games and backpropagation every 32 games with a learning rate of 0.05. This is to ensure that the model will have a longer horizon thus can learn to bluff.

### Results

To quantify learning progress, we introduce a distance-to-optimality metric measuring how far a learned policy deviates from the Nash equilibrium strategy. Let $\gamma$ denote the model weight corresponding to betting with a King on the initial decision. Since the equilibrium strategies are parameterized by a single scalar, $\gamma$ uniquely determines the corresponding optimal policy.

Given $\gamma$, the ideal betting probabilities for Player 1 are:
- Initial move: $[\,\gamma/3,\; 0,\; \gamma\,]$ (for Jack, Queen, and King respectively)
- When Player 1 checked and Player 2 bets: $[\,0,\; (\gamma + 1)/3,\; 1\,]$

At each training step, we compute the squared error between the model’s predicted action probabilities and these ideal probabilities, $\lvert p_{\text{model}} - p_{\text{ideal}} \rvert^2$, and aggregate this quantity across all relevant states.

{% include figure.html 
   src="/assets/images/kuhnpoker_experiment1_overview.png" 
   alt="Experiment 1 Overview"
   caption="Overview of training dynamics across models from Experiment 1. The median (50th percentile) model exhibits a slight negative slope, indicating gradual movement toward the optimal strategy. However, the high variance across runs suggests that the loss landscape is unstable." 
%}

{% include figure.html 
   src="/assets/images/kuhnpoker_experiment1_heatmap.png" 
   alt="Experiment 1 Heatmap"
   caption="Learned betting probabilities for Player 1 from Experiment 1. One of the best-performing models learns to bluff with a Jack approximately one-third of the time ($\gamma \approx 1$). It also correctly learns to avoid betting with a Queen initially." 
%}


It is valuable to discuss that this experiment has several limitations. First, no hyperparameter tuning was performed, which may contribute to the observed instability. Second, the results are based on a relatively small batch of 100 independently trained models.

## Experiment 2: Self-Play

We use the same environment described in the previous section. In this experiment, we initialize 100 identical models and train them via self-play, with each model alternating between the roles of Player 1 and Player 2. When a model acts as Player $i \in \{1,2\}$, we define its policy-gradient loss as:

$$\ell_i = - \log(p)\,(r - r_{\mathrm{ema}})$$

where $p$ is the probability assigned by the policy to the action that was taken, $r$ is the realized reward, and $r_{\mathrm{ema}}$ is an exponential moving average of past rewards used as a baseline to reduce variance. The baseline is updated according to:

$$r_{\mathrm{ema}} \leftarrow 0.9\, r_{\mathrm{ema}} + 0.1\, r$$

The total loss for a self-play episode is given by $\ell = \ell_1 + \ell_2$. For all runs, we initialize the baseline to $r_{\mathrm{ema}} = -2$ for both players. Each model is trained for 3200 gradient steps, using a batch size of 32 and a learning rate of 0.05.

### Results

Because Kuhn poker is a zero-sum game, the sum of rewards obtained by a model when playing as Player 1 and Player 2 is always zero. Learning cannot rely on raw rewards alone. Using an exponential moving average baseline allows each model to compare its current performance against its own past behavior.

{% include figure.html 
   src="/assets/images/kuhnpoker_experiment2_overview.png" 
   alt="Experiment 2 Overview"
   caption="Overview of training in Experiment 2. The training overview plot shows consistent improvement across all models: even the lowest-performing runs exhibit a strongly negative slope in the distance-to-optimality metric." 
%}

Examining the heatmaps for Player 1 reveals that the model does not consistently learn to bluff with a Jack, a key component of the equilibrium strategy. This failure is likely attributable to limited training duration or insufficient exploration during self-play.

{% include figure.html 
   src="/assets/images/kuhnpoker_experiment2_p1_heatmap.png" 
   alt="Experiment 2 Player 1 Heatmap"
   caption="Player 1's heatmap in Experiment 2." 
%}

In contrast, the heatmaps for Player 2 show that the model learns several core aspects of the optimal strategy. In response to a bet by Player 1, the model learns to fold with a Jack, call with a King, and mix its response with a Queen. When Player 1 checks, the model learns to bet with a King and avoid betting with a Jack.

{% include figure.html 
   src="/assets/images/kuhnpoker_experiment2_p2_heatmap.png" 
   alt="Experiment 2 Player 2 Heatmap"
   caption="Player 2's heatmap in Experiment 2." 
%}

---

## References

{% bibliography --cited %}