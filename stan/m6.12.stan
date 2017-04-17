data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  vector[n] neocortex;
}
parameters {
  real a;
  real bn;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bn * neocortex;
}
model {
  kcal_per_g ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
