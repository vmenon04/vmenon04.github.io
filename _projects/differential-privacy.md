---
layout: page
title: Differential Privacy in Federated Learning
date: 2025-04-29
excerpt: Integration of Differential Privacy into a Federated Learning framework using the MIMIC-IV dataset to enhance patient privacy while maintaining model performance.
links:
  paper: https://drive.google.com/file/d/1n5wjrJFd_ZJSXruSCWzGFrdw0Hc6p6cd/view
---

## Overview
This research project explored the integration of **Differential Privacy (DP)** into a **Federated Learning (FL)** framework, using the real-world MIMIC-IV intensive care dataset. The goal was to enhance patient privacy while maintaining model performance across heterogeneous client data distributions. We implemented the system in Python using **PyTorch** and **Flower**, focusing on privacy-preserving techniques like Gaussian noise injection and gradient clipping.

## Key Features
- **Federated Training Setup:** Simulated heterogeneous clients based on racial groupings to reflect real-world data skew.
- **Differential Privacy Integration:** Implemented **Distributed Differential Privacy (DDP)** with customizable epsilon budgets using Gaussian noise and clipping.
- **Data Engineering:** Managed over 100GB of patient records from MIMIC-IV using SQL and Power Query.
- **Performance Evaluation:** Analyzed trade-offs between model accuracy, convergence rate, and privacy loss.

## Code & Methodology
The system used **Flower** to coordinate federated training, and **PyTorch** for deep learning model definition and gradient tracking. Differential privacy mechanisms were applied client-side before aggregation to simulate a realistic decentralized system. All experiments were conducted with rigorous statistical analysis, and results were visualized across privacy parameters (ε) to assess utility degradation.
