# see 8.8
data {
  # number obs
  int n;
  int<lower = 2> K;
  int<lower = 1, upper = K> response[n];
  vector[n] action;
  vector[n] intention;
  vector[n] contact;
  # prior
  real bA_mean;
  real<lower = 0.0> bA_scale;
  real bI_mean;
  real<lower = 0.0> bI_scale;
  real bC_mean;
  real<lower = 0.0> bC_scale;
}
parameters {
  real bA;
  real bI;
  real bC;
  ordered[K - 1] a;
}
transformed parameters {
  vector[n] phi;
  phi = bA * action + bI * intention + bC * contact;
}
model {
  bA ~ normal(bA_mean, bA_scale);
  bI ~ normal(bI_mean, bI_scale);
  bC ~ normal(bC_mean, bC_scale);
  for (i in 1:n) {
    response[i] ~ ordered_logistic(phi[i], a);
  }
}
