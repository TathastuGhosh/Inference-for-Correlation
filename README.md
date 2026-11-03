# Inference for Correlation: A Simulation Study

A simulation-based comparison of three asymptotic methods for inference on the population correlation coefficient, focusing on normal approximation, hypothesis-testing power, and confidence interval performance using R.

## Overview

Inference for the population correlation coefficient is challenging because its sampling distribution has a complicated structure. This project investigates three asymptotic approaches to address this difficulty and evaluates their finite-sample performance through Monte Carlo simulations.

The study considers samples drawn from a **bivariate normal distribution** with varying sample sizes and population correlation coefficients.

## Methods Compared

Three standardized statistics are investigated:

- **T1 – Classical asymptotic approach:** Based on the asymptotic distribution of the sample correlation coefficient.
- **T2 – Fisher's transformation:** Uses the variance-stabilizing Fisher transformation.
- **T3 – Bias-corrected Fisher transformation:** Incorporates a bias correction to the Fisher-transformed statistic.

## Objectives

The simulation study focuses on three aspects of statistical inference:

1. **Normal Approximation:** Evaluates the closeness of the distributions of the three statistics to the standard normal distribution using the Kolmogorov–Smirnov (KS) distance.
2. **Hypothesis Testing:** Compares the power of tests based on the three statistics under different null and alternative correlation values.
3. **Confidence Intervals:** Examines empirical coverage probability and average interval length for the corresponding 95% confidence intervals.

## Simulation Design

| Component | Simulation settings |
|---|---|
| Sample sizes | 10, 30, 50, 100, 500 (normal approximation); 10, 30, 50, 100 (other analyses) |
| Population correlation | 0, 0.1, 0.3, 0.6, 0.9 (normal approximation) |
| Replications | 5,000 (normal approximation and confidence intervals); 2,000 (power analysis) |
| Confidence level | 95% |
| Significance level | 5% |

## Key Findings

- The bias-corrected statistic **T3** generally provides a better normal approximation, particularly for small samples and high population correlations.
- Fisher-transformed approaches (**T2 and T3**) demonstrate better power in several small-sample settings.
- Confidence intervals based on T2 and T3 generally maintain coverage closer to the nominal 95% level than those based on T1 in smaller samples.
- The differences among the three approaches tend to diminish as the sample size increases.

## Tools and Technologies

- **R** – Statistical computing and Monte Carlo simulation.
- **MASS** – Generation of multivariate normal samples.
- **tidyverse** – Data manipulation and visualization.
- **ggplot2** – Graphical representation of simulation results.
- **Quarto / LaTeX** – Report preparation and PDF generation.

## References

1. Gun, A. M., Gupta, M. K., and Dasgupta, B. *An Outline of Statistical Theory*, Volumes 1 and 2. World Press.
2. Rice, J. A. (2007). *Mathematical Statistics and Data Analysis*, 3rd Edition. Thomson Brooks/Cole.

---

**Course:** SDS755 – Statistical Inference  
**Department:** Statistics and Data Science  
**Institution:** Indian Institute of Technology Kanpur
