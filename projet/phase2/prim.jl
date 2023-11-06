#using DataStructures: PriorityQueue

""" Inclure les fichiers du projet"""

include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")
include("../phase1/main.jl")
include("queue.jl")

# Fonction pour implémenter l'algorithme de Prim afin de trouver l'arbre couvrant minimum
function prim(graph::Graph{T}) where T
    nodes = graph.nodes
    num_nodes = length(nodes)
    
    # Initialiser un ensemble pour suivre les nœuds sélectionnés
    selected = Set{Node{T}}()
    
    # Initialiser une file de priorité pour les arêtes candidates
    candidate_edges = PriorityQueue{Edge{T}}()
    
    # Sélectionner le premier nœud arbitrairement et ajouter ses arêtes aux arêtes candidates
    push!(selected, nodes[1])
    for edge in graph.edges
        if edge.node1 in selected && edge.node2 ∉ selected || edge.node1 ∉ selected && edge.node2 in selected
            push!(candidate_edges, edge)
        end
    end
    
    # Initialiser le résultat
    mst_edges = Edge{T}[]
    total_weight = 0
    
    # Exécuter l'algorithme de Prim
    while length(selected) < num_nodes
        # Trouver l'arête de poids minimum dans les arêtes candidates
        min_edge = popfirst!(candidate_edges)
        min_weight = min_edge.weight
        
        # Vérifier si l'ajout de l'arête forme un cycle ou connecte un nouveau nœud
        if !(min_edge.node1 in selected && min_edge.node2 in selected)
            push!(mst_edges, min_edge)
            total_weight += min_weight
            
            # Ajouter le nouveau nœud à l'ensemble sélectionné
            new_node = min_edge.node1 in selected ? min_edge.node2 : min_edge.node1
            push!(selected, new_node)
            
            # Ajouter les arêtes du nouveau nœud aux arêtes candidates
            for edge in graph.edges
                if (edge.node1 in selected && edge.node2 ∉ selected) || (edge.node1 ∉ selected && edge.node2 in selected)
                    push!(candidate_edges, edge)
                end
            end
        end
    end
    
    return mst_edges, total_weight
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

mst, tw = prim(graph_g)
for edge in mst
    println("Edge: ", edge.name, ", Weight: ", edge.weight)
end
println("Total Weight: ", tw)

# gr17 = graph_from_instance("instances/stsp/gr17.tsp");
# mst, tw = prim(gr17)
# for edge in mst
#      println("Edge: ", edge.name, ", Weight: ", edge.weight)
#  end
#  println("Total Weight: ", tw)