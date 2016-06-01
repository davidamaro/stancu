include("representaciones.jl")
using RE
mats = regular(3)
uds=[1,0,0,0,0,0]
sud=[0,0,0,1,0,0]
dsu=[0,0,0,0,1,0]
usd=[0,1,0,0,0,0]
sdu=[0,0,0,0,0,1]
dus=[0,0,1,0,0,0]
sim = (uds+dus+sdu+usd+dsu+sud)/factorial(3)
antisim = (uds-dus-sdu-usd+dsu+sud)/factorial(3)
psi1 = -(2*uds+2*dus-sdu-sud-usd-dsu)/sqrt(12)
psi2 = -(usd+dsu-sdu-sud)/2
psi3=(2*uds-2*dus+sdu-sud+usd-dsu)/sqrt(12)
psi4=(-sdu+sud+usd-dsu)/2
mortal = zeros(6,6)
mortal[1,:] = sim
mortal[2,:] = psi1
mortal[3,:] = psi2
mortal[4,:] = psi3
mortal[5,:] = psi4
mortal[6,:] = antisim
caz = transpose(mortal)
map(x->inv(caz)*mats[x]*caz,1:6)
