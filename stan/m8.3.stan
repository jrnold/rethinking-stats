data {
  # number obs
  int n;
  vector[n] y;
  real alpha_mean;
  real<lower = 0.0> alpha_sd;
  real<lower = 0.0> sigma_scale;
}
parameters {
  real alpha;
  real<lower = 0.0> sigma;
}
model {
  alpha ~ normal(alpha_mean, alpha_sd);
  sigma ~ cauchy(0.0, sigma_scale);
  y ~ normal(alpha, sigma);
}
