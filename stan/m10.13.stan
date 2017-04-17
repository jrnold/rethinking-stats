data {
  # number obs
  int n;
  int total_tools[n];
  vector[n] contact_high;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bc_mean;
  real<lower = 0.0> bc_scale;
}
parameters {
  real a;
  real bc;
}
transformed parameters {
  vector<lower = 0.0>[n] lambda;
  lambda = log(a + bc * contact_high);
}
model {
  bc ~ normal(bc_mean, bc_scale);
  a ~ normal(a_mean, a_scale);
  total_tools ~ poisson(lambda);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = poisson_rng(lambda[i]);
  }
}
