water1=Water;
set(water1,'P', 1e5, 'Vapor', 0);

water2=Water;
set(water2,'P', 1e5, 'Vapor', 1);

enthalpy_mass(water2)-enthalpy_mass(water1)
1/density(water2)-1/density(water1)
entropy_mass(water2)-entropy_mass(water1)