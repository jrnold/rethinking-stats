data {
  # number obs
  int n;
  vector[n] y;
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
  sigma ~ cauchy(0.0, sigma_scale);
  y ~ normal(mu, sigma);
}
