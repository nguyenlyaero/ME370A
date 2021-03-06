function w = FindStateRP(R, P, Tguess)
% Find State from Rho and Pressure for water model
    function error=Error(T)
        w1=Water;
        set(w1, 'Rho', R, 'T', T);
        error=(pressure(w1)-P)/P;
    end
% Find bounds
step=10;
Ta=Tguess; Tb=Ta+step;
errora=Error(Ta); errorb=Error(Tb);
while errora*errorb>0
    if abs(errora)>abs(errorb)
        Ta=Tb; errora=errorb;
        Tb=Tb+step; errorb=Error(Tb);
    else
        Tb=Ta; errorb=errora;
        Ta=Ta-step; errora=Error(Ta);
    end
end
%Bisect
Tc=0.5*(Ta+Tb); errorc=Error(Tc);
while abs(errorc)>1e-8
    if errorc*errora<0
        Tb=Tc; errorb=errorc;
    else
        Ta=Tc; errora=errorc;
    end
    Tc=0.5*(Ta+Tb); errorc=Error(Tc);
end
T=Tc;
w=Water;
set(w,'T', T, 'Rho', R);
end

