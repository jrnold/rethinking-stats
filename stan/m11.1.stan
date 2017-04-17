data {
  int n;
  int<lower = 2> K;
  int<lower = 1, upper = K> response[n];
}
parameters {
  ordered[K - 1] cutpoints;
}
model {
  for (i in 1:n) {
    response[i] ~ ordered_logistic(0, cutpoints);
  }
}
