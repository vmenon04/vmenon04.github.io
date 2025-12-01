---
layout: page
title: Face Generator with GANs
date: 2025-05-09
excerpt: Using Deep Convolutional GANs to generate realistic celebrity face images, trained on 200,000 samples with PyTorch.
links:
  paper: /assets/docs/GAN_Attempt1.pdf
---

## Overview
This project explores the use of Generative Adversarial Networks (GANs) to generate realistic 64×64 pixel images of celebrity faces. A Deep Convolutional GAN (DCGAN) architecture was implemented and trained on a dataset of 200,000 celebrity face images.

## Key Achievements
- Designed and trained a DCGAN with convolutional layers for both Generator and Discriminator.
- Used Binary Cross-Entropy loss and the Adam optimizer with standard hyperparameters (α=0.0002, β1=0.5, β2=0.999).
- Trained over 20 epochs with batch size 128, observing typical GAN dynamics and identifying mode collapse in later stages.
- Visualized Generator outputs at various epochs to monitor progress in generating facial features.
