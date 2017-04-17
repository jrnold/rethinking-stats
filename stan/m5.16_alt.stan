data {
  # number obs
  int n;
  vector[n] kcal_per_g;
  int clade_n;
  int<lower = 1, upper = clade_n> clade_id[n];
  # priors
  vector[clade_n] a_mean;
  vector<lower = 0.0>[clade_n] a_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  vector[clade_n] a;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector[n] mu;
  for (i in 1:n) {
    mu = a[clade_id];
  }
}
model {
  a ~ normal(a_mean, a_scale);
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
