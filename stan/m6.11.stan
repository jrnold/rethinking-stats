data {
  # number obs
  int n;
  vector[n] kcal_per_g;
}
parameters {
  real a;
  real<lower = 0.0> sigma;
}
transformed parameters {
}
model {
  kcal_per_g ~ normal(a, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(a, sigma);
  }
}
