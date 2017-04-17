data {
  # number obs
  int n;
  vector[n] height;
  vector[n] male;
  # priors
  real am_mean;
  real<lower = 0.0> am_scale;
  real af_mean;
  real<lower = 0.0> af_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real af;
  real am;
  real<lower = 0.0> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = af * (1 - male) + am * male;
}
model {
  af ~ normal(af_mean, af_scale);
  am ~ normal(am_mean, am_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  height ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
