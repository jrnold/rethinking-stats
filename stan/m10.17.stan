data {
  # number obs
  int n;
  int career[n];
  vector[n] family_income;
  # priors
  vector[2] b_mean;
  vector<lower = 0.0>[2] b_scale;
  vector[2] a_mean;
  vector<lower = 0.0>[2] a_scale;
}
parameters {
  vector[2] a;
  vector[2] b;
}
transformed parameters {
  vector[3] mu[n];
  for (i in 1:n) {
    mu[i][1] = 0.0;
    mu[i][2] = a[1] + b[1] * family_income[i];
    mu[i][3] = a[2] + b[2] * family_income[i];
  }
}
model {
  a ~ normal(a_mean, a_scale);
  b ~ normal(b_mean, b_scale);
  for (i in 1:n) {
    career[i] ~ categorical_logit(mu[i]);
  }
}
generated quantities {
  int y_rep[n];
  for (i in 1:n) {
    y_rep[i] = categorical_rng(softmax(mu[i]));
  }
}
