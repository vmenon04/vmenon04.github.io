---
layout: post
title: "The Three Gods Riddle"
date: 2025-12-30
math: true
excerpt: Explaining the solution to the Three Gods Riddle.
---

I will aim to explain the solution to the Three Gods Riddle.

We have 3 Gods: T, F, and R.  
T always tells the truth. F always lies. R provides a random answer each time.  
Each of these Gods will only give you one response, either "Ozo" or "Ulu", signifying either Yes or No. Unfortunately, we do not know which is which. We are allowed to ask 3 questions total to any of the Gods. How can we deduce which God is which?

The key to this problem is asking the Gods a conditional statement. Consider the following question:  

> If I asked whether 1+1=2, would you answer Ozo?

Suppose Ozo = Yes. If T was asked whether $1+1=2$, it knows it would respond with the affirmative, Ozo. When asked whether or not it would answer Ozo to the question, his final response is Ozo. If F was asked whether $1+1=2$, it knows it would respond with the negative, Ulu. When asked whether or not it would answer Ozo to the question, his final response would be the affirmative, since it is a liar. Thus, both T and F would respond with Ozo.

Suppose Ozo = No. If T was asked whether $1+1=2$, it knows it would respond with the affirmative, Ulu. When asked whether or not it would answer Ozo to the question, it would respond with the negative, Ozo.  
If F was asked whether $1+1=2$, it knows it would respond with the negative, Ozo. When asked whether or not it would answer Ozo to the question, it would respond with the negative, Ozo.

Thus, regardless of what Ozo means, when asked the carefully constructed question above, both T and F would respond with Ozo.

To further see the power of such a question, consider another question:  

> If I asked whether 1+1=3, would you answer Ozo?

It can be shown that regardless of what Ozo and Ulu mean, both T and F would respond with Ulu. In this way, we can deduce the truth value of the antecedent of our conditional, $1+1=2$ or $1+1=3$, based on the response of either T or F.

**If they respond with Ozo, then we know the antecedent is true. If they respond with Ulu, the antecedent is false.**

<!-- % If I asked whether 1+1=3, would you answer Ozo?

--------- Ozo = True ---------
T: Well, 1+1=3 is false, so I would answer with no = Ulu to that question.
So would I answer with Ozo? No , so  Ulu.

F: Well, 1+1=3 is false, so I would answer with yes = Ozo to that question.
So would I answer with Ozo? I mean yes I would, but I'm going to lie, so No, so Ulu

--------- Ozo = False ---------
T: Well, 1+1=3 is false, so I would answer with no = Ozo to that question.
So would I answer with Ozo? Yes , so  Ulu.

F: Well, 1+1=3 is false, so I would answer with yes = Ozo to that question. So would I answer with Ozo? I mean no, I wouldn't, but I'm going to lie, so Yes, so Ulu. -->

Now, we need to utilize this property to our advantage.

First, ask the alien in the middle the following question:

> If I asked you whether the alien on the left is R, would you answer Ozo?

If they respond with Ozo, we have two scenarios: either we have asked this question to R, or we asked it to T/F.  
Assume this question was asked to either T or F. Due to our powerful property, we can then deduce the truth value of our antecedent: whether the alien on the left is R. Since they responded with Ozo, then the alien to the left must be R.

Assume this question was asked to R. His response does not matter, but under this assumption, the alien in the middle is R. Under both exhaustive assumptions, we can deduce that the alien to the right is not R.

Similarly, if they respond with Ulu, we again have the two scenarios: either we have asked this question to R, or we asked it to T/F.  
Assume this question was asked to either T or F. We can then deduce the truth value of our antecedent: whether the alien on the left is R. Since they responded with Ulu, then the alien to the left is not R.  
Assume this question was asked to R. His response does not matter, but under this assumption, the alien in the middle is R. Under both exhaustive assumptions, we can deduce that the alien to the left is not R.

Thus, the answer to this first question will reveal to us a God that is not R, a God that is either T or F. Then we can ask another one of our carefully constructed conditionals to this God to deduce the truth value of its antecedent.

For our second question, we will ask the following question to that God:

> If I asked "are you F?" would you answer Ozo?

If they answer Ulu, then we know it is T that responded. If they answer Ozo, then we know it is F that responded.

For our third and final question, we will ask the same God the following:

> If I asked "is the center alien R?" would you answer Ozo?

If they answer Ulu, then we know that the center alien is not R. If they answer Ozo, then we know that the center alien is R.

We can deduce one god is either T or F (from Q1). We can identify which of T or F it is (from Q2). We can determine if the middle god is R or not (Q3). Therefore, we can deduce all roles by elimination. 