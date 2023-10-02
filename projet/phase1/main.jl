include("node.jl")
include("edge.jl")
include("graph.jl")


function convert_to_edge(edge, weight)
    node1 = Node(str(edge(1)), edge(1))
    node2 = Node(str(edge(2)), edge(2))

    edge_c = Edge(string(edge(1)) * "-" * string(edge(2)), node1, node2, weight)
    edge_c
end

function graph_from_instance(filename::String)
    header = read_header(filename)
    nodes = read_nodes(header, filename)
    edges, weights = read_edges(header, filename)
    

    
 end
 