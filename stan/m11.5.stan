# Zero inflated Poisson in 12.7
data {
  # number obs
  int n;
  int admit[n];
  int applications[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
}
parameters {
  real a;
  real<lower = 0.0> theta;
}
transformed parameters {
  real<lower = 0.0, upper = 1.0> p;
  p = inv_logit(a);
}
model {
  real alpha;
  real beta;
  alpha = p * theta;
  beta = (1 - p) * theta;
  a ~ normal(a_mean, a_scale);
  theta ~ exponential(1.0);
  admit ~ beta_binomial(applications, alpha, beta);
}
