include("representaciones.jl")
using RE
map(x->protoBloque(3,x), 1:6)
mats = regular(3)
vecs = transpose(matvec(6))
inv(vecs)*mats[2]*vecs
