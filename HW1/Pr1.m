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
N=500;
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
Q=trapz(ProcessT, ProcessCv)*m;
plot(ProcessS, ProcessT, 'k');
xlabel('s(J/kgK)'); ylabel('T(K)');
save('Pr1.mat');




