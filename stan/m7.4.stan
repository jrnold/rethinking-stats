data {
  # number obs
  int n;
  vector[n] log_gdp;
  vector[n] rugged;
  vector[n] cont_africa;
  real a_mean;
  real<lower = 0.0> a_scale;
  real bR_mean;
  real<lower = 0.0> bR_scale;
  real bA_mean;
  real<lower = 0.0> bA_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  real a;
  real bR;
  real bA;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bR * rugged + bA * cont_africa;
}
model {
  sigma ~ cauchy(0.0, sigma_scale);
  a ~ normal(a_mean, a_scale);
  bR ~ normal(bR_mean, bR_scale);
  bA ~ normal(bA_mean, bA_scale);
  log_gdp ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
