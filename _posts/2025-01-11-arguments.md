---
layout: post
title: "Arguments"
date: 2026-01-11
excerpt: My thoughts on arguments.
math: true
---

## Change Your Mind

I'm a firm believer in changing your mind. When arguing, I find that a lot of people have their egos attached to the argument. Winning an argument raises their egos and losing drops it. In cases like this, arguments end up being a fight between humans. I find that this approach is flawed. Instead, arguments should be a battle between ideas, with the humans administering the fight.

If, while arguing, one finds that the opposing idea seems to be winning, it's in their best interest to change their mind, since, upon doing so, means that they have now taken a more "winning" position. Aligning with this new position means that they have a higher chance in winning subsequent arguments, so long as the original "winning" points are still kept. Ideally, if everyone follows this heuristic, then all humans will then converge on the "ultimate" idea, and they can then be sure that this idea is better than all other ones (until an even better idea is formed); however, in practice, this is likely not the case. Oftentimes, winning is not always aligned with truth, and arguments aren't good tests for truthful ideas. Ideas can win because they appeal to rhetoric, exploit biases, are more simple, etc. Also, it's very possible that the audience simply lacks background knowledge. Here, arguments win just because they exploit the fact that humans *perceive* victory, instead of impartially judging of an argument's evidential strength. In a way, [Goodhart's Law](https://en.wikipedia.org/wiki/Goodhart%27s_law) is a great application here: when winning an argument becomes the target, truth ceases to be the measure. In general, humans aren't perfect, and argument environments aren't perfect[^1]. Not everyone has equal information, and they don't always argue in good faith or are exposes to the same global counterarguments. "Convergence" is thus oftentimes local, which is why I think super smart communities of people can still disagree for long periods. Also, some ideas are super hard to argue in general, such as ethics, metaphysics. Humans just don't have the tools to reliably obtain indubitable evidence in these disciplines. 

Nonetheless, I do believe that generally following this heuristic would increase the probability of humans moving toward more robust beliefs over time.

## Updating on Bad Arguments

I would also like to reject an interesting epistemological argument I saw recently about [updating on bad arguments](https://guive.substack.com/p/updating-on-bad-arguments). It argues that although intuitively it may make sense that hearing a bad argument for some idea should not change your degree of belief in the view, it actually turns out that hearing a bad argument when you expected to hear a good one should provide evidence against the view. It uses a probabilistic argument as follows:

### The Argument:

Let $h := \neg x$ be the hypothesis my friend is arguing for, and suppose my prior $p(h)=0.1$. Let $e$ denote the event that my friend provides good evidence for $h$. The [law of total probability](https://en.wikipedia.org/wiki/Law_of_total_probability) suggests that 

$$p(h)=p(h∣e)p(e)+p(h∣\neg e)p(\neg e)$$

If I believed in advance that $p(h∣e)>p(h)$, then since the prior is a weighted average of the two conditional probabilities, it follows that 

$$p(h ∣ \neg e)<p(h)$$

In Bayesian updating, the [law of total expectation](https://en.wikipedia.org/wiki/Law_of_total_expectation) implies that the prior is equal to the expectation of the posterior, which implies that observing $\neg e$ must push the posterior below the prior if observing $e$ would have pushed it above, and thus, my friend's failure in providing a good argument provides evidence against $h$.

### Counterargument:

However, I disagree with this idea. I think that a bad argument being provided should be considered as no observation rather than as negative evidence. The above argument assumes that $p(e∣h) \neq p(e∣ \neg h)$, but I claim that instead, we should consider that $p(e∣h)=p(e∣ \neg h)$. If that holds, then we have that $p(e∣h)=p(e∣ \neg h)$ and thus, no update is needed. My friend providing a bad argument should result in an update to my own belief about my friend's reliability on this particular topic rather than a negative update on the idea itself.

## Arguments are Hard
Arguments are very noisy systems. Humans are also very noisy. Still, I do think that arguments, even when treated as imperfect, are still one of our best tools for refining our beliefs, but the important thing is that people do refine their beliefs. We should always consider the noisiness in such a system and the reliability of the arguer among other things, but we should *always* be willing to revise our positions when the ideas themselves (not the recitation of it) demand it. We should try to detach our egos and identities from the beliefs we believe.

[^1]: This post is itself an imperfect argument and should be treated accordingly.