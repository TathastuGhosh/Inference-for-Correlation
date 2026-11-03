

# ========================================================================================
# Normal approximation by three methods
# ========================================================================================


library(tidyverse)
library(MASS)

set.seed(901)

R = 5000                              # replication number

n_values = c(10, 30, 50, 100, 500)    # grid of n values
# 0 is included below to observe the size of the test

rho_values = c(0, 0.1, 0.3, 0.6, 0.9) # grid of rho values

KS_results = data.frame()



for (n in n_values) {
  for (rho in rho_values) {
    T_values = matrix(NA_real_, nrow = R, ncol = 3)
    for (k in 1:R) {
      Z = mvrnorm(n, mu = c(0, 0),Sigma = matrix(c(1,rho,rho,1),2,2)) # data generate
      r = cor(Z[,1], Z[,2]) # correlation
      g = atanh(r)     # 0.5*atan((1+r)/(1-r))
      g0 = atanh(rho)  # 0.5*atan((1+rho)/(1-rho))
      # Calculating three quantities
      T1 = sqrt(n)*(r-rho)/(1-rho^2)       
      T2 = sqrt(n-3)*(g-g0)
      T3 = sqrt(n-3)*(g-g0-rho/(2*(n-1)))
      T_values[k,] = c(T1, T2, T3)
    }
    
    D = apply(T_values, 2, function(x) {
      ks.test(x, "pnorm")$statistic
    }) # finding KS statistic for each quantity
    
    KS_results = rbind(KS_results, 
                       data.frame(n = n,rho = rho,Statistic = paste0("T", 1:3),
                                  KS_Distance = as.numeric(D)))
  }
}
print(KS_results)



ggplot(KS_results, aes(x = n, y = KS_Distance, 
                       colour = Statistic, group = Statistic)) +
  geom_line(linewidth = 0.8) + geom_point(size = 1.3) +
  scale_x_log10(breaks = n_values) +
  facet_wrap(~ rho, ncol = 2,
             labeller = label_bquote(rho == .(rho))) +
  labs(x = "Sample size", y = "KS distance", colour = "Statistic") + theme_bw()
