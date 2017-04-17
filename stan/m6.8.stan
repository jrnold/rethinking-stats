data {
  # number obs
  int n;
  vector[n] brain;
  vector[n] mass_s;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real b_mean;
  real<lower = 0.0> b_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real b;
  real<lower = 0.0> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + b * mass_s;
}
model {
  a ~ normal(a_mean, a_scale);
  b ~ normal(b_mean, b_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  brain ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
