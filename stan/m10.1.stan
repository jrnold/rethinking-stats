data {
  # number obs
  int n;
  int pulled_left[n];
  real a_mean;
  real<lower = 0.0> a_scale;
}
parameters {
  real a;
}
transformed parameters {
  real<lower = 0.0, upper = 1.0> p;
  p = inv_logit(a);
}
model {
  pulled_left ~ binomial(1, p);
}
