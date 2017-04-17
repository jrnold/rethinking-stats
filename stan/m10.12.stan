data {
  # number obs
  int n;
  int total_tools[n];
  vector[n] log_pop;
  vector[n] contact_high;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bp_mean;
  real<lower = 0.0> bp_scale;
}
parameters {
  real a;
  real bp;
}
transformed parameters {
  vector<lower = 0.0>[n] lambda;
  lambda = log(a + bp * log_pop);
}
model {
  bp ~ normal(bp_mean, bp_scale);
  a ~ normal(a_mean, a_scale);
  total_tools ~ poisson(lambda);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = poisson_rng(lambda[i]);
  }
}
