% State 1
w1=Water;
P1=10*1e5;
T1=800;
set(w1, 'P', P1, 'T', T1);
s1=entropy_mass(w1);

% State 2
w2=Water;
P2=0.2*1e5;
s2=s1;
set(w2, 'S', s2, 'P', P2);

% Process
n=500;
ProcessP=linspace(P1, P2, n).';
ProcessV=zeros(n,1); ProcessV(1)=1/density(w1);
ProcessH=zeros(n,1); ProcessH(1)=enthalpy_mass(w1);
ProcessS=s1;
for i=2:n
    wi=Water;
    set(wi, 'S', ProcessS, 'P', ProcessP(i));
    ProcessV(i)=1/density(wi);
    ProcessH(i)=enthalpy_mass(wi);
end

% Answers
Work=trapz(ProcessV, ProcessP);
OutQuality=vaporFraction(w2);
OutT=temperature(w2);
plot(ProcessH, ProcessP);
xlabel('h(J/kg)');
ylabel('P(Pa)');
