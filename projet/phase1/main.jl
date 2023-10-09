""" Inclure les fichiers du projet"""

include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

""" Cette fonction permet de construire une arrete étant donné les arretes renvoyées par read_edges """
function convert_to_edge(edge, weight, nodes)
    node1 = nodes[edge[1]]
    node2 = nodes[edge[2]]
    edge = Edge(string(edge[1]) * "-" * string(edge[2]), node1, node2, weight)
    return edge
end

""" Cette fonction permet de construire un vecteur de noeuds étant donné un dictionnaire de noeud renvoyée par read_nodes """
function convert_to_node(nodes)
    vect_nodes = []
    for (keys, vals) in nodes
        node = Node(string(keys), vals)
        push!(vect_nodes, node)
    end
    return Vector{typeof(vect_nodes[1])}(vect_nodes)
end

"""Cette fonction permet de generer les noeuds dans le cas où l'instance"""
function generate_nodes(dim)
    vect_nodes = []
    for i = 1:dim
        node = Node(string(i), 0)
        push!(vect_nodes, node)
    end
    return Vector{typeof(vect_nodes[1])}(vect_nodes)
end

"""Cette fonction permet de generer le graphe étant donné une instance stsp """
function graph_from_instance(filename::String)

    header = read_header(filename)
    dim = parse(Int, header["DIMENSION"])
    edges_inst, weights_inst = read_edges(header, filename)

    if header["DISPLAY_DATA_TYPE"] == "None"
        nodes = generate_nodes(dim)
    else
        nodes_inst = read_nodes(header, filename)
        nodes = convert_to_node(nodes_inst)
    end

    edge = convert_to_edge(edges_inst[1], weights_inst[1], nodes)

    graph = Graph(header["NAME"], nodes, [edge])

    if length(edges_inst) == 1
        return graph
    else
        for i = 2:length(edges_inst)
            edges = convert_to_edge(edges_inst[i], weights_inst[i], nodes)
            add_edge!(graph, edges)
        end
    end

    return graph
end
