%% a
% Initial State 1
V1=10;
air1i=Air;
set(air1i,'P',8e6, 'T', 300);
v1i=1/density(air1i);
m1i=V1/v1i;
u1i=intEnergy_mass(air1i);
s1i=entropy_mass(air1i);

% Final State 1
air1f=Air;
set(air1f, 'P', 0.2e6, 'T', 300);
v1f=1/density(air1f);
m1f=V1/v1f;
u1f=intEnergy_mass(air1f);
s1f=entropy_mass(air1f);

% State 2
air2=Air;
set(air2, 'P', 0.2e6, 'T', 300);
v2=1/density(air2);

% Answer
deltam=m1i-m1f;
wmaxa=0.1e6*deltam*v2;

%% b
% State1
V1=10;
air1=Air;
set(air1,'P',8e6, 'T', 300);
s1=entropy_mass(air1);
v1=1/density(air1);
u1=intEnergy_mass(air1);
m1=V1/v1;

% State 2
air2=Air;
s2=s1;
set(air2, 'P', 0.2e6, 'S', s2);
v2=1/density(air2);
u2=intEnergy_mass(air2);
m2=V1/v2;

% Outlet State
airout=Air;
sout=s1;
set(airout, 'P', 0.1e6, 'S', sout);
hout=enthalpy_mass(airout);

% Answer
wmaxb=(m1*u1-m2*u2)-(m1-m2)*hout;

%% c
wmaxc=m1i*(u1i-u1f + 0.1e6*(v1i-v1f) - 300*(s1i-s1f));