data {
  # number obs
  int n;
  vector[n] y;
  # number cols in X
  int k;
  # design matrix X
  matrix [n, k] X;
  # priors
  real b_loc;
  real<lower = 0.0> b_scale;
  real a_loc;
  real<lower = 0.0> a_scale;
  # sigma scale
  real sigma_scale;
}
parameters {
  vector[k] b;
  real<lower = 0.0> sigma;
  real<lower = 2.0> nu;
}
transformed parameters {
  # keep E(Y | X) for each obs
  vector[n] mu;
  mu = a + b * X;
}
model {
  a ~ normal(a_mean, a_scale);
  b ~ normal(b_mean, b_scale);
  # nu ~ student_t();
  y ~ student_t(nu, mu, sigma);
}
generated quantities {
  # posterior sample
  vector[n] y_rep;
  for (i in 1:n) {
    y_rep[i] = student_t(nu, mu[i], sigma);
  }
}
