data {
  # number obs
  int n;
  int si[n];
  int ni[n];
  int n_ponds;
  int<lower = 1, upper = n_ponds> pond[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  vector[n_ponds] a_pond;
  real a;
  real<lower = 0.0> sigma;
}
transformed parameters {
  vector<lower = 0.0, upper = 1.0>[n] p;
  for (i in 1:n){
    p[i] = inv_logit(a_pond[pond[i]]);
  }
}
model {
  sigma ~ cauchy(0.0, sigma_scale);
  a ~ normal(a_mean, a_scale);
  a_pond ~ normal(a, sigma);
  si ~ binomial(ni, p);
}
