__precompile__(true)

module RE

export matriz, generarPerm, generarBase
export aplicacion, representacion

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

function unos(dim)
    vector = ones(dim)
    demas = Array{Float64,1}[vector]
        for i in 1:dim - 1 # dim -1
        vector = -vector
        vector[i] = dim - 1
        push!(demas, vector)
        vector = ones(dim)
    end
    demas
end
end
