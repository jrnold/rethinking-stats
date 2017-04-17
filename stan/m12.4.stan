data {
  # number obs
  int n;
  int pulled_left[n];
  int n_actor;
  int<lower = 1, upper = n_actor> actor[n];
  vector[n] condition;
  vector[n] prosoc_left;
  # priors
  real a_mean;
  real<lower = 0.0> a_scale;
  real bp_mean;
  real<lower = 0.0> bp_scale;
  real bpC_mean;
  real<lower = 0.0> bpC_scale;
  real<lower = 0.0> sigma_scale;
}
parameters {
  vector[n_actor] a_actor;
  real a;
  real bp;
  real bpC;
  real<lower = 0.0> sigma_actor;
}
transformed parameters {
  vector<lower = 0.0, upper = 1.0>[n] p;
  for (i in 1:n){
    p[i] = inv_logit(a + a_actor[actor[i]]
      + (bp + bpC * condition[i]) * prosoc_left[i]);
  }
}
model {
  sigma_actor ~ cauchy(0.0, sigma_scale);
  a_actor ~ normal(0.0, sigma_actor);
  a ~ normal(a_mean, a_scale);
  bp ~ normal(bp_mean, bp_scale);
  bpC ~ normal(bpC_mean, bpC_scale);
  pulled_left ~ binomial(1, p);
}
