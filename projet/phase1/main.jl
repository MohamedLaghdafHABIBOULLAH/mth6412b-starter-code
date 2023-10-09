include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

function convert_to_edge(edge, weight, nodes_c)
    node1 = nodes_c[edge[1]]
    node2 = nodes_c[edge[2]]
    edge_c = Edge(string(edge[1]) * "-" * string(edge[2]), node1, node2, weight)
    return edge_c
end

function convert_to_node(nodes)
    nd = []
    for (keys, vals) in nodes
        node = Node(string(keys), vals)
        push!(nd, node)
    end
    return Vector{typeof(nd[1])}(nd)
end

function generate_nodes(dim)
    nd = []
    for i in 1:dim
        node = Node(string(i), 0)
        push!(nd, node)
    end
    return Vector{typeof(nd[1])}(nd)
end    

function graph_from_instance(filename::String)
    
    header = read_header(filename)
    dim = parse(Int, header["DIMENSION"])
    edges, weights = read_edges(header, filename)

    if header["DISPLAY_DATA_TYPE"] == "None"
        nodes_c = generate_nodes(dim)
    else
        nodes = read_nodes(header, filename)
        nodes_c = convert_to_node(nodes)
    end

    edges_c = convert_to_edge(edges[1],weights[1],nodes_c)
        
    graph = Graph(header["NAME"], nodes_c, [edges_c])
    
    for i in 2:length(edges)
        edges_c = convert_to_edge(edges[i],weights[i], nodes_c)
        add_edge!(graph, edges_c)
    end

    return graph
 end
 