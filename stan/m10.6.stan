data {
  # number obs
  int n;
  int admit[n];
  int applications[n];
  vector[n] male;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bm_mean;
  real<lower = 0.0> bm_scale;
}
parameters {
  real a;
  real bm;
}
transformed parameters {
  vector[n] mu;
  mu = a + bm * male;
}
model {
  a ~ normal(a_mean, a_scale);
  bm ~ normal(bm_mean, bm_scale);
  admit ~ binomial_logit(applications, mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(applications[i], inv_logit(mu[i]));
  }
}
