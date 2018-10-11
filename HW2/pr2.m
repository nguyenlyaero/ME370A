T0=300;
P0=1e5;
% State 0
water0=Water;
set(water0,'P', P0, 'T', T0);
h0=enthalpy_mass(water0);
s0=entropy_mass(water0);

% State 1
water1=Water;
P1=40e5;
T1=400+273;
set(water1, 'P', P1, 'T', T1);
h1=enthalpy_mass(water1);
s1=entropy_mass(water1);

% State 2
water2=Water;
P2=5e5;
T2=200+273;
set(water2, 'P', P2, 'T', T2);
h2=enthalpy_mass(water2);
s2=entropy_mass(water2);

% State 2s
water2s=Water;
set(water2s, 'P', 5e5, 'S', s1);
h2s=enthalpy_mass(water2s);
s2s=entropy_mass(water2s);

% a
wact=h1-h2;

% b
wmax=(h1-h2) - T0*(s1-s2);

% c
wise=h1-h2s;

% d
psi2=(h2-h0) - T0*(s2-s0);
psi2s=(h2s-h0) - T0*(s2s-s0);

% e
etas=wact/wise;

% f
Iact=(h1-h2) - T0*(s1-s2) - wact;

Is=(h1-h2s) - T0*(s1-s2s) - wise;
% g
eta2=wact/wmax;