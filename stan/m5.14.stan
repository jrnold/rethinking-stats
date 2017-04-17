data {
  # number obs
  int n;
  vector[n] h1;
  vector[n] h0;
  vector[n] treatment;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bh_mean;
  real<lower = 0.0> bh_scale;
  real bt_mean;
  real<lower = 0.0> bt_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real bh;
  real bt;
  real bf;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  mu = a + bh * h0 + bt * treatment;
}
model {
  a ~ normal(a_mean, a_scale);
  bh ~ normal(bh_mean, bh_scale);
  bt ~ normal(bt_mean, bt_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  h1 ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
