""" Inclure les fichiers du projet"""

include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")


# Implémenter Connexe avec les noms des nœuds comme identifiant
mutable struct Preds
    parent::Dict{String, String}
end

function Preds(nodes::Vector{Node{T}}) where T
    parent = Dict{String, String}()
    for node in nodes
        parent[node.name] = node.name
    end
    Preds(parent)
end

# Fonction find pour trouver le parent (représentant) d'un nœud
function find(pred::Preds, node_name)
    if pred.parent[node_name] != node_name
        pred.parent[node_name] = find(pred, pred.parent[node_name])
    end
    return pred.parent[node_name]
end

# Fonction union pour fusionner les composantes connexes des 2 noeuds (dire qu'ils ont le même parent)
function union(pred::Preds, node1_name, node2_name)
    root1 = find(pred, node1_name)
    root2 = find(pred, node2_name)
    if root1 != root2
        pred.parent[root1] = root2
    end
end

# Fonction union pour fusionner les composantes connexes des 2 noeuds (dire qu'ils ont le même parent)
function union(pred::Preds, node1_name, node2_name)
    root1 = find(pred, node1_name)
    root2 = find(pred, node2_name)
    if root1 != root2
        pred.parent[root1] = root2
    end
end

# Implémenter Kruskal pour le minimum_spanning_tree
function kruskal(graph::Graph; heuristique::Symbol = :default)
    edges = sort(graph.edges, by = x -> x.weight)
    minimum_spanning_tree = Edge{typeof(graph.nodes[1].data)}[]
    pred = Preds(graph.nodes)
    println(pred)

    for edge in edges
        if find(pred, edge.node1.name) != find(pred, edge.node2.name) # si les noeuds font partie de composante connexe distincte
            push!(minimum_spanning_tree, edge)
            (heuristique == :default) && union(pred, edge.node1.name, edge.node2.name)
            #(heuristique == :rank) && union(pred, edge.node1.name, edge.node2.name)
            #(heuristique == :comp) && union(pred, edge.node1.name, edge.node2.name)
            println(pred)
        end
    end

    return minimum_spanning_tree
end


# Exemple d'utilisation
node1 = Node("A", 1)
node2 = Node("B", 2)
node3 = Node("C", 3)
node4 = Node("D", 4)

edge1 = Edge("AB", node1, node2, 2)
edge2 = Edge("AC", node1, node3, 4)
edge3 = Edge("BC", node2, node3, 3)
edge4 = Edge("BD", node2, node4, 2)
edge5 = Edge("CD", node3, node4, 1)

nodes_g = [node1, node2, node3, node4]
edges_g = [edge1, edge2, edge3, edge4, edge5]

graph_g = Graph("Example Graph", nodes_g, edges_g)

minimum_spanning_tree = kruskal(graph_g)
for edge in minimum_spanning_tree
    println("Edge: ", edge.name, ", Weight: ", edge.weight)
end
