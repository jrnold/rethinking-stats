data {
  int n;
  vector[n] height;
  # priors
  real mu_mean;
  real<lower = 0.0> mu_scale;
  # sigma upper bound
  real sigma_upper;
}
parameters {
  real mu;
  # implicit uniform prior on sigma
  real<lower = 0.0, upper = sigma_upper> sigma;
}
model {
  mu ~ normal(mu_mean, mu_scale);
  height ~ normal(mu, sigma);
}
