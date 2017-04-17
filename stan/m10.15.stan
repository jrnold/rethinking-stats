data {
  # number obs
  int n;
  int y[n];
  vector[n] log_days;
  vector[n] monastery;
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
  vector<lower = 0.0>[n] lambda;
  lambda = log(log_days + a + b * monastery);
}
model {
  a ~ normal(a_mean, a_scale);
  b ~ normal(b_mean, b_scale);
  y ~ poisson(lambda);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = poisson_rng(lambda[i]);
  }
}
