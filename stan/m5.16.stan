data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  vector[n] clade_NWM;
  vector[n] clade_OWM;
  vector[n] clade_S;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real b_OWM_mean;
  real<lower = 0.0> b_OWM_scale;
  real b_NWM_mean;
  real<lower = 0.0> b_NWM_scale;
  real b_S_mean;
  real<lower = 0.0> b_S_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real b_NWM;
  real b_OWM;
  real b_S;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + b_NWM * clade_NWM + b_OWM * clade_OWM + b_S * clade_S;
}
model {
  a ~ normal(a_mean, a_scale);
  b_NWM ~ normal(b_NWM_mean, b_NWM_scale);
  b_OWM ~ normal(b_OWM_mean, b_OWM_scale);
  b_S ~ normal(b_S_mean, b_S_scale);
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
