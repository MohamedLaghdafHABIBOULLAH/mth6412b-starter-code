### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ d60f02ce-0a83-4edb-9747-b3de9ba1ae2b
using Markdown

# ╔═╡ 5dfaa4bb-f544-43df-a390-a9e326784fed
using InteractiveUtils

# ╔═╡ 7ea81498-700d-4402-bea4-37b5203d088f
using Logging

# ╔═╡ 5b0505f0-ab35-4ebc-9458-1914a54c7bfa
md"""
### Mini rapport: Phase 1 du projet
"""

# ╔═╡ 56c69abe-5f9d-433d-87ee-ad4d14d7e4ac
md""" Le  code se trouve au lien suivant: """

# ╔═╡ c49caeea-0bdd-4cd3-8e50-c739befecd98
md"""[https://github.com/MohamedLaghdafHABIBOULLAH/mth6412b-starter-code.git](https://github.com/MohamedLaghdafHABIBOULLAH/mth6412b-starter-code.git)"""

# ╔═╡ d16af9e4-e9fd-49df-97e4-b6af7193d63f
md"""
##### 1. Proposer un type Edge pour représenter les arêtes d’un graphe
"""

# ╔═╡ 5b9924f3-f260-40be-8144-53d4fd3e0645
"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractNode{T} end


# ╔═╡ 905d4a8a-9d15-45b3-8e3a-ffb33cd835b3
md"""
```julia
abstract type AbstractNode{T} end
```
"""

# ╔═╡ 789d0351-e2db-4250-8694-7003fbe1c17b
"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

# ╔═╡ f466942e-7de8-4de4-bd15-cffffb9c006d
md"""
```julia
abstract type AbstractEdge{T} end
```
"""

# ╔═╡ 3c45416e-9c54-48fe-9e63-edcb49afd27c
"""Mutable struct Node"""
  mutable struct Node{T} <: AbstractNode{T}
    name::String
    data::T
  end


# ╔═╡ d670b6ea-a115-4a5a-bf9e-0179b05fb447
md"""
```julia
  mutable struct Node{T} <: AbstractNode{T}
    name::String
    data::T
  end
```
"""

# ╔═╡ c4165062-dbb5-4e45-ac19-526f9f3ed7ea
md"""
###### Le type Edge est défini par un string, un couple de noeuds et un poid"""

# ╔═╡ 309b01be-0974-4d12-8230-4779b8983652
"""Mutable struct Edge"""
  mutable struct Edge{T} <: AbstractEdge{T}
  	name::String
  	node1::Node{T}
  	node2::Node{T}
  	weight
  end

# ╔═╡ e44a21b7-6c3a-40f9-b407-3f4963fafff2
md"""
```julia
  mutable struct Edge{T} <: AbstractEdge{T}
  	name::String
  	node1::Node{T}
  	node2::Node{T}
  	weight
  end
```
"""

# ╔═╡ 5ffd582d-91f5-47d8-a184-d7b62cf76567
md"""
###### Exemple"""

# ╔═╡ 2528cbf0-2499-40d8-bfd3-d5aed9927ea9
md"""
```julia
Type représentant les arrêtes d'un graphe.

Exemples:

        node1 = Node("Joe", 3.14)
        node2 = Node("Steve", exp(1))
        edge1 = Edge("My_edge", node1, node2, -1)
```
"""

# ╔═╡ 7f5af2f7-3a44-4650-af58-c7d9f3600f33
md"""
###### Méthode d'affichage show pour un type edge"""

# ╔═╡ f63c154d-8d96-4f5f-aee2-bf7c748a04ba
md"""
```julia
function show(edge::AbstractEdge)
  println("Edge ", name(edge), ", data: ", data(edge))
end
```
"""

# ╔═╡ 31155df3-05db-4580-9092-d94a6612f162
md"""
```julia
show(edge1)
Edge My_edge, data: Node{Float64}[Node{Float64}("Joe", 3.14), Node{Float64}("Steve", 2.718281828459045)]
```
"""

# ╔═╡ 30df8065-0dec-4125-837c-4e12b63cd188
md"""
##### 2. Étendre le type Graph afin qu’un graphe contienne ses arêtes. On se limite ici aux graphes non orientés. L’utilisateur doit pouvoir ajouter une arête à la fois à un graphe.
"""


# ╔═╡ 745a99fb-4d60-4b47-8bcf-2625063e44d8
"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

# ╔═╡ 27d7a59f-e0f9-4f2f-a2aa-d75533e79cd5
md"""
```julia
abstract type AbstractGraph{T} end
```
"""

# ╔═╡ 0bdcedde-9929-4fc7-b228-b1b7d316e0cd
md"""
###### Le type Graph est défini par un string, un vecteur contenant tous les noeuds et un vecteur contenant tous les arrêtes"""

