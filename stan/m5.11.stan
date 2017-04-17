data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  vector[n] perc_lactose;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bl_mean;
  real<lower = 0.0> bl_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real bl;
  real<lower = 0.0> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + bl * perc_lactose;
}
model {
  a ~ normal(a_mean, a_scale);
  bl ~ normal(bl_mean, bl_scale);
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
