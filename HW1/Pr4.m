%rp=22.87;
rps=linspace(1,22,200)';
ws=zeros(200,1);
efficiencies=zeros(200,1);
for i=1:200
    rp=rps(i);
    etac=0.85;
    etat=0.9;
    epsilon=0.85;
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
    air2Isen=Air;
    s2Isen=s1;
    set(air2Isen, 'P', P2, 'S', s2Isen);
    h2Isen=enthalpy_mass(air2Isen);
    % Actual
    h2=h1 + etac*(h2Isen-h1);
    set(air2, 'P', P2, 'Enthalpy', h2);
    T2=temperature(air2);
    wc=h2-h1;

    % State 4
    air4=Air;
    T4=1300;
    P4=P2;
    set(air4, 'P', P4, 'T', T4);
    h4=enthalpy_mass(air4);
    s4=entropy_mass(air4);


    % State 5
    air5=Air;
    P5=P1;
    % If isentropic
    air5Isen=Air;
    s5Isen=s4;
    set(air5Isen, 'S', s5Isen, 'P', P5);
    h5Isen=enthalpy_mass(air5Isen);
    % Actual
    h5=h4-etat*(h4-h5Isen);
    set(air5, 'P', P5, 'Enthalpy', h5);
    T5=temperature(air5);
    wt=h4-h5;

    % State 3
    air3=Air;
    P3=P2;
    % If ideal
    air3Max=Air;
    T3Max=T5;
    set(air3Max, 'P', P3, 'T', T3Max);
    h3Max=enthalpy_mass(air3Max);
    % Actual
    h3=h2 + epsilon*(h3Max-h2);
    set(air3, 'P', P2, 'Enthalpy', h3);
    T3=temperature(air3);

    % Combustor
    qin=h4-h3;
    % Work

    w=wt-wc;

    efficiency=w/qin;
    
    ws(i)=w;
    efficiencies(i)=efficiency;
end

[wmax, Iwmax]=max(ws); rpwmax=rps(Iwmax);
[efficiencymax, Iemax]=max(efficiencies); rpemax=rps(Iemax);

plot(ws/1000, efficiencies, 'k');
xlabel('Specific Work (kJ/kg)');
ylabel('Thermal Efficiency');