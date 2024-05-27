using Graphs, GraphRecipes, Plots # for plotting graphs
using StatsBase # for sample
using Combinatorics # for combinations

function make_random_graph(filename, num_nodes)
    open(pwd() * "/hm01/input_graphs/" * filename, "w") do f
        nodes = [x for x in 1:num_nodes]
        combos = collect(Combinatorics.combinations(nodes, 2))
        edges = collect(sample(combos, 2 * num_nodes; replace = false))
        for edge in edges
            write(f, "$(edge[1]) $(edge[2]) \n")
        end
    end
end

function read_data(filename::String)
    # sources = Int[]
    # destinations = Int[] 
    edges = Tuple{Int, Int}[]
    # @show edges
    io = open(pwd() * "/hm01/input_graphs/" * filename, "r");
    for line in eachline(io)
        x, y = [parse(Int, ss) for ss in split(line)]
        t = Tuple([x, y])
        # @show t
        push!(edges, t)
        # append!(sources, x)
        # append!(destinations, y)
    end
    # @show edges
    return edges
    # return sources, destinations
end

function viewgraph(g, nodecolors) 
    p = graphplot(g,
        names = 1:nv(g),
        fontsize = 14,
        nodecolor = nodecolors,
        markershape = :circle,
        markersize = 0.15,
        markerstrokewidth = 2,
        markerstrokecolor = :gray,
        edgecolor = :gray,
        linewidth = 2,
        curves = true
    )
    display(p)
end

function get_filename()
    biggest_number = 1
    while isfile(pwd() * "/hm01/input_graphs/" * string('g') * string(biggest_number) * ".txt")
        biggest_number = biggest_number + 1
    end
    return string('g') * string(biggest_number) * ".txt"
end

function count_happy_edges(graph, nodecolors)
    num_happies = 0
    for i in 1:6
        for j in all_neighbors(graph, i) 
            num_happies += nodecolors[i] != nodecolors[j]
        end
    end
    return num_happies ÷ 2
end

function run_program()
    next_available_filename = get_filename()
    make_random_graph(next_available_filename, 6)
    edges = read_data(next_available_filename)
    color_list = [:pink, :gold, :lightblue]
    nodecolors = [rand(color_list) for _ in 1:length(edges)]
    # weights = round.(rand(length(sources)), digits = 2)
    edge_list = Edge.(edges)
    random_graph = SimpleGraph(edge_list)
    viewgraph(random_graph, nodecolors)
    num_happies = count_happy_edges(random_graph, nodecolors)
    @show num_happies
    # readline()
end

run_program()