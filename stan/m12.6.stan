data {
  # number obs
  int n;
  int total_tools[n];
  vector[n] logpop;
  int n_society;
  int<lower = 1, upper = n_society> society[n];
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bp_mean;
  real<lower = 0.0> bp_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  vector[n_society] a_society;
  real<lower = 0.0> sigma_society;
  real a;
  real bp;
}
transformed parameters {
  vector[n] lambda;
  lambda = log(a + a_society[society] + bp * logpop);
}
model {
  sigma_society ~ cauchy(0.0, sigma_scale);
  a_society ~ normal(0.0, sigma_society);
  a ~ normal(a_mean, a_scale);
  bp ~ normal(bp_mean, bp_scale);
  total_tools ~ poisson(lambda);
}
