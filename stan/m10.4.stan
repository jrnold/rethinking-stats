data {
  # number obs
  int n;
  int pulled_left[n];
  vector[n] prosoc_left;
  vector[n] condition;
  # values of actor
  int actor_n;
  int<lower = 1, upper = actor_n> actor[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bp_mean;
  real<lower = 0.0> bp_scale;
  real bpC_mean;
  real<lower = 0.0> bpC_scale;
}
parameters {
  vector[actor_n] a;
  real bp;
  real bpC;
}
transformed parameters {
  vector[n] mu;
  mu = a[actor] + (bp + bpC * condition) .* prosoc_left;
}
model {
  a ~ normal(a_mean, a_scale);
  bp ~ normal(bp_mean, bp_scale);
  bpC ~ normal(bpC_mean, bpC_scale);
  pulled_left ~ binomial_logit(1, mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(1, inv_logit(mu[i]));
  }
}