# ╔═╡ c6850f73-7c04-4b96-a1da-b8f49b59e4e4
"""Type abstrait dont d'autres types de noeuds dériveront."""
mutable struct Graph{T} <: AbstractGraph{T}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T}}
end

# ╔═╡ a57675c8-5a8b-4bfb-b1e6-7f25474f8e00
md"""
```julia
mutable struct Graph{T} <: AbstractGraph{T}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T}}
end
```
"""

# ╔═╡ 672df196-932f-49dc-8f74-06261a9b0c24
"""Ajoute une arrete au graphe."""
function add_edge!(graph::Graph{T}, edge::Edge{T}) where T
  push!(graph.edges, edge)
  graph
end

# ╔═╡ 08f2d26d-3610-441b-b2dd-53497e904867
md"""
```julia
function add_edge!(graph::Graph{T}, edge::Edge{T}) where T
  push!(graph.edges, edge)
  graph
end
```
"""

# ╔═╡ 27a93db8-21ef-4211-af5e-e3844719bf18
md"""
```julia
Type representant un graphe comme un ensemble de noeuds.

Exemple :

    node1 = Node("Joe", 3.14)
    node2 = Node("Steve", exp(1))
    node3 = Node("Jill", 4.12)
    edge12 = Edge("1-2", node1, node2, 0.5)
    edge13 = Edge("1-3", node1, node3, 0.5)
    graph = Graph("Ick", [node1, node2, node3], [edge12, edge3])
```
"""

# ╔═╡ 790f95ac-38f5-4546-8503-8a969aa33918
md"""
##### 3. Étendre la méthode d’affichage show d’un objet de type Graph afin que les arêtes du graphe soient également affichées.
"""

# ╔═╡ b986cefa-821b-47aa-93c3-b1a9422812db
md"""
```julia
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and ", nb_edges(graph), " edges ")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end
```
"""

# ╔═╡ 9ec73446-5542-4c64-ace1-09f004285f91
md"""
```julia
show(graph)
Graph Ick has 3 nodes and 2 edges 
Node Joe, data: 3.14
Node Steve, data: 2.718281828459045
Node Jill, data: 4.12
Edge 1-2, data: Node{Float64}[Node{Float64}("Joe", 3.14), Node{Float64}("Steve", 2.718281828459045)]
Edge 1-3, data: Node{Float64}[Node{Float64}("Joe", 3.14), Node{Float64}("Jill", 4.12)]
```
"""

# ╔═╡ 723b6ebd-36be-4ea0-9669-ea9250592d78
md"""
##### 4. Étendre la fonction read\_edges() de read\_stsp.jl afin de lire les poids des arêtes (ils sont actuellement ignorés).
"""

# ╔═╡ 08300d8f-c079-4a2e-a102-b70f567f439c
md"""
###### La modification dans cette fonction a été l'ajout des lignes suivantes dans read\_edges()"""

# ╔═╡ c8b75398-f53c-40ad-8124-0949ecef02e1
md"""
```julia
	weights = []
	weight = parse(Float64, data[j + 1])
	push!(weights, weight)
	return edges, weights
```
"""

# ╔═╡ e22a9bd2-3692-4ef2-af7b-2136c82edf09
"""Analyse un fichier .tsp et renvoie l'ensemble des arêtes sous la forme d'un tableau ainsi que leurs poids."""
function read_edges(header::Dict{String}{String}, filename::String)

  edges = []
  weights = []
  edge_weight_format = header["EDGE_WEIGHT_FORMAT"]
  known_edge_weight_formats = ["FULL_MATRIX", "UPPER_ROW", "LOWER_ROW",
  "UPPER_DIAG_ROW", "LOWER_DIAG_ROW", "UPPER_COL", "LOWER_COL",
  "UPPER_DIAG_COL", "LOWER_DIAG_COL"]

  if !(edge_weight_format in known_edge_weight_formats)
    @warn "unknown edge weight format" edge_weight_format
    return edges
  end

  file = open(filename, "r")
  dim = parse(Int, header["DIMENSION"])
  edge_weight_section = false
  k = 0
  n_edges = 0
  i = 0
  n_to_read = n_nodes_to_read(edge_weight_format, k, dim)
  flag = false

  for line in eachline(file)
    line = strip(line)
    if !flag
      if occursin(r"^EDGE_WEIGHT_SECTION", line)
        edge_weight_section = true
        continue
      end

      if edge_weight_section
        data = split(line)
        n_data = length(data)
        start = 0
        while n_data > 0
          n_on_this_line = min(n_to_read, n_data)

          for j = start : start + n_on_this_line - 1
            n_edges = n_edges + 1
            if edge_weight_format in ["UPPER_ROW", "LOWER_COL"]
              edge = (k+1, i+k+2)
              weight = parse(Float64, data[j + 1])
            elseif edge_weight_format in ["UPPER_DIAG_ROW", "LOWER_DIAG_COL"]
              edge = (k+1, i+k+1)
              weight = parse(Float64, data[j + 1])
            elseif edge_weight_format in ["UPPER_COL", "LOWER_ROW"]
              edge = (i+k+2, k+1)
              weight = parse(Float64, data[j + 1])
            elseif edge_weight_format in ["UPPER_DIAG_COL", "LOWER_DIAG_ROW"]
              edge = (i+1, k+1)
              weight = parse(Float64, data[j + 1])
            elseif edge_weight_format == "FULL_MATRIX"
              edge = (k+1, i+1)
              weight = parse(Float64, data[j + 1])
            else
              warn("Unknown format - function read_edges")
            end
            push!(edges, edge)
            push!(weights, weight)
            i += 1
          end

          n_to_read -= n_on_this_line
          n_data -= n_on_this_line

          if n_to_read <= 0
            start += n_on_this_line
            k += 1
            i = 0
            n_to_read = n_nodes_to_read(edge_weight_format, k, dim)
          end

          if k >= dim
            n_data = 0
            flag = true
          end
        end
      end
    end
  end
  close(file)
  return edges, weights
