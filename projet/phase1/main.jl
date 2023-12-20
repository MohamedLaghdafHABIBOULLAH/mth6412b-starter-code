""" Inclure les fichiers du projet"""

include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

""" Cette fonction permet de construire un vecteur de noeuds étant donné un dictionnaire de noeud renvoyée par read_nodes """
function convert_to_node(nodes)
    vect_nodes = []  # Crée un tableau vide pour stocker les nœuds résultants
    
    # Parcourt chaque paire clé-valeur dans le dictionnaire 'nodes'
    for (key, value) in nodes
        # Crée un nouveau nœud (Node) en utilisant la clé (convertie en chaîne) et la valeur
        node = Node(string(key), value)
        
        # Ajoute le nœud à 'vect_nodes'
        push!(vect_nodes, node)
    end
    
    # Retourne un tableau de type Vector contenant les nœuds créés
    return Vector{typeof(vect_nodes[1])}(vect_nodes)
end


""" Cette fonction permet de construire une arrete étant donné les arretes renvoyées par read_edges """
function convert_to_edge(edge, weight, nodes)
    # Récupère les nœuds correspondants aux indices edge[1] et edge[2] à partir du tableau de nœuds 'nodes'
    node1 = nodes[edge[1]]
    node2 = nodes[edge[2]]
    
    # Crée une nouvelle arête (Edge) avec une clé au format "node1-node2", les nœuds node1 et node2, et le poids spécifié
    if weight != 0
        edge = Edge(string(edge[1]) * "-" * string(edge[2]), node1, node2, weight)
    elseif edge[1] == 1 || edge[2] == 1
        edge = Edge(string(edge[1]) * "-" * string(edge[2]), node1, node2, 10000000.)
    end
    # Retourne l'arête créée
    return edge
end

"""Cette fonction permet de generer les noeuds dans le cas où l'instance"""
function generate_nodes(dim)
    vect_nodes = []  # Crée un tableau vide pour stocker les nœuds résultants
    
    # Parcourt les entiers de 1 à 'dim' inclus
    for i = 1:dim
        # Crée un nouveau nœud (Node) avec une clé basée sur la valeur de 'i' et une valeur de data par défaut qui vaut 0
        node = Node(string(i), 0)
        
        # Ajoute le nœud à 'vect_nodes'
        push!(vect_nodes, node)
    end
    
    # Retourne un tableau de type Vector contenant les nœuds créés
    return Vector{typeof(vect_nodes[1])}(vect_nodes)
end

"""Cette fonction permet de generer le graphe étant donné une instance stsp """
function graph_from_instance(filename::String)
    # Lecture de l'en-tête du fichier et extraction de la dimension et des arêtes
    header = read_header(filename)
    dim = parse(Int, header["DIMENSION"])
    edges_inst, weights_inst = read_edges(header, filename)

    # Vérification du type de données d'affichage et génération des nœuds en conséquence
    if header["DISPLAY_DATA_TYPE"] == "None" || header["DISPLAY_DATA_TYPE"] == "NO_DISPLAY"
        nodes = generate_nodes(dim)
    else
        nodes_inst = read_nodes(header, filename)
        nodes = convert_to_node(nodes_inst)
    end

    # Conversion de la première arête et création du graphe initial
    edge = convert_to_edge(edges_inst[1], weights_inst[1], nodes)
    graph = Graph(header["NAME"], nodes, [edge])

    # Ajout des arêtes restantes au graphe
    if length(edges_inst) > 1
        for i = 2:length(edges_inst)
            edges = convert_to_edge(edges_inst[i], weights_inst[i], nodes)
            add_edge!(graph, edges)
        end
    end

    return graph
end

# """Exemples d'utilisation sur deux types d'instances gr17 et bayg29"""
# gr17 = graph_from_instance("instances/stsp/gr17.tsp");
# show(gr17)

# bayg29 = graph_from_instance("instances/stsp/bayg29.tsp");
# show(bayg29)