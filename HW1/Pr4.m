rp=5;
% State 1
air1=Air;
T1=300;
P1=1e5;
set(air1, 'P', P1, 'T', T1);
h1=enthalpy_mass(air1);
s1=entropy_mass(air1);

% State 2
air2=Air;
P2=rp*P1;
% If isentropic
air2Isen=air;
s2Isen=s1;
set(air2Isen, 'P', P2, 's', s2Isen);
h2Isen=enthalpy_mass(air2Isen);
% Actual
h2=h1 + eta*(h2Isen-h1);
set(air2, 'P', P2, 'Enthalpy', h2);



