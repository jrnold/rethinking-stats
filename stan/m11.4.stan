# Zero inflated Poisson in 12.7
data {
  # number obs
  int n;
  int y[n];
  # priors
  real ap_scale;
  real<lower = 0.0> ap_scale;
  real al_scale;
  real<lower = 0.0> al_scale;
}
parameters {
  real ap;
  real al;
}
transformed parameters {
  real<lower = 0.0> lambda;
  real<lower = 0.0, upper = 1.0> p;
  lambda = log(al);
  p = inv_logit(ap);
}
model {
  al ~ normal(al_mean, al_scale);
  ap ~ normal(ap_mean, ap_scale);
  for (n in 1:N) {
    if (y[n] == 0) {
      target += log_sum_exp(bernoulli_lpmf(1 | theta), bernoulli_lpmf(0 | theta)
        + poisson_lpmf(y[n] | lambda));
    } else {
      target += bernoulli_lpmf(0 | theta) + poisson_lpmf(y[n] | lambda);
    }
  }
}
