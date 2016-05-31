__precompile__(true)

module RE

export matriz, generarPerm, generarBase
export aplicacion, representacion
export aplicarRepre, aplicacionTotal, ortogonal
export salidaRepre, protoBloque
export unoRegular, regular
export Permutacion

type Permutacion
    perm :: Array{Int64,1}
    num :: Int64
end

function matriz(base, aplicado)
    res = zeros(length(base), length(aplicado))
    for i in 1:length(base)
        for j in 1:length(aplicado)
            res[i,j] = dot(base[i],aplicado[j])
        end
    end
    res
end

function generarPerm(estado)
    collect(permutations(estado))
end

function generarBase(qbits)
    estados = Array{Int64,1}[]
    base = zeros(qbits)
    for i in 1:qbits
        base[i] = 1
        push!(estados,base)
        base = zeros(qbits)
    end
    estados
end

function aplicacion(elemento, listaPerm)
    [x[elemento] for x in listaPerm]
end

function representacion(elemento,dim = 3)
    matriz(generarBase(dim),aplicacion(elemento,map(generarPerm,generarBase(dim))))
end

function aplicarRepre(vector)
    dim =  length(vector)
    resultados = Array{Float64,1}[]
    for i in 1:factorial(dim)
        push!(resultados,representacion(i,dim)*vector)
    end
    resultados
end

function aplicacionTotal(base)
    map(aplicarRepre,base)
end

function ortogonal(dim)
    vector = ones(dim)
    demas = Array{Float64,1}[vector/norm(vector)]
        for i in 1:dim - 1 # dim -1
        vector = -vector
        vector[i] = dim - 1
        push!(demas, vector/norm(vector))
        vector = ones(dim)
    end
    demas
end

normalize(x) = x./sqrt(sumabs2(x, length(x)))

function salidaRepre(salida, rep)
    [x[rep] for x in salida]
end
function protoBloque(dim, rep)
    mat = transpose(matvec(dim))
    repre = representacion(rep, dim)
    inv(mat)*repre*mat
end
function matvec(dim)
    res = zeros(Float64,dim,dim)
    vector = ones(dim)
    for i in 1:dim
        res[1,i] = vector[i]/norm(vector)
    end
    for i in 2:dim # dim -1
        vector = -vector
        vector[i] = dim - 1
        for j in 1:dim
            res[i,j] = vector[j]/norm(vector)
        end
        vector = ones(dim)
    end
    res
end
function unoRegular(elemento, n)
    original = generartipoPerm(1:n)
    matricita = zeros(factorial(n), factorial(n))
    reservoir = map(generartipoPerm,collect(permutations(1:n)))
    for i in 1:factorial(n)
        for juas in original
            if reservoir[elemento][i].perm == juas.perm
                matricita[reservoir[elemento][i].num, juas.num] = 1
            end
        end
    end
    matricita
end

function regular(n)
    matrices = Array{Float64,2}[]
    for i in 1:factorial(n)
        push!(matrices,unoRegular(i,n))
    end
    matrices
end
function generartipoPerm(rango)
    valores = collect(permutations(rango))
    sostén = Permutacion[]
    for i in 1:length(valores)
        push!(sostén, Permutacion(valores[i],i))
    end
    sostén
end
end