end

# ╔═╡ c26f3ba4-6f9f-481c-809e-beb79fbe4ae4
md"""
###### Exemple d'utilisation"""

# ╔═╡ 1b924b80-7a08-406a-b8ec-caa56c0d0f09
md"""
```julia
edges_bayg29, weights_bayg29 = read_edges(read_header("instances/stsp/bayg29.tsp"), "instances/stsp/bayg29.tsp")
```
"""

# ╔═╡ 4c403f99-5aa0-4b2a-9f3b-1777331ea4c7
md"""
```julia
edges_bayg29
406-element Vector{Any}:
 (1, 2)
 (1, 3)
 (1, 4)
 (1, 5)
 (1, 6)
 (1, 7)
 (1, 8)
 (1, 9)
 (1, 10)
 ⋮
 (25, 27)
 (25, 28)
 (25, 29)
 (26, 27)
 (26, 28)
 (26, 29)
 (27, 28)
 (27, 29)
 (28, 29)
```
"""

# ╔═╡ aa11233e-704d-4667-a859-fe0375ac2447
md"""
```julia
weights_bayg29
406-element Vector{Any}:
  97.0
 205.0
 139.0
  86.0
  60.0
 220.0
  65.0
 111.0
 115.0
   ⋮
 120.0
 205.0
 270.0
 213.0
 145.0
  36.0
  94.0
 217.0
 162.0
```
"""

# ╔═╡ 613362b9-ce0d-4d74-a1e3-8e88a0859249
md"""
##### 6. Fournir un programme principal qui lit une instance de TSP symétrique dont les poids sont donnés au format EXPLICIT et construit un objet de type Graph correspondant.

"""

# ╔═╡ 31731546-f972-4e36-8508-623ab6ff257e
md"""
###### a. D'abord on commence par ecrire une fonction qui permet de construire un vecteur de noeuds étant donné un dictionnaire de noeud renvoyée par read_nodes 

"""

# ╔═╡ 22ac3ee9-240c-4ce4-b715-f39d2cfa3d19
md"""
```julia
function convert_to_node(nodes)
    vect_nodes = []
    for (keys, vals) in nodes
        node = Node(string(keys), vals)
        push!(vect_nodes, node)
    end
    return Vector{typeof(vect_nodes[1])}(vect_nodes)
end
```
"""

# ╔═╡ d6bda406-8816-498a-ba04-a44ee55b22f8
md"""
###### b. Ensuite on écrit une fonction qui permet de construire une arrete étant donné les arretes renvoyées par read_edges

"""

# ╔═╡ eeb72bd5-07e6-4929-ae86-75b558b9faea
md"""
```julia
function convert_to_edge(edge, weight, nodes)
    node1 = nodes[edge[1]]
    node2 = nodes[edge[2]]
    edge = Edge(string(edge[1]) * "-" * string(edge[2]), node1, node2, weight)
    return edge
end
```
"""

# ╔═╡ c4967e1a-6819-4c22-a9c6-755292f82096
md"""
###### c. Enfin on écrit une fonction qui permet de generer les noeuds dans le cas où l'instance ne contient pas un data pour les noeuds, par défaut on fixe les nodes.data = 0

"""

# ╔═╡ d94e7200-a865-43a3-b925-16d8f5bb77eb
md"""
```julia
function generate_nodes(dim)
    vect_nodes = []
    for i = 1:dim
        node = Node(string(i), 0)
        push!(vect_nodes, node)
    end
    return Vector{typeof(vect_nodes[1])}(vect_nodes)
end
```
"""

# ╔═╡ b7b7fbe5-3916-40df-a234-af6323f59778
md"""
##### Exemples d'uitlisations pour deux types d'instance gr17.tsp et bayg29.tsp

"""

# ╔═╡ 862508d7-df53-475e-9120-65d2190f9b42
md""" 
##### gr17.tsp instance"""

