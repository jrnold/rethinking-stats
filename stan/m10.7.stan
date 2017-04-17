data {
  # number obs
  int n;
  int admit[n];
  int applications[n];
  vector[n] male;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
}
parameters {
  real a;
}
model {
  a ~ normal(a_mean, a_scale);
  admit ~ binomial_logit(applications, a);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(applications[i], inv_logit(a));
  }
}
