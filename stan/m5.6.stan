data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  vector[n] log_mass;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bm_mean;
  real<lower = 0.0> bm_scale;
  real sigma_scale;
}
parameters {
  real a;
  real bm;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bm * log_mass;
}
model {
  a ~ normal(a_mean, a_scale);
  bm ~ normal(bm_mean, bm_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  kcal_per_g ~ normal(mu, sigma);
}