# ╔═╡ 0bffd22b-a0fe-4422-b499-f3fd4079b057
md"""
```julia
gr17 = graph_from_instance("instances/stsp/gr17.tsp");
```
"""

# ╔═╡ ef052e46-e9a2-4dde-9e6f-ceb9bd066de1
md"""
```julia
show(gr17)
Graph gr17 has 17 nodes and 153 edges 
Node 1, data: 0
Node 2, data: 0
Node 3, data: 0
Node 4, data: 0
Node 5, data: 0
Node 6, data: 0
Node 7, data: 0
Node 8, data: 0
Node 9, data: 0
Node 10, data: 0
Node 11, data: 0
Node 12, data: 0
Node 13, data: 0
Node 14, data: 0
Node 15, data: 0
Node 16, data: 0
Node 17, data: 0
Edge 1-1, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("1", 0)]
Edge 1-2, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("2", 0)]
Edge 2-2, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("2", 0)]
Edge 1-3, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("3", 0)]
Edge 2-3, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("3", 0)]
Edge 3-3, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("3", 0)]
Edge 1-4, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("4", 0)]
Edge 2-4, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("4", 0)]
Edge 3-4, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("4", 0)]
Edge 4-4, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("4", 0)]
Edge 1-5, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("5", 0)]
Edge 2-5, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("5", 0)]
Edge 3-5, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("5", 0)]
Edge 4-5, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("5", 0)]
Edge 5-5, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("5", 0)]
Edge 1-6, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("6", 0)]
Edge 2-6, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("6", 0)]
Edge 3-6, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("6", 0)]
Edge 4-6, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("6", 0)]
Edge 5-6, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("6", 0)]
Edge 6-6, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("6", 0)]
Edge 1-7, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("7", 0)]
Edge 2-7, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("7", 0)]
Edge 3-7, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("7", 0)]
Edge 4-7, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("7", 0)]
Edge 5-7, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("7", 0)]
Edge 6-7, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("7", 0)]
Edge 7-7, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("7", 0)]
Edge 1-8, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("8", 0)]
Edge 2-8, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("8", 0)]
Edge 3-8, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("8", 0)]
Edge 4-8, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("8", 0)]
Edge 5-8, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("8", 0)]
Edge 6-8, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("8", 0)]
Edge 7-8, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("8", 0)]
Edge 8-8, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("8", 0)]
Edge 1-9, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("9", 0)]
Edge 2-9, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("9", 0)]
Edge 3-9, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("9", 0)]
Edge 4-9, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("9", 0)]
Edge 5-9, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("9", 0)]
Edge 6-9, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("9", 0)]
Edge 7-9, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("9", 0)]
Edge 8-9, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("9", 0)]
Edge 9-9, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("9", 0)]
Edge 1-10, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("10", 0)]
Edge 2-10, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("10", 0)]
Edge 3-10, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("10", 0)]
Edge 4-10, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("10", 0)]
Edge 5-10, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("10", 0)]
Edge 6-10, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("10", 0)]
Edge 7-10, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("10", 0)]
Edge 8-10, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("10", 0)]
Edge 9-10, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("10", 0)]
Edge 10-10, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("10", 0)]
Edge 1-11, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("11", 0)]
Edge 2-11, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("11", 0)]
Edge 3-11, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("11", 0)]
Edge 4-11, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("11", 0)]
Edge 5-11, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("11", 0)]
Edge 6-11, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("11", 0)]
Edge 7-11, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("11", 0)]
Edge 8-11, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("11", 0)]
Edge 9-11, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("11", 0)]
Edge 10-11, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("11", 0)]
Edge 11-11, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("11", 0)]
Edge 1-12, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("12", 0)]
Edge 2-12, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("12", 0)]
Edge 3-12, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("12", 0)]
Edge 4-12, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("12", 0)]
Edge 5-12, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("12", 0)]
Edge 6-12, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("12", 0)]
Edge 7-12, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("12", 0)]
Edge 8-12, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("12", 0)]
Edge 9-12, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("12", 0)]
Edge 10-12, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("12", 0)]
Edge 11-12, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("12", 0)]
Edge 12-12, data: Node{Int64}[Node{Int64}("12", 0), Node{Int64}("12", 0)]
Edge 1-13, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("13", 0)]
Edge 2-13, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("13", 0)]
Edge 3-13, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("13", 0)]
Edge 4-13, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("13", 0)]
Edge 5-13, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("13", 0)]
Edge 6-13, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("13", 0)]
Edge 7-13, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("13", 0)]
Edge 8-13, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("13", 0)]
Edge 9-13, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("13", 0)]
Edge 10-13, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("13", 0)]
Edge 11-13, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("13", 0)]
Edge 12-13, data: Node{Int64}[Node{Int64}("12", 0), Node{Int64}("13", 0)]
Edge 13-13, data: Node{Int64}[Node{Int64}("13", 0), Node{Int64}("13", 0)]
Edge 1-14, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("14", 0)]
Edge 2-14, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("14", 0)]
Edge 3-14, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("14", 0)]
Edge 4-14, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("14", 0)]
Edge 5-14, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("14", 0)]
Edge 6-14, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("14", 0)]
Edge 7-14, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("14", 0)]
Edge 8-14, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("14", 0)]
Edge 9-14, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("14", 0)]
Edge 10-14, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("14", 0)]
Edge 11-14, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("14", 0)]
Edge 12-14, data: Node{Int64}[Node{Int64}("12", 0), Node{Int64}("14", 0)]
Edge 13-14, data: Node{Int64}[Node{Int64}("13", 0), Node{Int64}("14", 0)]
Edge 14-14, data: Node{Int64}[Node{Int64}("14", 0), Node{Int64}("14", 0)]
Edge 1-15, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("15", 0)]
Edge 2-15, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("15", 0)]
Edge 3-15, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("15", 0)]
Edge 4-15, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("15", 0)]
Edge 5-15, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("15", 0)]
Edge 6-15, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("15", 0)]
Edge 7-15, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("15", 0)]
Edge 8-15, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("15", 0)]
Edge 9-15, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("15", 0)]
Edge 10-15, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("15", 0)]
Edge 11-15, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("15", 0)]
Edge 12-15, data: Node{Int64}[Node{Int64}("12", 0), Node{Int64}("15", 0)]
Edge 13-15, data: Node{Int64}[Node{Int64}("13", 0), Node{Int64}("15", 0)]
Edge 14-15, data: Node{Int64}[Node{Int64}("14", 0), Node{Int64}("15", 0)]
Edge 15-15, data: Node{Int64}[Node{Int64}("15", 0), Node{Int64}("15", 0)]
Edge 1-16, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("16", 0)]
Edge 2-16, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("16", 0)]
Edge 3-16, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("16", 0)]
Edge 4-16, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("16", 0)]
Edge 5-16, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("16", 0)]
Edge 6-16, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("16", 0)]
Edge 7-16, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("16", 0)]
Edge 8-16, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("16", 0)]
Edge 9-16, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("16", 0)]
Edge 10-16, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("16", 0)]
Edge 11-16, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("16", 0)]
Edge 12-16, data: Node{Int64}[Node{Int64}("12", 0), Node{Int64}("16", 0)]
Edge 13-16, data: Node{Int64}[Node{Int64}("13", 0), Node{Int64}("16", 0)]
Edge 14-16, data: Node{Int64}[Node{Int64}("14", 0), Node{Int64}("16", 0)]
Edge 15-16, data: Node{Int64}[Node{Int64}("15", 0), Node{Int64}("16", 0)]
Edge 16-16, data: Node{Int64}[Node{Int64}("16", 0), Node{Int64}("16", 0)]
Edge 1-17, data: Node{Int64}[Node{Int64}("1", 0), Node{Int64}("17", 0)]
Edge 2-17, data: Node{Int64}[Node{Int64}("2", 0), Node{Int64}("17", 0)]
Edge 3-17, data: Node{Int64}[Node{Int64}("3", 0), Node{Int64}("17", 0)]
Edge 4-17, data: Node{Int64}[Node{Int64}("4", 0), Node{Int64}("17", 0)]
Edge 5-17, data: Node{Int64}[Node{Int64}("5", 0), Node{Int64}("17", 0)]
Edge 6-17, data: Node{Int64}[Node{Int64}("6", 0), Node{Int64}("17", 0)]
Edge 7-17, data: Node{Int64}[Node{Int64}("7", 0), Node{Int64}("17", 0)]
Edge 8-17, data: Node{Int64}[Node{Int64}("8", 0), Node{Int64}("17", 0)]
Edge 9-17, data: Node{Int64}[Node{Int64}("9", 0), Node{Int64}("17", 0)]
Edge 10-17, data: Node{Int64}[Node{Int64}("10", 0), Node{Int64}("17", 0)]
Edge 11-17, data: Node{Int64}[Node{Int64}("11", 0), Node{Int64}("17", 0)]
Edge 12-17, data: Node{Int64}[Node{Int64}("12", 0), Node{Int64}("17", 0)]
Edge 13-17, data: Node{Int64}[Node{Int64}("13", 0), Node{Int64}("17", 0)]
Edge 14-17, data: Node{Int64}[Node{Int64}("14", 0), Node{Int64}("17", 0)]
Edge 15-17, data: Node{Int64}[Node{Int64}("15", 0), Node{Int64}("17", 0)]
Edge 16-17, data: Node{Int64}[Node{Int64}("16", 0), Node{Int64}("17", 0)]
Edge 17-17, data: Node{Int64}[Node{Int64}("17", 0), Node{Int64}("17", 0)]
```
"""

