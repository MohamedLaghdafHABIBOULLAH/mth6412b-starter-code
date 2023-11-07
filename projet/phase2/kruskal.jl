""" Inclure les fichiers du projet"""

include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")
include("../phase1/main.jl")


# Implémenter Connexe avec les noms des nœuds comme identifiant
mutable struct Preds
    parent::Dict{String, String}
    Rank::Dict{String, Int}
end

function Preds(nodes::Vector{Node{T}}) where T
    parent = Dict{String, String}()
    Rank = Dict{String, Int}()
    for node in nodes
        parent[node.name] = node.name
        Rank[node.name] = 0
    end
    Preds(parent, Rank)
end

# Fonction find pour trouver le parent (représentant) d'un nœud
function find(pred::Preds, node_name)
    if pred.parent[node_name] != node_name
        pred.parent[node_name] = find(pred, pred.parent[node_name])
    end
    return pred.parent[node_name]
end

# Fonction union pour fusionner les composantes connexes des 2 noeuds (dire qu'ils ont le même parent)
function union_rank(pred::Preds, node1_name, node2_name)
    root1 = find(pred, node1_name)
    root2 = find(pred, node2_name)
    if root1 != root2
          if pred.Rank[root1] < pred.Rank[root2]
               pred.parent[root1] = root2
          elseif pred.Rank[root2] < pred.Rank[root1]
               pred.parent[root2] = root1
          else
               pred.parent[root1] = root2
               pred.Rank[root2] += 1
          end
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
   # println(pred)
    total_weight = 0.
    for edge in edges
        if find(pred, edge.node1.name) != find(pred, edge.node2.name) # si les noeuds font partie de composante connexe distincte
            push!(minimum_spanning_tree, edge)
            (heuristique == :default) && union_rank(pred, edge.node1.name, edge.node2.name)
            total_weight += edge.weight
            #(heuristique == :rank) && union(pred, edge.node1.name, edge.node2.name)
            #(heuristique == :comp) && union(pred, edge.node1.name, edge.node2.name)
          #  println(pred)
        end
    end
   # println(pred)
    return minimum_spanning_tree, total_weight
end


# Exemple d'utilisation
node1 = Node("A", 1)
node2 = Node("B", 2)
node3 = Node("C", 3)
node4 = Node("D", 4)
node5 = Node("E", 4)
node6 = Node("F", 4)
node7 = Node("G", 4)
node8 = Node("H", 4)
node9 = Node("I", 4)

edge1 = Edge("AB", node1, node2, 4)
edge2 = Edge("BC", node2, node3, 8)
edge3 = Edge("CD", node3, node4, 7)
edge4 = Edge("DE", node4, node5, 9)
edge5 = Edge("EF", node5, node6, 10)
edge6 = Edge("FC", node6, node3, 4)
edge7 = Edge("FG", node6, node7, 2)
edge8 = Edge("GI", node9, node7, 6)
edge9 = Edge("HG", node8, node7, 1)
edge10 = Edge("HI", node8, node9, 7)
edge11 = Edge("HA", node8, node1, 8)
edge12 = Edge("HB", node8, node2, 11)
edge13 = Edge("DF", node6, node4, 14)
edge14 = Edge("IC", node9, node3, 2)

nodes_g = [node1, node2, node3, node4, node5, node6, node7, node8, node9]
edges_g = [edge1, edge2, edge3, edge4, edge5, edge6, edge7, edge8, edge9, edge10, edge11, edge12, edge13, edge14]

graph_g = Graph("Example Graph", nodes_g, edges_g)

# minimum_spanning_tree, total_weight_g = kruskal(graph_g)
# for edge in minimum_spanning_tree
#     println("Edge: ", edge.name, ", Weight: ", edge.weight)
# end
# println("Total Weight: ", total_weight_g)

# gr17 = graph_from_instance("instances/stsp/gr17.tsp");
# mst, tt = kruskal(gr17)
# for edge in mst
#      println("Edge: ", edge.name, ", Weight: ", edge.weight)
#  end
#  println("Total Weight: ", tt)
