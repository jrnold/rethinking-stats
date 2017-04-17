# same as 7.8
data {
  # number obs
  int n;
  vector[n] blooms;
  vector[n] water;
  vector[n] shade;
  real a_mean;
  real<lower = 0.0> a_scale;
  real bW_mean;
  real<lower = 0.0> bW_scale;
  real bS_mean;
  real<lower = 0.0> bS_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  real a;
  real bW;
  real bS;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bW * water + bS * shade;
}
model {
  sigma ~ cauchy(0.0, sigma_scale);
  a ~ normal(a_mean, a_scale);
  bW ~ normal(bW_mean, bW_scale);
  bS ~ normal(bS_mean, bS_scale);
  blooms ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