# ╔═╡ 371fa564-4f04-4076-a1af-28dedf4dda40
md""" 
##### bayg.tsp instance"""

# ╔═╡ 1659cf1f-54ea-44c1-a92c-4407b1851e72
md"""
```julia
bayg29 = graph_from_instance("instances/stsp/bayg29.tsp");
```
"""

# ╔═╡ 8b40c37f-0d8f-4c19-aed8-6a42785d4eee
md"""
```julia
show(bayg29)
Graph bayg29 has 29 nodes and 406 edges 
Node 5, data: [750.0, 2030.0]
Node 16, data: [1280.0, 1200.0]
Node 20, data: [590.0, 1390.0]
Node 12, data: [1170.0, 2300.0]
Node 24, data: [1260.0, 1500.0]
Node 28, data: [1260.0, 1910.0]
Node 8, data: [1490.0, 1630.0]
Node 17, data: [230.0, 590.0]
Node 1, data: [1150.0, 1760.0]
Node 19, data: [1040.0, 950.0]
Node 22, data: [490.0, 500.0]
Node 23, data: [1840.0, 1240.0]
Node 6, data: [1030.0, 2070.0]
Node 11, data: [840.0, 550.0]
Node 9, data: [790.0, 2260.0]
Node 14, data: [510.0, 700.0]
Node 3, data: [40.0, 2090.0]
Node 29, data: [360.0, 1980.0]
Node 7, data: [1650.0, 650.0]
Node 25, data: [1280.0, 790.0]
Node 4, data: [750.0, 1100.0]
Node 13, data: [970.0, 1340.0]
Node 15, data: [750.0, 900.0]
Node 2, data: [630.0, 1660.0]
Node 10, data: [710.0, 1310.0]
Node 18, data: [460.0, 860.0]
Node 21, data: [830.0, 1770.0]
Node 26, data: [490.0, 2130.0]
Node 27, data: [1460.0, 1420.0]
Edge 1-2, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("16", [1280.0, 1200.0])]
Edge 1-3, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("20", [590.0, 1390.0])]
Edge 1-4, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("12", [1170.0, 2300.0])]
Edge 1-5, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("24", [1260.0, 1500.0])]
Edge 1-6, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("28", [1260.0, 1910.0])]
Edge 1-7, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("8", [1490.0, 1630.0])]
Edge 1-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 1-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 1-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 1-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 1-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 1-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 1-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 1-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 1-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 1-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 1-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 1-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 1-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 1-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 1-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 1-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 1-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 1-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 1-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 1-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 1-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 1-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("5", [750.0, 2030.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 2-3, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("20", [590.0, 1390.0])]
Edge 2-4, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("12", [1170.0, 2300.0])]
Edge 2-5, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("24", [1260.0, 1500.0])]
Edge 2-6, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("28", [1260.0, 1910.0])]
Edge 2-7, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("8", [1490.0, 1630.0])]
Edge 2-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 2-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 2-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 2-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 2-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 2-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 2-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 2-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 2-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 2-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 2-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 2-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 2-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 2-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 2-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 2-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 2-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 2-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 2-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 2-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 2-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 2-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("16", [1280.0, 1200.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 3-4, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("12", [1170.0, 2300.0])]
Edge 3-5, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("24", [1260.0, 1500.0])]
Edge 3-6, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("28", [1260.0, 1910.0])]
Edge 3-7, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("8", [1490.0, 1630.0])]
Edge 3-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 3-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 3-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 3-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 3-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 3-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 3-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 3-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 3-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 3-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 3-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 3-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 3-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 3-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 3-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 3-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 3-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 3-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 3-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 3-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 3-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 3-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("20", [590.0, 1390.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 4-5, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("24", [1260.0, 1500.0])]
Edge 4-6, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("28", [1260.0, 1910.0])]
Edge 4-7, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("8", [1490.0, 1630.0])]
Edge 4-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 4-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 4-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 4-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 4-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 4-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 4-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 4-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 4-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 4-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 4-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 4-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 4-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 4-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 4-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 4-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 4-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 4-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 4-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 4-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 4-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 4-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("12", [1170.0, 2300.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 5-6, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("28", [1260.0, 1910.0])]
Edge 5-7, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("8", [1490.0, 1630.0])]
Edge 5-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 5-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 5-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 5-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 5-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 5-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 5-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 5-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 5-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 5-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 5-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 5-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 5-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 5-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 5-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 5-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 5-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 5-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 5-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 5-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 5-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 5-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("24", [1260.0, 1500.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 6-7, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("8", [1490.0, 1630.0])]
Edge 6-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 6-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 6-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 6-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 6-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 6-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 6-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 6-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 6-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 6-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 6-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 6-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 6-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 6-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 6-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 6-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 6-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 6-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 6-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 6-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 6-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 6-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("28", [1260.0, 1910.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 7-8, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("17", [230.0, 590.0])]
Edge 7-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 7-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 7-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 7-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 7-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 7-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 7-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 7-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 7-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 7-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 7-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 7-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 7-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 7-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 7-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 7-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 7-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 7-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 7-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 7-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 7-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("8", [1490.0, 1630.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 8-9, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("1", [1150.0, 1760.0])]
Edge 8-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 8-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 8-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 8-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 8-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 8-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 8-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 8-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 8-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 8-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 8-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 8-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 8-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 8-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 8-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 8-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 8-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 8-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 8-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 8-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("17", [230.0, 590.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 9-10, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("19", [1040.0, 950.0])]
Edge 9-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 9-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 9-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 9-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 9-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 9-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 9-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 9-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 9-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 9-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 9-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 9-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 9-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 9-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 9-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 9-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 9-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 9-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 9-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("1", [1150.0, 1760.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 10-11, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("22", [490.0, 500.0])]
Edge 10-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 10-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 10-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 10-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 10-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 10-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 10-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 10-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 10-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 10-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 10-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 10-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 10-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 10-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 10-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 10-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 10-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 10-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("19", [1040.0, 950.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 11-12, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("23", [1840.0, 1240.0])]
Edge 11-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 11-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 11-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 11-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 11-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 11-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 11-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 11-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 11-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 11-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 11-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 11-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 11-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 11-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 11-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 11-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 11-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("22", [490.0, 500.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 12-13, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("6", [1030.0, 2070.0])]
Edge 12-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 12-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 12-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 12-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 12-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 12-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 12-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 12-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 12-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 12-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 12-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 12-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 12-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 12-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 12-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 12-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("23", [1840.0, 1240.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 13-14, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("11", [840.0, 550.0])]
Edge 13-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 13-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 13-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 13-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 13-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 13-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 13-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 13-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 13-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 13-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 13-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 13-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 13-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 13-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 13-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("6", [1030.0, 2070.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 14-15, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("9", [790.0, 2260.0])]
Edge 14-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 14-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 14-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 14-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 14-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 14-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 14-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 14-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 14-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 14-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 14-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 14-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 14-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 14-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("11", [840.0, 550.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 15-16, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("14", [510.0, 700.0])]
Edge 15-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 15-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 15-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 15-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 15-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 15-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 15-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 15-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 15-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 15-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 15-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 15-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 15-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("9", [790.0, 2260.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 16-17, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("3", [40.0, 2090.0])]
Edge 16-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 16-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 16-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 16-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 16-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 16-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 16-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 16-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 16-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 16-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 16-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 16-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("14", [510.0, 700.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 17-18, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("29", [360.0, 1980.0])]
Edge 17-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 17-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 17-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 17-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 17-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 17-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 17-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 17-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 17-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 17-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 17-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("3", [40.0, 2090.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 18-19, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("7", [1650.0, 650.0])]
Edge 18-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 18-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 18-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 18-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 18-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 18-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 18-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 18-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 18-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 18-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("29", [360.0, 1980.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 19-20, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("25", [1280.0, 790.0])]
Edge 19-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 19-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 19-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 19-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 19-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 19-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 19-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 19-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 19-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("7", [1650.0, 650.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 20-21, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("4", [750.0, 1100.0])]
Edge 20-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 20-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 20-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 20-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 20-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 20-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 20-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 20-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("25", [1280.0, 790.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 21-22, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("13", [970.0, 1340.0])]
Edge 21-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 21-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 21-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 21-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 21-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 21-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 21-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("4", [750.0, 1100.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 22-23, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("15", [750.0, 900.0])]
Edge 22-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 22-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 22-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 22-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 22-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 22-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("13", [970.0, 1340.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 23-24, data: Node{Vector{Float64}}[Node{Vector{Float64}}("15", [750.0, 900.0]), Node{Vector{Float64}}("2", [630.0, 1660.0])]
Edge 23-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("15", [750.0, 900.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 23-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("15", [750.0, 900.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 23-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("15", [750.0, 900.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 23-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("15", [750.0, 900.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 23-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("15", [750.0, 900.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 24-25, data: Node{Vector{Float64}}[Node{Vector{Float64}}("2", [630.0, 1660.0]), Node{Vector{Float64}}("10", [710.0, 1310.0])]
Edge 24-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("2", [630.0, 1660.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 24-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("2", [630.0, 1660.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 24-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("2", [630.0, 1660.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 24-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("2", [630.0, 1660.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 25-26, data: Node{Vector{Float64}}[Node{Vector{Float64}}("10", [710.0, 1310.0]), Node{Vector{Float64}}("18", [460.0, 860.0])]
Edge 25-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("10", [710.0, 1310.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 25-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("10", [710.0, 1310.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 25-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("10", [710.0, 1310.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 26-27, data: Node{Vector{Float64}}[Node{Vector{Float64}}("18", [460.0, 860.0]), Node{Vector{Float64}}("21", [830.0, 1770.0])]
Edge 26-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("18", [460.0, 860.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 26-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("18", [460.0, 860.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 27-28, data: Node{Vector{Float64}}[Node{Vector{Float64}}("21", [830.0, 1770.0]), Node{Vector{Float64}}("26", [490.0, 2130.0])]
Edge 27-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("21", [830.0, 1770.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
Edge 28-29, data: Node{Vector{Float64}}[Node{Vector{Float64}}("26", [490.0, 2130.0]), Node{Vector{Float64}}("27", [1460.0, 1420.0])]
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "348ed7e828d2091a44e211d4df367eb5f2d0eb19"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
"""

