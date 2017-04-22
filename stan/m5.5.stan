data {
  int n;
  vector[n] kcal_per_g;
  vector[n] neocortex_perc;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bn_mean;
  real<lower = 0.0> bn_scale;
  real sigma_scale;
}
parameters {
  real a;
  real bn;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bn * neocortex_perc;
}
model {
  a ~ normal(a_mean, a_scale);
  bn ~ normal(bn_mean, bn_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  kcal_per_g ~ normal(mu, sigma);
}
