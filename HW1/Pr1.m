% Initial State
w1=Water;
m=2;
P1=0.5e6;
X1=0.4;
setState_Psat(w1, [P1 X1]);
T1=temperature(w1);
Rho1=density(w1);
V1=m/Rho1;

% Process
N=250;
P2=2e6;
ProcessP=linspace(P1, P2, N).';
ProcessT=zeros(N,1); ProcessT(1)=T1;
ProcessRho=Rho1;
ProcessS=zeros(N,1); ProcessS(1)=entropy_mass(w1);
ProcessCv=zeros(N,1); ProcessCv(1)=cv_mass(w1);
ProcessX=zeros(N,1); ProcessX(1)=vaporFraction(w1);
for i=2:N
    wi=FindStateRP(ProcessRho, ProcessP(i), ProcessT(i-1));
    ProcessT(i)=temperature(wi);
    ProcessS(i)=entropy_mass(wi);
    ProcessCv(i)=cv_mass(wi);
    ProcessX(i)=vaporFraction(wi);
    disp(i);
end
Q=(intEnergy_mass(wi)-intEnergy_mass(w1))*m;

% Vapor dome
Tc=critTemperature(w1);
Pc=critPressure(w1);
wi=Water;
set(wi, 'P', Pc, 'T', Tc);
Sc=entropy_mass(wi);
Ts=linspace(400, Tc, 100);
Ss=zeros(100,2); Ss(100,:)=[Sc Sc];
for i=1:99
    wi=Water;
    set(wi, 'Vapor', 0, 'T', Ts(i));
    Ss(i,1)=entropy_mass(wi);
    set(wi, 'Vapor', 1, 'T', Ts(i));
    Ss(i,2)=entropy_mass(wi);
end


figure;
hold on;
plot(ProcessS, ProcessT, 'k');
plot(Ss(:,1), Ts, 'k--');
plot(Ss(:,2), Ts, 'k--');
legend('Process', 'Vapor Dome')
xlabel('s(J/kgK)'); ylabel('T(K)');
hold off;





