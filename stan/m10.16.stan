data {
  # number obs
  int n;
  int career[n];
  # priors
  real b_mean;
  real<lower = 0.0> b_scale;
}
parameters {
  real b;
}
transformed parameters {
  vector[3] mu;
  mu[1] = 0.0;
  mu[2] = b * 2.0;
  mu[3] = b * 3.0;
}
model {
  b ~ normal(b_mean, b_scale);
  career ~ categorical_logit(mu);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = categorical_rng(softmax(mu));
  }
}
