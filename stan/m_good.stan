data {
  # number obs
  int n;
  int y[n];
  vector[n] x;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real b_mean;
  real<lower = 0.0> b_scale;
}
parameters {
  real a;
  real b;
}
transformed parameters {
  vector[n] mu;
  mu = a + b * x;
}
model {
  b ~ normal(b_mean, b_scale);
  a ~ normal(a_mean, a_scale);
  y ~ binomial_logit(1, mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(1, inv_logit(mu[i]));
  }
}
