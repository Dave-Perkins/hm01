using StatsBase # for sample
using Combinatorics # for combinations

open("g1.txt", "w") do f
    nodes = [x for x in 1:6]
    combos = collect(Combinatorics.combinations(nodes, 2))
    edges = collect(sample(combos, 15))
    @show edges
    for edge in edges
        write(f, "$(edge[1]) $(edge[2]) \n")
    end
end