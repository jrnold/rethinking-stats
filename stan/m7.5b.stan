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
  real bAR_mean;
  real<lower = 0.0> bAR_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  real a;
  real bA;
  real bR;
  real bAR;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bR * rugged + bAR * rugged .* cont_africa + bA * cont_africa;
}
model {
  sigma ~ cauchy(0.0, sigma_scale);
  a ~ normal(a_mean, a_scale);
  bA ~ normal(bA_mean, bA_scale);
  bR ~ normal(bR_mean, bR_scale);
  bAR ~ normal(bA_mean, bA_scale);
  log_gdp ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
