# same model for m7.1 and m7.2
data {
  # number obs
  int n;
  vector[n] log_gdp;
  vector[n] rugged;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bR_mean;
  real<lower = 0.0> bR_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  real a;
  real bR;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bR * rugged;
}
model {
  sigma ~ cauchy(0.0, sigma_scale);
  a ~ normal(a_mean, a_scale);
  bR ~ normal(bR_mean, bR_scale);
  log_gdp ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
