# Zero inflated Poisson in 12.7
data {
  # number obs
  int n;
  int surv[n];
  int tanks_n;
  int<lower = 1, upper = tanks_n> tank[n];
  int density[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  vector[tanks_n] a_tank;
  real a;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector<lower = 0.0, upper = 1.0>[n] p;
  for (i in 1:n){
    p[i] = inv_logit(a_tank[tank[i]]);
  }
}
model {
  a ~ normal(a_mean, a_scale);
  sigma ~ cauchy(0.0, sigma_scale);
  a_tank ~ normal(a, sigma);
  surv ~ binomial(density, p);
}
