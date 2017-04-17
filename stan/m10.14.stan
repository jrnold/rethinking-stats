data {
  # number obs
  int n;
  int total_tools[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
}
parameters {
  real a;
}
transformed parameters {
  real<lower = 0.0> lambda;
  lambda = log(a);
}
model {
  a ~ normal(a_mean, a_scale);
  total_tools ~ poisson(lambda);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = poisson_rng(lambda);
  }
}
