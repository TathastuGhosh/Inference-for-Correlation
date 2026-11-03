

# ========================================================================================
# Power curves obtained by three methods for several values in the null and sample sizes
# ========================================================================================



library(MASS)
library(tidyr)
library(ggplot2)

set.seed(901)



run_power = function(rho0, n_grid = c(10, 30, 50, 100),R = 2000, cutoff = 1.645, k = 30) {
  alt_grid = seq(rho0, 1, length.out = k + 2)[-c(1, k + 2)] # 30 equispaced values
  power_results = data.frame()
  for (n in n_grid) {
    for (rho1 in alt_grid) {
      T_mat = matrix(NA_real_, nrow = R, ncol = 3)
      for (j in 1:R) {
        Z = mvrnorm(n, mu = c(0, 0),Sigma = matrix(c(1, rho1, rho1, 1), 2, 2))
        r = cor(Z[, 1], Z[, 2]); g = atanh(r)
        T_mat[j, ] = c(sqrt(n) * (r - rho0) / (1 - rho0^2), 
                       sqrt(n - 3) * (g - atanh(rho0)), 
                       sqrt(n - 3) * (g - atanh(rho0) - rho0 / (2 * (n - 1))))}
      power_results = rbind(power_results, data.frame(
        rho0 = rho0, n    = n, rho1 = rho1, T1   = mean(T_mat[, 1] > cutoff),
        T2   = mean(T_mat[, 2] > cutoff),T3   = mean(T_mat[, 3] > cutoff)
      ))}}
  power_results
}



plot_power = function(power_results) {
  power_long = pivot_longer(power_results, cols = c(T1, T2, T3),
                            names_to = "Statistic", values_to = "Power")
  ggplot(power_long,aes(x = rho1,y = Power,colour = Statistic)) +
    geom_line(linewidth = 0.8) + geom_point(size = 1.2) +
    facet_wrap(~ n, labeller = label_bquote(n == .(n))) +
    labs(x = expression(rho[1]), y = "Power") +
    scale_colour_manual(values = c(T1 = "black", T2 = "red", T3 = "blue")) +
    theme_bw() + theme(legend.position="bottom")
}



rho_values = c(0.1,0.3,0.6,0.9)
power_list = lapply(rho_values, run_power)

plot_power(power_list[[1]])
plot_power(power_list[[2]])
plot_power(power_list[[3]])
plot_power(power_list[[4]])
