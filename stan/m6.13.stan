data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  vector[n] mass;
}
parameters {
  real a;
  real bm;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bm * log(mass);
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
