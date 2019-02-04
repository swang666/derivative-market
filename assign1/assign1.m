S0 = 100;
K = 90;
r = 0.02;
h = 0.25;
u = exp(r*h+0.2*sqrt(h));
d = exp(r*h-0.2*sqrt(h));
T = 4;

[prices, payoffs, delta, bond] = european_option(S0, 'straddle', K, r, h, u, d, T);
straddle_price = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

S0 = 100;
K = 90;
r = 0.02;
h = 0.025;
u = exp(r*h+0.2*sqrt(h));
d = exp(r*h-0.2*sqrt(h));
T = 40;

[prices, payoffs, delta, bond] = european_option(S0, 'straddle', K, r, h, u, d, T);
straddle_price2 = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

S0 = 100;
K = 90;
r = 0.02;
h = 0.25;
u = exp(r*h+0.2*sqrt(h));
d = exp(r*h-0.2*sqrt(h));
T = 4;

[prices, payoffs, delta, bond] = european_option(S0, 'binary', K, r, h, u, d, T);
binary_price = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

S0 = 10;
K = 10;
r = 0.01;
h = 1/365;
u = exp(r*h+0.15*sqrt(h));
d = exp(r*h-0.15*sqrt(h));
T = 250;

[prices, payoffs, delta, bond, opt] = american_option(S0, 'call', K, r, h, u, d, T);
binary_price = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

