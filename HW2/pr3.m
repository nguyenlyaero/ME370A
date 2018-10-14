% State 1
P1=1600/0.01 + 9.81*20.4/0.01 + 1e5;
water1=Water;
set(water1, 'P', P1, 'Vapor', 0);
T1=temperature(water1);
v1=1/density(water1);
s1=entropy_mass(water1);

% Saturated Vapor state
waterV=Water;
set(waterV, 'P', P1, 'Vapor', 1);

% Find state 2
Q=2e6; m=10;
vbound=v1 + Q/m/P1;
N=100;
vVec=linspace(0.06043, 0.06048,N)';
errorVec=zeros(N,1);
for i=1:N
    wateri=Water;
    set(wateri, 'T', T1, 'V', vVec(i));
    errorVec(i)=abs(Q - m*(intEnergy_mass(wateri)-intEnergy_mass(water1))...
        - m*P1*(vVec(i)-v1) - 0.5*m*(vVec(i)-v1)/vVec(i)*9.81*10*(vVec(i)-v1)/0.01)/(Q/m);
end
[mi,I]=min(errorVec);

% State 2
v2=vVec(I);
P2=P1;
T2=T1;
water2=Water;
set(water2, 'T', T2, 'V', v2);
s2=entropy_mass(water2);

% a
fracUse=(1600/0.01*10*(v2-v1))/Q;

% b
fracIntE=m*(intEnergy_mass(water2)-intEnergy_mass(water1))/Q;
fracPis=(20.4*9.91/0.01*10*(v2-v1))/Q;
fracAtm=1e5*10*(v2-v1)/Q;
fracF=0.5*9.91*10*(v2-v1)/v2*10*(v2-v1)/0.01/Q;

% c
Wmax=m*(intEnergy_mass(water2)-intEnergy_mass(water1))+1e5*10*(v2-v1)...
    -300*10*(s2-s1);
