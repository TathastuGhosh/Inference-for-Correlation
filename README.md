# 📊 Inference for Correlation: A Simulation Study

<p align="center">
  <img src="https://img.shields.io/badge/Language-R-blue?logo=r" />
  <img src="https://img.shields.io/badge/Statistical%20Computing-Simulation-purple" />
  <img src="https://img.shields.io/badge/Course-SDS755-orange" />
</p>

<p align="center">
  <i>A Monte Carlo simulation study comparing asymptotic methods for inference on the population correlation coefficient.</i>
</p>

---

## 🔍 About the Project

Inference for the population correlation coefficient is challenging because of the complicated structure of its sampling distribution. This project explores three asymptotic approaches and investigates their finite-sample performance through Monte Carlo simulations.

The study considers samples generated from a **bivariate normal distribution** with different sample sizes and population correlation coefficients.

## 🧮 Methods Under Investigation

Three standardized statistics are compared:

| Statistic | Method | Description |
|:---:|---|---|
| **T₁** | Classical approach | Based on the asymptotic distribution of the sample correlation coefficient. |
| **T₂** | Fisher's transformation | Uses a variance-stabilizing transformation. |
| **T₃** | Bias-corrected Fisher transformation | Incorporates a bias correction into Fisher's transformed statistic. |

## 🎯 Objectives

The project investigates three important aspects of correlation inference:

### 1. 📈 Normal Approximation
Evaluates the closeness of the distributions of T₁, T₂ and T₃ to the standard normal distribution using the **Kolmogorov–Smirnov (KS) distance**.

### 2. ⚡ Hypothesis-Testing Power
Compares the power of tests based on the three statistics under different null and alternative correlation values.

### 3. 📐 Confidence Interval Analysis
Evaluates the performance of the corresponding 95% confidence intervals using:
- Empirical coverage probability
- Average confidence interval length

## ⚙️ Simulation Design

| Component | Settings |
|---|---|
| Sample sizes | 10, 30, 50, 100, 500 (normal approximation) |
| Population correlations | 0, 0.1, 0.3, 0.6, 0.9 |
| Replications | 5,000 (normal approximation and CI); 2,000 (power) |
| Confidence level | 95% |
| Significance level | 5% |
| Data-generating distribution | Bivariate normal |

## 💡 Key Findings

- **T₃** generally provides a better normal approximation, particularly for small sample sizes and high population correlations.
- **T₂ and T₃** demonstrate better testing power in several small-sample settings.
- Confidence intervals based on **T₂ and T₃** generally maintain coverage closer to the nominal 95% level than those based on T₁ for smaller samples.
- The differences among the three approaches tend to diminish as the sample size increases.

## 🛠️ Tools & Technologies

<p>
  <img src="https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white" />
  <img src="https://img.shields.io/badge/ggplot2-447099?style=for-the-badge" />
  <img src="https://img.shields.io/badge/tidyverse-1A162D?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Quarto-39729E?style=for-the-badge" />
  <img src="https://img.shields.io/badge/LaTeX-008080?style=for-the-badge&logo=latex&logoColor=white" />
</p>

- **R:** Statistical computing and Monte Carlo simulation.
- **MASS:** Generation of multivariate normal samples.
- **tidyverse:** Data manipulation.
- **ggplot2:** Data visualization.
- **Quarto and LaTeX:** Report preparation.

## 📚 References

1. Gun, A. M., Gupta, M. K., and Dasgupta, B. *An Outline of Statistical Theory*, Volumes 1 and 2. World Press.
2. Rice, J. A. (2007). *Mathematical Statistics and Data Analysis*, 3rd Edition. Thomson Brooks/Cole.

---
