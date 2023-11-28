import Base.show

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

    node1 = Node("Joe", 3.14)
    node2 = Node("Steve", exp(1))
    node3 = Node("Jill", 4.12)
    edge1 = Edge("1-2", node1, node2, 0.5)
    edge1 = Edge("1-3", node1, node3, 0.5)
    G = Graph("Ick", [node1, node2, node3], [edge1, edge2])

Attention, tous les noeuds et arêtes doivent avoir des données de même type.
"""
mutable struct Graph{T,Y} <: AbstractGraph{T}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T,Y}}
end



"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T,Y}, node::Node{T}) where {T,Y}
  push!(graph.nodes, node)
  graph
end

"""Ajoute une arrete au graphe."""
function add_edge!(graph::Graph{T,Y}, edge::Edge{T}) where {T,Y}
  push!(graph.edges, edge)
  graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie la liste des arretes du graphe."""
edges(graph::AbstractGraph) = graph.edges

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Renvoie le nombre d'arretes du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and ", nb_edges(graph), " edges ")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end