# ╔═╡ Cell order:
# ╠═d60f02ce-0a83-4edb-9747-b3de9ba1ae2b
# ╠═5dfaa4bb-f544-43df-a390-a9e326784fed
# ╠═7ea81498-700d-4402-bea4-37b5203d088f
# ╟─5b0505f0-ab35-4ebc-9458-1914a54c7bfa
# ╟─56c69abe-5f9d-433d-87ee-ad4d14d7e4ac
# ╟─c49caeea-0bdd-4cd3-8e50-c739befecd98
# ╟─d16af9e4-e9fd-49df-97e4-b6af7193d63f
# ╟─5b9924f3-f260-40be-8144-53d4fd3e0645
# ╟─905d4a8a-9d15-45b3-8e3a-ffb33cd835b3
# ╟─789d0351-e2db-4250-8694-7003fbe1c17b
# ╟─f466942e-7de8-4de4-bd15-cffffb9c006d
# ╟─3c45416e-9c54-48fe-9e63-edcb49afd27c
# ╟─d670b6ea-a115-4a5a-bf9e-0179b05fb447
# ╟─c4165062-dbb5-4e45-ac19-526f9f3ed7ea
# ╟─309b01be-0974-4d12-8230-4779b8983652
# ╟─e44a21b7-6c3a-40f9-b407-3f4963fafff2
# ╟─5ffd582d-91f5-47d8-a184-d7b62cf76567
# ╟─2528cbf0-2499-40d8-bfd3-d5aed9927ea9
# ╟─7f5af2f7-3a44-4650-af58-c7d9f3600f33
# ╟─f63c154d-8d96-4f5f-aee2-bf7c748a04ba
# ╟─31155df3-05db-4580-9092-d94a6612f162
# ╟─30df8065-0dec-4125-837c-4e12b63cd188
# ╟─745a99fb-4d60-4b47-8bcf-2625063e44d8
# ╟─27d7a59f-e0f9-4f2f-a2aa-d75533e79cd5
# ╟─0bdcedde-9929-4fc7-b228-b1b7d316e0cd
# ╟─c6850f73-7c04-4b96-a1da-b8f49b59e4e4
# ╟─a57675c8-5a8b-4bfb-b1e6-7f25474f8e00
# ╟─672df196-932f-49dc-8f74-06261a9b0c24
# ╟─08f2d26d-3610-441b-b2dd-53497e904867
# ╟─27a93db8-21ef-4211-af5e-e3844719bf18
# ╟─790f95ac-38f5-4546-8503-8a969aa33918
# ╟─b986cefa-821b-47aa-93c3-b1a9422812db
# ╟─9ec73446-5542-4c64-ace1-09f004285f91
# ╟─723b6ebd-36be-4ea0-9669-ea9250592d78
# ╟─08300d8f-c079-4a2e-a102-b70f567f439c
# ╟─c8b75398-f53c-40ad-8124-0949ecef02e1
# ╟─e22a9bd2-3692-4ef2-af7b-2136c82edf09
# ╟─c26f3ba4-6f9f-481c-809e-beb79fbe4ae4
# ╟─1b924b80-7a08-406a-b8ec-caa56c0d0f09
# ╟─4c403f99-5aa0-4b2a-9f3b-1777331ea4c7
# ╟─aa11233e-704d-4667-a859-fe0375ac2447
# ╟─613362b9-ce0d-4d74-a1e3-8e88a0859249
# ╟─31731546-f972-4e36-8508-623ab6ff257e
# ╟─22ac3ee9-240c-4ce4-b715-f39d2cfa3d19
# ╟─d6bda406-8816-498a-ba04-a44ee55b22f8
# ╟─eeb72bd5-07e6-4929-ae86-75b558b9faea
# ╟─c4967e1a-6819-4c22-a9c6-755292f82096
# ╟─d94e7200-a865-43a3-b925-16d8f5bb77eb
# ╟─b7b7fbe5-3916-40df-a234-af6323f59778
# ╟─862508d7-df53-475e-9120-65d2190f9b42
# ╟─0bffd22b-a0fe-4422-b499-f3fd4079b057
# ╟─ef052e46-e9a2-4dde-9e6f-ceb9bd066de1
# ╟─371fa564-4f04-4076-a1af-28dedf4dda40
# ╟─1659cf1f-54ea-44c1-a92c-4407b1851e72
# ╟─8b40c37f-0d8f-4c19-aed8-6a42785d4eee
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
