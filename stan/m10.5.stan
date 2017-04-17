data {
  # number obs
  int n;
  int trials;
  int<lower = 0, upper = trials> x[n];
  vector[n] prosoc_left;
  vector[n] condition;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bp_mean;
  real<lower = 0.0> bp_scale;
  real bpC_mean;
  real<lower = 0.0> bpC_scale;
}
parameters {
  real a;
  real bp;
  real bpC;
}
transformed parameters {
  vector[n] mu;
  mu = a + (bp + bpC * condition) .* prosoc_left;
}
model {
  a ~ normal(a_mean, a_scale);
  bp ~ normal(bp_mean, bp_scale);
  bpC ~ normal(bpC_mean, bpC_scale);
  x ~ binomial_logit(trials, mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(trials, inv_logit(mu[i]));
  }
}
