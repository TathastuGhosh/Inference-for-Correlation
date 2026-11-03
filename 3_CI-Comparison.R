

# ========================================================================================
# Comparison of CIs by three methods in terms of average length and coverage probability 
# ========================================================================================



set.seed(902)
n_grid = c(10, 30, 50, 100)
rho_grid = c(0, 0.3, 0.6, 0.9)
R = 5000
level = 0.95
z_crit = qnorm(1 - (1 - level) / 2)   # 1.96




ci_comp = function(n, rho, R, z_crit) {
  out = matrix(NA_real_, nrow = R, ncol = 6) # to store data for R replications
  Sigma = matrix(c(1, rho, rho, 1), nrow = 2)
  for (k in 1:R) {
    Z = mvrnorm(n, mu = c(0, 0), Sigma = Sigma)
    r = cor(Z[, 1], Z[, 2])
    # T1: delta-method interval
    se_T1   = (1 - r^2) / sqrt(n)
    T1_lower = r - z_crit * se_T1; T1_upper = r + z_crit * se_T1
    # T2: Fisher interval
    z_F   = atanh(r); se_F  = 1 / sqrt(n - 3)
    T2_lower = tanh(z_F - z_crit * se_F); T2_upper = tanh(z_F + z_crit * se_F)
    # T3: Bias corrected interval
    z_A   = z_F - r / (2 * (n - 1))
    T3_lower = tanh(z_A - z_crit * se_F); T3_upper = tanh(z_A + z_crit * se_F)
    coverage = c(
      T1_lower <= rho & rho <= T1_upper,
      T2_lower <= rho & rho <= T2_upper,
      T3_lower <= rho & rho <= T3_upper
    )                                        # checks rho is in the CI or not
    lengths = c(
      T1_upper - T1_lower,
      T2_upper - T2_lower,
      T3_upper - T3_lower
    )                                        # lengths of CI
    out[k, ] = c(coverage, lengths)
  }
  data.frame(Statistic = c("T1", "T2", "T3"), coverage  = colMeans(out[, 1:3]),
             mean_length = colMeans(out[, 4:6])
  )
}



ci_table = data.frame()
for (n in n_grid) {
  for (rho in rho_grid) {
    temp = ci_comp(n, rho, R, z_crit)
    ci_table = rbind(ci_table, data.frame(
      n = n, rho = rho,
      Statistic = temp$Statistic,
      coverage  = temp$coverage,
      mean_length = temp$mean_length
    ))
  }
}



coverage_plot = ggplot(ci_table,aes(x = n, y = coverage,colour = Statistic)) +
  geom_line(linewidth = 0.8) + geom_point(size = 1.6) +
  geom_hline(yintercept = level, linetype = "dashed") +
  facet_wrap(~ rho, labeller = label_bquote(rho == .(rho))) +
  scale_colour_manual(values = c(T1 = "black", T2 = "red", T3 = "blue")) +
  labs(x = "Sample size",
       y = "Empirical coverage probability",
       colour = "Confidence interval") +
  theme_bw() +
  theme(legend.position = "bottom")

print(coverage_plot)




length_plot = ggplot(ci_table, aes(x = n, y = mean_length,colour = Statistic)) +
  geom_line(linewidth = 0.8) + geom_point(size = 1.6) +
  facet_wrap(~ rho, labeller = label_bquote(rho == .(rho))) +
  scale_colour_manual(values = c(T1 = "black", T2 = "red", T3 = "blue")) +
  labs(x = "Sample size", y = "Average confidence interval length", 
       colour = "Confidence interval") +
  theme_bw() + theme(legend.position = "bottom")
print(length_plot)















