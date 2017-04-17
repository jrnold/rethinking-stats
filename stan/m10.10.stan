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
  real bpc_mean;
  real<lower = 0.0> bpc_scale;
  real bc_mean;
  real<lower = 0.0> bc_scale;
}
parameters {
  real a;
  real bp;
  real bc;
  real bpc;
}
transformed parameters {
  vector<lower = 0.0>[n] lambda;
  lambda = log(a + bp * log_pop + bc * contact_high + bpc * contact_high .* log_pop);
}
model {
  bpc ~ normal(bpc_mean, bpc_scale);
  bp ~ normal(bp_mean, bp_scale);
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
