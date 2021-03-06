data {
  int n;
  vector[n] height;
  vector[n] weight;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real b_mean;
  real<lower = 0.0> b_scale;
  # sigma upper bound
  real sigma_upper;
}
parameters {
  real a;
  real b;
  # implicit uniform prior on sigma
  real<lower = 0.0, upper = sigma_upper> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + b * weight;
}
model {
  a ~ normal(a_mean, a_scale);
  b ~ normal(b_mean, b_scale);
  height ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
