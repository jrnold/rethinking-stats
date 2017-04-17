data {
  # number obs
  int n;
  int admit[n];
  int rej[n];
  # priors
  vector[2] a_mean;
  vector<lower = 0.0>[2] a_scale;
}
parameters {
  vector[2] a;
}
transformed parameters {
  vector<lower = 0.0>[2] lambda;
  lambda = log(a);
}
model {
  a ~ normal(a_mean, a_scale);
  admit ~ poisson(lambda[1]);
  rej ~ poisson(lambda[2]);
}
