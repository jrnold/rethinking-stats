data {
  # number obs
  int n;
  vector[n] y;
}
parameters {
  real mu;
  real<lower = 0.0> sigma;
}
model {
  y ~ normal(mu, sigma);
}
