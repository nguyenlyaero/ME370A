%% Find Optimum Pressure Ratio
pi21s=linspace(1,10, 100)';
ws=zeros(100,1);
for i=1:100
pi21=pi21s(i);
eta=0.7;
epsilon=0.85;
% State 1
Air1=Air;
P1=1e5;
T1=300;
set(Air1, 'P', P1, 'T', T1);
s1=entropy_mass(Air1);
h1=enthalpy_mass(Air1);

% State 2
Air2=Air;
P2=P1*pi21;
% if isentropic
s2Isen=s1;
set(Air2, 'P', P2, 'S', s2Isen);
h2Isen=enthalpy_mass(Air2);
% real
h2=h1 + (h2Isen-h1)/eta;
set(Air2, 'P', P2, 'Enthalpy', h2);
T2=temperature(Air2);
w1=h2-h1;

% State 2p (after intercooler)
Air2p=Air;
T2p=T2 - epsilon*(T2-T1);
P2p=P2;
set(Air2p, 'P', P2p, 'T', T2p);
s2p=entropy_mass(Air2p);
h2p=enthalpy_mass(Air2p);

% State 3
Air3=Air;
P3=10e5;
% if isentropic
s3Isen=s2p;
set(Air3, 'P', P3, 'S', s3Isen);
h3Isen=enthalpy_mass(Air3);
% real
h3=h2p + (h3Isen-h2p)/eta;
set(Air3, 'P', P3, 'Enthalpy', h3);
w2=h3-h2p;

w=w1+w2;
ws(i)=w;
end
[M,I]=min(ws);
wmin=M;
pi21min=pi21s(I);

%% Processes
N=100;
eta=0.7;
epsilon=0.85;
% Optimal 2-stage

pi21=pi21min;
eta=0.7;
epsilon=0.85;
% State 1
Air1=Air;
P1=1e5;
T1=300;
set(Air1, 'P', P1, 'T', T1);
s1=entropy_mass(Air1);
h1=enthalpy_mass(Air1);

% State 2
Air2=Air;
P2=P1*pi21;
% if isentropic
s2Isen=s1;
set(Air2, 'P', P2, 'S', s2Isen);
h2Isen=enthalpy_mass(Air2);
% real
h2=h1 + (h2Isen-h1)/eta;
set(Air2, 'P', P2, 'Enthalpy', h2);
T2=temperature(Air2);
w1=h2-h1;

% State 2p (after intercooler)
Air2p=Air;
T2p=T2 - epsilon*(T2-T1);
P2p=P2;
set(Air2p, 'P', P2p, 'T', T2p);
s2p=entropy_mass(Air2p);
h2p=enthalpy_mass(Air2p);

% State 3
Air3=Air;
P3=10e5;
% if isentropic
s3Isen=s2p;
set(Air3, 'P', P3, 'S', s3Isen);
h3Isen=enthalpy_mass(Air3);
% real
h3=h2p + (h3Isen-h2p)/eta;
set(Air3, 'P', P3, 'Enthalpy', h3);
w2=h3-h2p;
w=w1+w2;

% Compressor 1 Process
    ProcessP1a=linspace(P1,pi21*P1,N)';
    ProcessT1a=zeros(N,1); ProcessT1a(1)=300;
    ProcessH1a=zeros(N,1);
    ProcessS1a=zeros(N,1);
% Initialize
    Air1=Air;
    set(Air1, 'P', ProcessP1a(1), 'T', ProcessT1a(1));
    ProcessS1a(1)=entropy_mass(Air1);
    ProcessH1a(1)=enthalpy_mass(Air1);
% For each cross-section
for i=2:N
    Air2=Air;
    % if isentropic
    set(Air2, 'P', ProcessP1a(i), 'S', ProcessS1a(1));
    % real
    ProcessH1a(i)=ProcessH1a(1) + (enthalpy_mass(Air2)-ProcessH1a(1))/eta;
    set(Air2, 'P', ProcessP1a(i), 'Enthalpy', ProcessH1a(i));
    ProcessS1a(i)=entropy_mass(Air2);
    ProcessT1a(i)=temperature(Air2);
end

% Intercooler Process
    ProcessP3a=ProcessP1a(end)*ones(N,1);
    ProcessT3a=linspace(ProcessT1a(end), ProcessT1a(end) - epsilon*(ProcessT1a(end)-T1));
    ProcessH3a=zeros(N,1); ProcessH3a(1)=ProcessH1a(end);
    ProcessS3a=zeros(N,1); ProcessS3a(1)=ProcessS1a(end);
for i=2:N
    Air2p=Air;
    set(Air2p, 'P', ProcessP3a(i), 'T', ProcessT3a(i));
    ProcessH3a(i)=enthalpy_mass(Air2p);
    ProcessS3a(i)=entropy_mass(Air2p);
end

% Compressor 2 Process
    ProcessP2a=linspace(ProcessP3a(end),P3,N)';
    ProcessT2a=zeros(N,1); ProcessT2a(1)=ProcessT3a(end);
    ProcessH2a=zeros(N,1); ProcessH2a(1)=ProcessH3a(end);
    ProcessS2a=zeros(N,1); ProcessS2a(1)=ProcessS3a(end);

% For each cross-section
for i=2:N
    Air2=Air;
    % if isentropic
    set(Air2, 'P', ProcessP2a(i), 'S', ProcessS2a(1));
    % real
    ProcessH2a(i)=ProcessH2a(1) + (enthalpy_mass(Air2)-ProcessH2a(1))/eta;
    set(Air2, 'P', ProcessP2a(i), 'Enthalpy', ProcessH2a(i));
    ProcessS2a(i)=entropy_mass(Air2);
    ProcessT2a(i)=temperature(Air2);
end

N=200;
% Single-Stage Compressor Process
    ProcessP=linspace(P1,P3,N)';
    ProcessT=zeros(N,1); ProcessT(1)=300;
    ProcessH=zeros(N,1);
    ProcessS=zeros(N,1);
% Initialize
    Air1=Air;
    set(Air1, 'P', ProcessP(1), 'T', ProcessT(1));
    ProcessS(1)=entropy_mass(Air1);
    ProcessH(1)=enthalpy_mass(Air1);
% For each cross-section
for i=2:N
    Air2=Air;
    % if isentropic
    set(Air2, 'P', ProcessP(i), 'S', ProcessS(1));
    % real
    ProcessH(i)=ProcessH(1) + (enthalpy_mass(Air2)-ProcessH(1))/eta;
    set(Air2, 'P', ProcessP(i), 'Enthalpy', ProcessH(i));
    ProcessS(i)=entropy_mass(Air2);
    ProcessT(i)=temperature(Air2);
end



figure;
hold on;
plot([ProcessS1a; ProcessS3a; ProcessS2a], [ProcessH1a; ProcessH3a; ProcessH2a]);
plot(ProcessS, ProcessH);