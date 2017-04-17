data {
  # number obs
  int n;
  vector[n] Divorce;
  vector[n] Marriage_s;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bR_mean;
  real<lower = 0.0> bR_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real bR;
  real<lower = 0.0> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + bR * Marriage_s;
}
model {
  a ~ normal(a_mean, a_scale);
  bR ~ normal(bR_mean, bR_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  Divorce ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
