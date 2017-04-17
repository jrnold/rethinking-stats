data {
  # number obs
  int n;
  vector[n] y;
  real a1_mean;
  real<lower = 0.0> a1_scale;
  real a2_mean;
  real<lower = 0.0> a2_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  real a1;
  real a2;
  real<lower = 0.0> sigma;
}
transformed parameters {
  real mu;
  mu = a1 + a2;
}
model {
  a1 ~ normal(a1_mean, a1_scale);
  a2 ~ normal(a2_mean, a2_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  y ~ normal(mu, sigma);
}
