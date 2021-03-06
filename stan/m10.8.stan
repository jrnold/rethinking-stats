data {
  # number obs
  int n;
  int admit[n];
  int applications[n];
  int dept_id_max;
  int<lower = 1, upper = dept_id_max> dept_id[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
}
parameters {
  vector[dept_id_max] a;
}
transformed parameters {
  vector[n] mu;
  for (i in 1:n) {
    mu = a[dept_id];
  }
}
model {
  a ~ normal(a_mean, a_scale);
  admit ~ binomial_logit(applications, mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = binomial_rng(applications[i], inv_logit(mu[i]));
  }
}
