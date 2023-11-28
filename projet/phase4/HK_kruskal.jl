""" Inclure les fichiers du projet"""

include("../phase2/kruskal.jl")

using LinearAlgebra

# Implémente une variante de l'algorithme de Kruskal pour trouver l'arbre couvrant minimum.
# Paramètres :
# node::Node - Un nœud du graphe.
# graph::Graph - Le graphe dans lequel l'arbre couvrant minimum est recherché.
# heuristique::Symbol=:default - Un paramètre optionnel pour choisir la méthode heuristique.

function kruskal_1(node::Node, graph::Graph; heuristique::Symbol=:default)
    edges = sort(graph.edges, by=x -> x.weight)# + pi_k[x.node1.name] + pi_k[x.node2.name])
    minimum_spanning_tree = Edge{typeof(graph.nodes[1].data)}[]
    pred = Preds(graph.nodes)
    # println(pred)
    degree = Dict(node.name => 0 for node in graph.nodes)
    total_weight = 0.0
    i = 0
    for edge in edges
        if edge.node1.name != edge.node2.name
            if edge.node1.name == node.name || edge.node2.name == node.name
                if i < 2
                    i += 1
                    push!(minimum_spanning_tree, edge)
                    # edge.weight = edge.weight - pi_k[edge.node1.name] - pi_k[edge.node2.name]
                    total_weight += edge.weight
                    degree[edge.node1.name] += 1
                    degree[edge.node2.name] += 1
                end
            elseif find(pred, edge.node1.name) != find(pred, edge.node2.name) # si les noeuds font partie de composante connexe distincte
                push!(minimum_spanning_tree, edge)
                (heuristique == :default) && union_rank(pred, edge.node1.name, edge.node2.name)
                #   edge.weight = edge.weight - pi_k[edge.node1.name] - pi_k[edge.node2.name]
                total_weight += edge.weight
                (heuristique == :rank) && union(pred, edge.node1.name, edge.node2.name)
                (heuristique == :comp) && union(pred, edge.node1.name, edge.node2.name)
                degree[edge.node1.name] += 1
                degree[edge.node2.name] += 1
                #  println(pred)
            end
        end
    end
    # println(pred)
    return minimum_spanning_tree, total_weight, degree
end


# Définit la fonction HK_kruskal. Elle semble viser à trouver un arbre couvrant minimum
# dans un graphe, mais avec certaines heuristiques et optimisations.
# Paramètres :
# node::Node - Un nœud du graphe.
# graph::Graph - Le graphe dans lequel nous cherchons l'arbre couvrant minimum.
# t0 - Possiblement un paramètre de température initiale pour une approche de recuit simulé ou un autre facteur algorithmique.
# kmax - Nombre maximum d'itérations pour exécuter l'algorithme.
# heuristique::Symbol=:default - Un paramètre optionnel pour choisir la méthode heuristique.

function HK_kruskal(node::Node, graph::Graph, t0, kmax; heuristique::Symbol=:default)
    k = 0
    pi_k = Dict(node.name => 0.0 for node in graph.nodes)
    new_graph = deepcopy(graph)
    mst, tt, degree = kruskal_1(node, new_graph; heuristique=heuristique)
    t = t0
    v = [value - 2 for value in values(degree)]
    T = length(v) / 2
    while norm(v) > 0 && k < kmax && norm(v) > 6.0
        # v = [value - 2 for value in values(degree)]
        # pi_k = pi_k + t * v
        for key in keys(pi_k)
            pi_k[key] = pi_k[key] + t * (degree[key] - 2)
        end
        for edge in new_graph.edges
            edge.weight = edge.weight + pi_k[edge.node1.name] + pi_k[edge.node2.name]
        end
        # ww = tt - 2 * sum(values(pi_k))
        #   tt_weight = sum(edge.weight for edge in edges)
        mst, tt, degree = kruskal_1(node, new_graph; heuristique=heuristique)
        v = [value - 2 for value in values(degree)]
        k += 1
        # if k > T
        #     k = 0
        #     t = t/2
        #     T = T/2
        # end
        t = t0 / k


        # println("k: ", k, ", v: ", norm(v))
        #    println("k: ", k, ", v: ", norm(v), ", current_tt: ", tt)
        # if k % 10000 == 0
        #     println("k: ", k, ", v: ", norm(v), ", current_tt: ", tt)
        #     #   t = 1
        # end
    end
    # put the weight of edges of mst equal to those of graph 
    tt = 0.0
    for edge in graph.edges
        for edge_mst in mst
            if edge.name == edge_mst.name
                edge_mst.weight = edge.weight
                tt += edge.weight
            end
        end
    end
    return mst, tt, v, degree
end
