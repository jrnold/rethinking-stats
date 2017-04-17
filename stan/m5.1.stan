data {
  # number obs
  int n;
  vector[n] Divorce;
  vector[n] MedianAgeMarriage_s;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bA_mean;
  real<lower = 0.0> bA_scale;
  # sigma upper bound
  real sigma_scale;
}
parameters {
  real a;
  real bA;
  real<lower = 0.0> sigma;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + bA * MedianAgeMarriage_s;
}
model {
  a ~ normal(a_mean, a_scale);
  bA ~ normal(bA_mean, bA_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  Divorce ~ normal(mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = normal_rng(mu[i], sigma);
  }
}
