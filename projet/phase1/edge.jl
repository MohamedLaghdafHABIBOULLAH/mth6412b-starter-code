import Base.show

"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arrêtes d'un graphe.

Exemple:

        node1 = Node("Joe", 3.14)
        node2 = Node("Steve", exp(1))
        edge1 = Edge("My_edge", node1, node2, -1)

"""
mutable struct Edge{T} <: AbstractEdge{T}
  name::String
  node1::Node{T}
  node2::Node{T}
  weight
end

# Constructeur pour Edge

function Edge(name::String, node1::Node{T}, node2::Node{T}) where T
    Edge(name, node1, node2, -1)
end
# on présume que toutes les arretes dérivant d'AbstractEdge
# posséderont des champs `name` et les 2 noeuds `node1`et `node2``.

"""Renvoie le nom de l'arrete."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les données contenues dans l'arrete."""
data(edge::AbstractEdge) = Vector([edge.node1, edge.node2])

"""Affiche une arrete."""
function show(edge::AbstractEdge)
  println("Edge ", name(edge), ", data: ", data(edge))
end
