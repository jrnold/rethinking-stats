# geometric(p) = neg_binom(1, p / (1 - p))
data {
  # number obs
  int n;
  int y[n];
  vector[n] x;
  real a_mean;
  real<lower = 0.0> a_scale;
  real b_mean;
  real<lower = 0.0> b_scale;
}
parameters {
  real a;
  real b;
}
transformed parameters {
  vector<lower = 0.0, upper = 1.0>[n] p;
  vector[n] beta;
  p = inv_logit(a + b * x);
  beta = p ./ (1.0 - p);
}
model {
  a ~ normal(a_mean, a_scale);
  b ~ normal(b_mean, b_scale);
  y ~ neg_binomial(1.0, beta);
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = neg_binomial_rng(1.0, beta[i]);
  }
}
