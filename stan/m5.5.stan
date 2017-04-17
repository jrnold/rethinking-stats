data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  vector[n] neocortex_perc;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bn_mean;
  real<lower = 0.0> bn_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real bn;
  real<lower = 0.0> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + bn * neocortex_perc;
}
model {
  a ~ normal(a_mean, a_scale);
  bn ~ normal(bn_mean, bn_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  kcal_per_g ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
