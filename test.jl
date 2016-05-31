include("representaciones.jl")
using RE
map(x->protoBloque(3,x), 1:6)
mats = regular(3)
vecs = transpose(matvec(6))
inv(vecs)*mats[2]*vecs
loquis = map(x->inv(vecs)*mats[x]*vecs,1:6)
map(x->eigvecs(loquis[x][2:end,2:end]),1:6)
# Aquí se intenta con un nuevo vector
# Con el map lo que se hace es ver a dónde
# va a dar el vector.
# Lo utilicé para tratar de encontrar un subespacio
# invariante.
loco = map(x->loquis[x][2:end,2:end]*[-1,-1,1,1,1],2:6)
# Después veía si eran ortogonales a los dos
# que ya tenía.
gamma = Array{Float64,1}[]
push!(gamma,[0,1,0,1,0])
push!(gamma,[1,0,1,0,0])
# Probaba con cuáles eran ortogonales
map(x->dot(loco[x],gamma[1]),1:5)
