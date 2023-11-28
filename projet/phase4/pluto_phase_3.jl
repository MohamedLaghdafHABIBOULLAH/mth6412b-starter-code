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

# ╔═╡ 84e7fba6-6aca-45bc-82a2-d14183d0b7d7
using Images

# ╔═╡ 5b0505f0-ab35-4ebc-9458-1914a54c7bfa
md"""
### Mini rapport: Phase 3 du projet
"""

# ╔═╡ 405b4832-dcb4-4b1a-b599-15bd8018fffc
md""" Ulrich Baron-Fournier (2021196) """

# ╔═╡ 56c69abe-5f9d-433d-87ee-ad4d14d7e4ac
md""" Mohamed Laghdaf Habiboullah (2300591) """

# ╔═╡ c49caeea-0bdd-4cd3-8e50-c739befecd98
md"""[https://github.com/MohamedLaghdafHABIBOULLAH/mth6412b-starter-code.git](https://github.com/MohamedLaghdafHABIBOULLAH/mth6412b-starter-code.git)"""

# ╔═╡ 2ca058c6-5f4b-47d1-9282-a8803eaf19c5
md""" Le lecteur peut fork le projet et lancer le fichier phase2/main.jl pour retrouver les résultats ci-dessous"""

# ╔═╡ d16af9e4-e9fd-49df-97e4-b6af7193d63f
md"""
##### 1. Implémentation de RSL
"""

# ╔═╡ 06fd443f-8a9f-441b-871e-fd4e9b4dbbe0
md""" Cet algorithme permet de construire une tournée à partir d'un arbre de recouvrement minimal"""

# ╔═╡ dfa1ac7d-ea19-4a80-a36d-79a08c7282fd
md"""Pour effectuer ceci trois étapes sont nécessaires"""

# ╔═╡ b49c0c9a-2eed-48cb-9ec0-bb5e87a4efd5
md"""
###### a. Find edge in mst"""

# ╔═╡ dff39318-6faf-4857-b907-ebe274299b3b
md"""Cette fonction permet de trouver le edge (présent dans mst) relié a un certain noeud avec le cout le plus faible"""

# ╔═╡ 35985d16-24ad-4100-b456-39966af75864
md"""
```julia
# Cette fonction cherche une arête dans l'arbre couvrant minimum qui peut être ajoutée à la tournée minimale.
# Paramètres :
# edges_mst_sorted - Les arêtes de l'arbre couvrant minimum triées par poids.
# tournee_minimale - La tournée minimale actuelle.
function find_edge_in_mst(edges_mst_sorted, tournee_minimale)
    linkfound = 0  # Indicateur si un lien est trouvé.
    a = 1  # Compteur pour parcourir les arêtes de l'arbre.
    go = 1  # Indicateur pour ajouter l'arête.

    # Parcourt les arêtes de l'arbre couvrant minimum.
    for edge in edges_mst_sorted
        # Vérifie si l'arête peut être connectée à la fin de la tournée actuelle.
        if edge[1] == tournee_minimale[end][2] || edge[2] == tournee_minimale[end][2]
            # Vérifie si l'arête n'est pas déjà dans la tournée.
            for edge_tourne in tournee_minimale[1:end-1]
                if edge_tourne[2] == edge[1] || edge_tourne[2] == edge[2]
                    go = 0
                    break
                end
            end
            # Si l'arête est nouvelle, l'ajoute à la tournée.
            if go == 1
                push!(tournee_minimale, [edge[1], edge[2], edge[3]])
            end
	# Supprime l'arête ajoutée de la liste des arêtes de l'arbre couvrant minimum.
            deleteat!(edges_mst_sorted, a)
            linkfound = 1  # Met à jour l'indicateur de lien trouvé.
            break
        end
        a = a + 1  # Incrémente le compteur pour passer à la prochaine arête.
    end
    return edges_mst_sorted, tournee_minimale, linkfound  # Retourne la liste mise à jour des arêtes, la tournée minimale mise à jour, et l'indicateur de lien trouvé.
end


```
"""


# ╔═╡ a9d0362c-16fe-4dd3-9b7e-0653cb9891bf
md"""
###### b. remonte in edge"""

# ╔═╡ 030c49e2-ebc2-4afd-94d4-e4b5c8a877da
md"""fonction qui remonte dans la tournée pour trouver un noeud qui a un deuxieme lien pour continuer la tournée"""

# ╔═╡ ef57ed90-5304-45f6-807a-40db639c2390
md"""
```julia
# Cette fonction tente de trouver un lien entre la fin de la tournée actuelle et les arêtes restantes.
# Paramètres :
# tournee_minimale - La tournée minimale actuelle.
# edges_mst_sorted - Les arêtes restantes de l'arbre couvrant minimum.
# edges_all - Toutes les arêtes du graphe.
function remonte_in_edge(tournee_minimale, edges_mst_sorted, edges_all)
    linkfound = 0  # Indicateur si un lien est trouvé.
    poid = 0  # Poids de l'arête trouvée.
    a = 1  # Compteur pour parcourir la tournée minimale.
    delete = 0  # Arête à supprimer une fois trouvée.

    # Continue jusqu'à trouver un lien.
    while linkfound == 0
        if a < size(tournee_minimale, 1)
            # Parcourt les arêtes restantes pour trouver une correspondance.
            for edge in edges_mst_sorted
                # Vérifie si l'arête correspond à la fin de la tournée.
                if edge[1] == tournee_minimale[end-a][2] || edge[2] == tournee_minimale[end-a][2]
                    # Trouve le poids de cette arête dans la liste de toutes les arêtes.
                    for edg in edges_all
                        if (edg[1] == edge[1] && edg[2] == edge[2]) || (edg[2] == edge[1] && edg[1] == edge[2])
                            poid = edg[3]
                            break
                        end
                    end
                    # Ajoute l'arête trouvée à la tournée.
                    push!(tournee_minimale, [tournee_minimale[end][2], edge[1] == tournee_minimale[end-a][2] ? edge[2] : edge[1], poid])
                    linkfound = 1  # Met à jour l'indicateur.
                    delete = edge[1] == tournee_minimale[end-a][2] ? edge[1] : edge[2]  # Définit l'arête à supprimer.
                    break
                end
            end
            a = a + 1
        else
            # Parcourt les arêtes pour trouver un lien avec le début de la tournée.
            # Ce bloc est similaire au précédent avec une condition différente pour la correspondance.
        end
    end
    return tournee_minimale, [delete, tournee_minimale[end][2]]  # Retourne la tournée mise à jour et l'arête à supprimer.
end
```
"""



# ╔═╡ cb5024ee-d321-41de-8420-db52408885ff
md"""
###### c. Fonction rsl qui permet de relier le mst"""

# ╔═╡ f995a3b4-dd6d-4cad-9114-3ecf09c8e5a9
md""" Fonction pour construire une tournée minimale en utilisant une liste d'arêtes triées d'un arbre couvrant minimum.
"""

# ╔═╡ 156efa34-b3bd-4040-8d14-4e963036fa6c
md"""
```julia

# Fonction pour construire une tournée minimale en utilisant une liste d'arêtes triées d'un arbre couvrant minimum.

# Paramètres :
# edges_mst_sorted - Les arêtes de l'arbre couvrant minimum triées par poids.
# edges_all - Toutes les arêtes du graphe original.
# root - La racine ou le point de départ pour la tournée.
function rsl(edges_mst_sorted, edges_all, root)
    tournee_minimale = []  # Initialise une liste vide pour la tournée minimale.
    o = 1  # Compteur pour parcourir les arêtes.

    # Parcourt les arêtes triées pour trouver une arête connectée à la racine.
    for edge in edges_mst_sorted
        # Vérifie si l'un des nœuds de l'arête est la racine.
        if root == edge[1]
            push!(tournee_minimale, [root, edge[2], edge[3]])  # Ajoute l'arête à la tournée.
            deleteat!(edges_mst_sorted, o)  # Supprime l'arête de la liste triée.
            break
        elseif root == edge[2]
            push!(tournee_minimale, [root, edge[1], edge[3]])  # Ajoute l'arête à la tournée.
            deleteat!(edges_mst_sorted, o)  # Supprime l'arête de la liste triée.
            break
        end
        o = o + 1
    end

    # Construit la tournée jusqu'à ce que l'arbre couvrant minimum soit vide.
    while !isempty(edges_mst_sorted)
        linkfound = 0  # Indicateur pour vérifier si une arête a été ajoutée à la tournée.

        # Trouve une arête à ajouter à la tournée.
        edges_mst_sorted, tournee_minimale, linkfound = find_edge_in_mst(edges_mst_sorted, tournee_minimale)

        # Si aucune arête n'est trouvée, remonte dans l'arbre pour trouver une connexion.
        if linkfound == 0
            tournee_minimale, couple_delete = remonte_in_edge(tournee_minimale, edges_mst_sorted, edges_all)
            
            # Supprime l'arête correspondante de l'arbre couvrant minimum.
            k = 1
            for edge in edges_mst_sorted
                if couple_delete[1] == edge[1] && couple_delete[2] == edge[2] || couple_delete[1] == edge[2] && couple_delete[2] == edge[1]
                    deleteat!(edges_mst_sorted, k)
                end
                k = k + 1
            end
        end
    end

    total_weight = 0  # Initialise le poids total de la tournée.
    # Ajoute le poids de la liaison entre le dernier et le premier nœud de la tournée.
    for edg in edges_all
        if edg[1] == tournee_minimale[1][1] && edg[2] == tournee_minimale[end][2]
            push!(tournee_minimale, [edg[2], edg[1], edg[3]])
        end
        if edg[2] == tournee_minimale[1][1] && edg[1] == tournee_minimale[end][2]
            push!(tournee_minimale, [edg[1], edg[2], edg[3]])
        end
    end

    # Calcule le poids total de la tournée.
    tem = 0
    for edge in graph_inst.edges
        for i in eachindex(tournee_minimale)
            if (edge.node1.name == string(Int(tournee_minimale[i][1])) && edge.node2.name == string(Int(tournee_minimale[i][2]))) || (edge.node1.name == string(Int(tournee_minimale[i][2])) && edge.node2.name == string(Int(tournee_minimale[i][1])))
                tournee_minimale[i][3] = edge.weight
                tem += edge.weight
            end
        end
    end
    return tournee_minimale, tem
end
```
"""

# ╔═╡ 2e987088-01c4-4d48-a30c-6bc8ed6011f0
md"""
#### 2. Implémentation de HK
"""

# ╔═╡ 47b3ea56-1f74-4ec6-a45a-54836399316a
load("HK_algo.png")

# ╔═╡ 0d8c1aa7-4475-43c8-8728-3fb91fda739e
md""" Where in the line 8, we consider the following equation which take advantages of the past information"""

# ╔═╡ da5a5d62-edf2-4c8b-b811-df0c7825a1c3
md"""
```math
\pi^{k +1} = \pi^k + t^k(0.7v^k + 0.3v^{k-1})
```
"""

# ╔═╡ 4b4ffa50-5025-4891-a3e2-2379a8b3e5a6
md"""
##### a. Minimum 1 treee
"""

# ╔═╡ 8ebd8bbb-18c5-4e3b-bf1a-53f71c09cf43
md""" Cet algorithme constitue une variante du mst basée sur la notion de 1-Tree"""

# ╔═╡ b5ceb95b-ed81-4bc2-888c-f858203d42f0
md"""Soit G = (N, E) un graphe complet, c'est-à-dire un graphe tel que, pour tous les nœuds i et j de N, il existe une arête (i, j) dans E. L'algorithme commence par trouver un arbre 1-minimal pour G. Cela peut être fait en déterminant un arbre couvrant minimal qui contient les nœuds {2, 3, …, n}, suivi de l'ajout des deux arêtes les plus courtes incidentes au nœud 1."""

# ╔═╡ baa2e0ee-9bf3-4ffe-81cc-a8f5ee347920
md"""
La variante de Kruskal a été choisie car elle est plus efficace et requiert moins d'allocation et avec un petit changement on peut renvoyer un min 1 tree avec un seul parcours sur les edges.
"""

# ╔═╡ 0955f10a-9a63-4828-bda5-823a31738eea
md"""
```julia
# Implémente une variante de l'algorithme de Kruskal pour trouver l'arbre couvrant minimum.

function kruskal_1(node::Node, graph::Graph; heuristique::Symbol=:default)
    edges = sort(graph.edges, by=x -> x.weight)  # Trie les arêtes du graphe par poids.

    # Initialisation de l'arbre couvrant minimum et d'autres structures de données.
    minimum_spanning_tree = Edge{typeof(graph.nodes[1].data)}[]
    pred = Preds(graph.nodes)  # Structure pour la gestion des précurseurs.
    degree = Dict(node.name => 0 for node in graph.nodes)  # Dictionnaire pour garder le degré de chaque nœud.
    total_weight = 0.0  # Poids total de l'arbre couvrant minimum.
    i = 0  # Compteur pour une condition spécifique.

    # Parcours des arêtes triées.
    for edge in edges
        # Vérifie si les nœuds de l'arête sont différents.
        if edge.node1.name != edge.node2.name
            # Condition spécifique liée au nœud initial.
            if edge.node1.name == node.name || edge.node2.name == node.name
                if i < 2
                    i += 1
                    push!(minimum_spanning_tree, edge)  # Ajoute l'arête à l'arbre couvrant minimum.
                    total_weight += edge.weight  # Met à jour le poids total.
                    degree[edge.node1.name] += 1  # Incrémente le degré des nœuds.
                    degree[edge.node2.name] += 1
                end
            # Vérifie si les nœuds appartiennent à des composantes connexes distinctes.
            elseif find(pred, edge.node1.name) != find(pred, edge.node2.name)
                push!(minimum_spanning_tree, edge)  # Ajoute l'arête à l'arbre couvrant minimum.
                # Applique une union en fonction de l'heuristique choisie.
                (heuristique == :default) && union_rank(pred, edge.node1.name, edge.node2.name)
                total_weight += edge.weight  # Met à jour le poids total.
                # Applique une union pour d'autres heuristiques.
                (heuristique == :rank) && union(pred, edge.node1.name, edge.node2.name)
                (heuristique == :comp) && union(pred, edge.node1.name, edge.node2.name)
                degree[edge.node1.name] += 1  # Incrémente le degré des nœuds.
                degree[edge.node2.name] += 1
            end
        end
    end

    # Retourne l'arbre couvrant minimum, le poids total, et les degrés des nœuds.
    return minimum_spanning_tree, total_weight, degree
end
```
"""

# ╔═╡ a0fccfab-051a-4761-93f4-8bedf42ac8a2
md"""
###### b. HK_Kruskal (basée sur la variante HK comme le montre l'image ci-haut)
"""

# ╔═╡ 322b50f7-1859-4be7-8830-e9f9b1b47e06
md"""
L'idée c'est de résoudre itérativement le probleme du min 1 tree avec des weights imaginaires pour trouver dans le cas idéal une tournée (dans lequel le dgré de chaque noeud c'est 2).
"""

# ╔═╡ 99ae39f7-ab7c-4516-9c76-1992eab8c356
md"""
```julia
# Définit la fonction HK_kruskal. Elle semble viser à trouver un arbre couvrant minimum dans un graphe, mais avec certaines heuristiques et optimisations.

function HK_kruskal(node::Node, graph::Graph, t0, kmax; heuristique::Symbol=:default)
    k = 0  # Initialise le compteur d'itérations
    pi_k = Dict(node.name => 0.0 for node in graph.nodes)  # Initialise un dictionnaire pour stocker certaines valeurs pour chaque nœud.
    new_graph = deepcopy(graph)  # Crée une copie profonde du graphe sur laquelle travailler.

    # Premier appel de la fonction `kruskal_1`. Il pourrait s'agir d'une variation de l'algorithme de Kruskal.
    mst, tt, degree = kruskal_1(node, new_graph; heuristique=heuristique)
    
    t = t0  # Définit la température ou le facteur algorithmique initial.
    v = [value - 2 for value in values(degree)]  # Ajuste les valeurs des degrés des nœuds.
    degree1 = copy(degree)  # Copie le degré pour une utilisation ultérieure.

    # Boucle jusqu'à ce qu'une certaine condition basée sur `v` et `kmax` soit remplie.
    while norm(v) > 0 && k < kmax 
        # Un autre appel de la fonction `kruskal_1` à chaque itération.
        mst, tt, degree = kruskal_1(node, new_graph; heuristique=heuristique)

        # Met à jour les valeurs de `pi_k` en fonction des degrés actuels et précédents des nœuds.
        for key in keys(pi_k)
            pi_k[key] = pi_k[key] + t * (0.7 * (degree[key] - 2) + 0.3 * (degree1[key] - 2))
        end

        # Met à jour les poids des arêtes dans le nouveau graphe.
        for edge in new_graph.edges
            edge.weight = edge.weight + pi_k[edge.node1.name] + pi_k[edge.node2.name]
        end

        # Prépare la prochaine itération.
        degree1 = copy(degree)
        v = [value - 2 for value in values(degree)]
        k += 1
        t = t0 / k  # Ajuste la température ou le facteur.

        # Affiche des informations toutes les 10000 itérations.
        if k % 10000 == 0
            println("k: ", k, ", v: ", norm(v), ", current_tt: ", tt)
        end
    end

    # Après la boucle, ajuste les poids des arêtes de l'arbre couvrant minimum (mst) pour correspondre au graphe original.
    tt = 0.0
    for edge in graph.edges
        for edge_mst in mst
            if edge.name == edge_mst.name
                edge_mst.weight = edge.weight
                tt += edge.weight
            end
        end
    end

    # Retourne l'arbre couvrant minimum, le poids total de l'arbre, `v`, et les degrés des nœuds.
    return mst, tt, v, degree
end
```
"""

# ╔═╡ 3ab02696-69a6-404c-be24-4172a7ea79ab
md"""
##### 3. Le choix des hyper-paramètres
"""

# ╔═╡ 6955c027-e484-4045-a815-57e9c1838ee1
md"""
##### a. Le choix de l'algorithme pour mst
"""

# ╔═╡ c504a3f7-424c-49f0-a4cd-69184f180ecd
md"""
Comme précisé ci-haut kruskal a été maintenu de part son efficacité et du fait qu'il permet dans le cas de la variante HK de concecoir une nouvelle variante kruskal_1 pour retourner 1 min tree en parcourant une seule fois les edges. 
"""

# ╔═╡ 9dd937aa-b74d-4e79-84ad-5a2adec915da
md"""
##### b. Le choix de la racine
"""

# ╔═╡ fd4dc5d8-286b-4639-9d74-4dabbd5ed934
md"""
Le choix de la racine dépend de l'algorithme considéré
"""

# ╔═╡ 2454fd39-3818-415d-af34-c0e71beb6d45
md"""
```julia
## Routine pour trouver le root et le mêtre à la racine de la tournée
tournee_minimale = []
    o = 1
    for edge in edges_mst_sorted
        if root == edge[1]
            push!(tournee_minimale, [root, edge[2], edge[3]])
            deleteat!(edges_mst_sorted, o)
            break
        elseif root == edge[2]
            push!(tournee_minimale, [root, edge[1], edge[3]])
            deleteat!(edges_mst_sorted, o)
            break
        end
        o = o + 1
    end
```
"""

# ╔═╡ 4dc47be6-085f-400a-ba2a-5512e6339648
md"""
###### Instance gr17
"""

# ╔═╡ a218b467-fda3-4bc1-afbe-e69debcd31e8
md"""
Pour cette instance on teste l'algorithme RSL avec root 1 comme suit:
"""

# ╔═╡ ac0fb07b-16fc-4e0c-b021-8b8793366b17
md"""
```julia
Exemple d'utilisation:
toumin, weight_root = rsl(edges_mst_sorted, vector_edge_all, 1)

tournee minimale: Any[[1.0, 13.0, 70.0], [13.0, 4.0, 27.0], [4.0, 9.0, 175.0], [9.0, 12.0, 95.0], [12.0, 16.0, 157.0], [16.0, 7.0, 332.0], [7.0, 8.0, 29.0], [8.0, 6.0, 34.0], [6.0, 17.0, 35.0], [17.0, 14.0, 96.0], [14.0, 15.0, 57.0], [15.0, 3.0, 53.0], [3.0, 11.0, 110.0], [11.0, 5.0, 61.0], [5.0, 2.0, 227.0], [2.0, 10.0, 289.0], [10.0, 1.0, 505.0]]

weight_root 2352.0
```
"""


# ╔═╡ 13fc4a3c-ce35-41ea-80af-fc61880d4dd7
md""" Il est à remarquer que ceci constitue bien une tournée qui commence par l'edge 1-13 et se referme en 10-1"""

# ╔═╡ 9947d0ef-2418-4eef-b1da-4d9f5e60a7de
md"""
##### c. Le choix du pas et le critere d'arret de HK
"""

# ╔═╡ d1a0811a-f346-49fc-981f-752cb3eac765
md""" Comme dans le papier le choix a été t= 1/k, où k est le nombre d'itérations et ce choix marche pour l'exemple du cours, le critere d'arret c'est avoir une tournée"""

# ╔═╡ 695da251-f21d-441b-aa4d-994cd8c7f4ba
md"""
###### Illustration sur l'exemple des notes du cours
"""

# ╔═╡ a379ca39-a884-4582-96e4-96a38578c980
md"""
```julia
Exemple de tournée optimale: 

Edge: DE, Weight: 9.0
Edge: AB, Weight: 4.0
Edge: EF, Weight: 10.0
Edge: HA, Weight: 8.0
Edge: CD, Weight: 7.0
Edge: BC, Weight: 8.0
Edge: HI, Weight: 7.0
Edge: GI, Weight: 6.0
Edge: FG, Weight: 2.0

Total Weight: 61.0

v:[0, 0, 0, 0, 0, 0, 0, 0, 0]

```
"""

# ╔═╡ 22463488-0369-47bd-97af-a8f88a13169a
md""" Ceci prouve que notre algorithme même s'il pourrait etre lent comme on verra après, il est correct et converge pour les petites instances."""

# ╔═╡ 8e6353df-1432-43bc-a009-c9b586437e7d
md"""
###### Autres instances
"""

# ╔═╡ 26804d69-2746-493a-a183-abc36aa993f7
md""" Pour les autres instances, le critere v = 0 (ou norm(v) = 0) n'est pas atteignable (parfois même après 100 millions d'itérations), ainsi l'idée est d'estimer le minimum de v (en norme) qui a été rencontré pour chaque one tree et ceci se fait (en itérant 10000 fois par exemple et en stockant le plus petit vectuer v en norme). Ensuite, on applique l'algorithme de RSL pour eventuellement transformer le minimum one tree en une tournée. Cet heuristique a été faite pour les instances suivantes et on constate que ça améliore parfois la solution optimale par rapport à RSL.
"""

# ╔═╡ f8377b73-aa03-44bb-ba91-2569332e0196
md"""
#### 4. Tests et résultats sur des instances du cours.
"""

# ╔═╡ 81976bc3-1f65-44a9-bd0c-def16e9b29d8
md""" On représente pour chaque instance choisie le diagramme qui montre le cout de chaque tournée en changeant de noeud de racine pour RSL suivie de HK."""

# ╔═╡ c4f730d7-2a6a-446e-a9d5-baec7242d9ca
md"""
###### Instance gr17
"""

# ╔═╡ 360c1413-2b3c-4605-a40b-921e7e8654a2
md"""
Cette instance du TSP comporte 17 noeuds complètement connecté avec un weight optimal de 2085.
"""

# ╔═╡ 9dc2b8d0-015d-4f7e-ba32-13cf76a65180
md"""
En utilisant l'algorithme RSL
"""

# ╔═╡ 5d2ec52e-dadd-4f45-a7ab-f788c62d4060
load("barplot.png")

# ╔═╡ 1056f9d9-d6f1-47d3-ad00-36a49d11e704
md"""
En utilisant l'algorithme HK avec comme node 15 pour le 1-min-tree
"""

# ╔═╡ 824b020b-4622-487f-8847-455bc707e5cb
load("barplot copy.png")

# ╔═╡ d6b9f8c9-9ace-4b60-ac11-c2693ef2df69
md"""
###### Instance gr24
"""

# ╔═╡ 13794945-2955-4282-8e0d-4b9bcb4925fa
md"""
Cette instance du TSP comporte 24 noeuds complètement connecté avec un weight optimal de 1272.
"""

# ╔═╡ a309e9a5-9224-41fc-a11a-57a3b2b79efd
md"""
En utilisant l'algorithme rsl
"""

# ╔═╡ f787570d-d967-4785-a681-9c423f1d31bd
load("barplot_gr24_rsl.png")

# ╔═╡ c287b09d-f21b-4a9d-a0a1-669e6ec8d0ad
md"""
En utilisant l'algorithme HK avec comme node 2 pour le 1-min-tree
"""

# ╔═╡ 615ba357-8109-46b5-935a-313f0d8a91ae
load("barplot_gr24_hk.png")

# ╔═╡ 560b28f7-fdb8-43c5-b655-1575dfcc6498
md"""
###### Instance brazil58
"""

# ╔═╡ 384581a2-a5ad-4a01-9a97-d107fc747a85
md"""
Cette instance du TSP comporte 58 noeuds complètement connecté avec un weight optimal de 25395.
"""

# ╔═╡ 0dd15cef-e3b5-4c7a-b691-b8fa0d423a2f
md"""
En utilisant l'algorithme rsl
"""

# ╔═╡ e1434a56-9ce3-4c0d-aa91-a1d166fbdf6a
load("barplot_brazil58_rsl.png")

# ╔═╡ 52a28df6-7b6c-439e-ae2e-dd923c902c54
md"""
En utilisant l'algorithme HK avec comme node 1 pour le 1-min-tree
"""

# ╔═╡ d5bf41ed-edeb-402a-a535-e6be95ae2609
load("barplot_brazil58_hk_1 copy.png")

# ╔═╡ b53c0154-512e-4cfa-ad91-334ecad0c384
md"""
##### Erreur relative
"""

# ╔═╡ f8076bd4-7f16-47cc-9d2b-a0373be7c0b5
load("diag.png")

# ╔═╡ 45a11b7b-a339-4b60-a083-22be2b1f2abf
md"""
##### Conclusion:
"""

# ╔═╡ 6ac94edd-35ac-4163-b442-f065f9ef5f0e
md""" Le graphique présente l'erreur relative entre le poid total d'une tournée obtenue à l'aide d'une des deux méthodes utilisées et la tournée optimale. Pour être en mesure de discuter sur les deux méthodes, l'erreur relative a été calculée sur 3 instances symétriques différentes. Pour l'instance gr17, l'erreur relative est la même pour RSL et HK. Cela veut donc dire que pour gr17, les deux méthodes sont équivalentes et plutôt bonnes, puisque l'erreur relative est d'environ 5%. Pour l'instance gr24, on voit que l'erreur relative est plus élevée (16%-23%), les méthodes ne sont donc pas efficaces sur toutes les instances. De plus, HK donne une meilleure tournée que RSL. Cela veut donc dire que pour un nombre d'itérations assez élevés pour HK et un fine-tuning plus efficace, celui-ci peut donner une meilleure solution que RSL. Pour l'instance brazil58. L'erreur relative est entre 11% et 15%, ce qui est non négligeable, mais mieux que pour gr24. On voit ici que RSL donne une meilleure tournée que HK, mais la différence n'est pas énorme. Il est donc probable que pour plus d'itérations et plus de fine tuning, HK aurait donné une meilleure solution que RSL pour la gande instance brazil58.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"

[compat]
Images = "~0.26.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "cc39b9fc07c6f8f239ab34f1497b2bdde8bd1b75"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "02f731463748db57cc2ebfbd9fbc9ce8280d3433"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "16267cf279190ca7c1b30d020758ced95db89cd0"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.5.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "0c5f81f47bbbcf4aea7b2959135713459170798b"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.5"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "601f7e7b3d36f18790e2caf83a882d88e9b71ff1"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.4"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e0af648f0692ec1691b5d094b8724ba1346281cf"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.18.0"

[[deps.ChangesOfVariables]]
deps = ["InverseFunctions", "LinearAlgebra", "Test"]
git-tree-sha1 = "2fba81a302a7be671aefe194f0525ef231104e7f"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.8"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "70232f82ffaab9dc52585e0dd043b5e0c6b714f1"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.12"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "05f9816a77231b07e634ab8715ba50e5249d6f76"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.5"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "8a62af3e248a8c4bad6b32cbbe663ae02275e32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5225c965635d8c21168e32a12954675e7bea1151"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.10"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "b4fbdd20c889804969571cc589900803edda16b7"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.7.1"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "299dc33549f68299137e51e6d49a13b5b1da9673"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "899050ace26649433ef1af25bc17a815b3db52b7"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.9.0"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "eb8fed28f4994600e29beef49744639d985a04b2"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.16"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "f5356e7203c4a9954962e3757c08033f2efe578a"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.0"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "fc5d1d3443a124fde6e92d0260cd9e064eba69f8"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.1"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "432ae2b430a18c58eb7eca9ef8d0f2db90bc749c"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.8"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "bca20b2f5d00c4fbc192c3212da8fa79f4688009"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.7"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "b0b765ff0b4c3ee20ce6740d843be8dfce48487c"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.3.0"

[[deps.ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "6f0a801136cb9c229aebea0df296cdcd471dbcd1"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.5"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "3ff0ca203501c3eedde3c6fa7fd76b703c336b5f"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.2"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "7ec124670cbce8f9f0267ba703396960337e54b5"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.0"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "d438268ed7a665f8322572be0dabda83634d5f45"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.0"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3d09a9f60edf77f8a4d99f9e015e8fbf9989605d"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.7+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "ea8031dea4aff6bd41f1df8f2fdfb25b33626381"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.4"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ad37c091f7d7daf900963171600d7c1c5c3ede32"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2023.2.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalSets]]
deps = ["Dates", "Random", "Statistics"]
git-tree-sha1 = "3d8866c029dd6b16e69e0d4a939c4dfcb98fac47"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.8"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "68772f49f54b479fa88ace904f6127f0a3bb2e46"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.12"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "4ced6667f9974fc5c5943fa5e2ef1ca43ea9e450"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.8.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "PrecompileTools", "Printf", "Reexport", "Requires", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "9bbb5130d3b4fa52846546bca4791ecbdfb52730"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.38"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "d65930fa2bc96b07d7691c652d701dcbe7d9cf0b"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "62edfee3211981241b57ff1cedf4d74d79519277"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.15"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "ChainRulesCore", "CloseOpenIntervals", "DocStringExtensions", "ForwardDiff", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "SpecialFunctions", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "0f5648fbae0d015e3abe5867bca2b362f67a5894"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.166"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "eb006abbd7041c28e0d16260e50a24f8f9104913"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2023.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.MakieCore]]
deps = ["Observables", "REPL"]
git-tree-sha1 = "9b11acd07f21c4d035bd4156e789532e8ee2cc70"
uuid = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
version = "0.6.9"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "6985021d02ab8c509c841bb8b2becd3145a7b490"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.3.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "2c3726ceb3388917602169bed973dbc97f1b51a8"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.13"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Observables]]
git-tree-sha1 = "7438a59546cf62428fc9d1bc94729146d37a7225"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.5"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "2ac17d29c523ce1cd38e27785a7d23024853a4bb"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.10"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "a4ca623df1ae99d09bc9868b008262d0c0ac1e4f"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "5ded86ccaf0647349231ed6c0822c10886d4a1ee"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.1"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "240d7170f5ffdb285f9427b92333c3463bf65bf6"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.1"

[[deps.Polynomials]]
deps = ["ChainRulesCore", "LinearAlgebra", "MakieCore", "MutableArithmetics", "RecipesBase"]
git-tree-sha1 = "3aa2bb4982e575acd7583f01531f241af077b163"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.13"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "00099623ffee15972c16111bcf84c58a0051257c"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.9.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "9a46862d248ea548e340e30e2894118749dc7f51"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.5"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "792d8fd4ad770b6d517a13ebb8dadfcac79405b8"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.6.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "3aac6d68c5e57449f5b9b865c9ba50ac2970c4cf"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.42"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "5165dfb9fd131cf0c6957a3a7605dede376e7b63"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e2cfc4012a19088254b3950b85c3c1d8882d864d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.1"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "f295e0a1da4ca425659c57441bcb59abb035a4bc"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.8.8"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Requires", "SparseArrays", "Static", "SuiteSparse"]
git-tree-sha1 = "03fec6800a986d191f64f5c0996b59ed526eda25"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.4.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "5ef59aea6f18c25168842bded46b16662141ab87"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.7.0"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "34cc045dd0aaa59b8bbe86c644679bc57f1d5bd0"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.8"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "1fbeaaca45801b4ba17c251dd8603ef24801dd84"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "b182207d4af54ac64cbc71797765068fdeff475d"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.64"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "5f24e158cf4cee437052371455fe361f526da062"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.6"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═d60f02ce-0a83-4edb-9747-b3de9ba1ae2b
# ╠═5dfaa4bb-f544-43df-a390-a9e326784fed
# ╠═7ea81498-700d-4402-bea4-37b5203d088f
# ╠═84e7fba6-6aca-45bc-82a2-d14183d0b7d7
# ╟─5b0505f0-ab35-4ebc-9458-1914a54c7bfa
# ╟─405b4832-dcb4-4b1a-b599-15bd8018fffc
# ╟─56c69abe-5f9d-433d-87ee-ad4d14d7e4ac
# ╟─c49caeea-0bdd-4cd3-8e50-c739befecd98
# ╟─2ca058c6-5f4b-47d1-9282-a8803eaf19c5
# ╟─d16af9e4-e9fd-49df-97e4-b6af7193d63f
# ╟─06fd443f-8a9f-441b-871e-fd4e9b4dbbe0
# ╟─dfa1ac7d-ea19-4a80-a36d-79a08c7282fd
# ╟─b49c0c9a-2eed-48cb-9ec0-bb5e87a4efd5
# ╟─dff39318-6faf-4857-b907-ebe274299b3b
# ╟─35985d16-24ad-4100-b456-39966af75864
# ╟─a9d0362c-16fe-4dd3-9b7e-0653cb9891bf
# ╟─030c49e2-ebc2-4afd-94d4-e4b5c8a877da
# ╟─ef57ed90-5304-45f6-807a-40db639c2390
# ╟─cb5024ee-d321-41de-8420-db52408885ff
# ╟─f995a3b4-dd6d-4cad-9114-3ecf09c8e5a9
# ╟─156efa34-b3bd-4040-8d14-4e963036fa6c
# ╟─2e987088-01c4-4d48-a30c-6bc8ed6011f0
# ╟─47b3ea56-1f74-4ec6-a45a-54836399316a
# ╟─0d8c1aa7-4475-43c8-8728-3fb91fda739e
# ╟─da5a5d62-edf2-4c8b-b811-df0c7825a1c3
# ╟─4b4ffa50-5025-4891-a3e2-2379a8b3e5a6
# ╟─8ebd8bbb-18c5-4e3b-bf1a-53f71c09cf43
# ╟─b5ceb95b-ed81-4bc2-888c-f858203d42f0
# ╟─baa2e0ee-9bf3-4ffe-81cc-a8f5ee347920
# ╟─0955f10a-9a63-4828-bda5-823a31738eea
# ╟─a0fccfab-051a-4761-93f4-8bedf42ac8a2
# ╟─322b50f7-1859-4be7-8830-e9f9b1b47e06
# ╟─99ae39f7-ab7c-4516-9c76-1992eab8c356
# ╟─3ab02696-69a6-404c-be24-4172a7ea79ab
# ╟─6955c027-e484-4045-a815-57e9c1838ee1
# ╟─c504a3f7-424c-49f0-a4cd-69184f180ecd
# ╟─9dd937aa-b74d-4e79-84ad-5a2adec915da
# ╟─fd4dc5d8-286b-4639-9d74-4dabbd5ed934
# ╟─2454fd39-3818-415d-af34-c0e71beb6d45
# ╟─4dc47be6-085f-400a-ba2a-5512e6339648
# ╟─a218b467-fda3-4bc1-afbe-e69debcd31e8
# ╟─ac0fb07b-16fc-4e0c-b021-8b8793366b17
# ╟─13fc4a3c-ce35-41ea-80af-fc61880d4dd7
# ╟─9947d0ef-2418-4eef-b1da-4d9f5e60a7de
# ╟─d1a0811a-f346-49fc-981f-752cb3eac765
# ╟─695da251-f21d-441b-aa4d-994cd8c7f4ba
# ╟─a379ca39-a884-4582-96e4-96a38578c980
# ╟─22463488-0369-47bd-97af-a8f88a13169a
# ╟─8e6353df-1432-43bc-a009-c9b586437e7d
# ╟─26804d69-2746-493a-a183-abc36aa993f7
# ╟─f8377b73-aa03-44bb-ba91-2569332e0196
# ╟─81976bc3-1f65-44a9-bd0c-def16e9b29d8
# ╟─c4f730d7-2a6a-446e-a9d5-baec7242d9ca
# ╟─360c1413-2b3c-4605-a40b-921e7e8654a2
# ╟─9dc2b8d0-015d-4f7e-ba32-13cf76a65180
# ╟─5d2ec52e-dadd-4f45-a7ab-f788c62d4060
# ╟─1056f9d9-d6f1-47d3-ad00-36a49d11e704
# ╟─824b020b-4622-487f-8847-455bc707e5cb
# ╟─d6b9f8c9-9ace-4b60-ac11-c2693ef2df69
# ╟─13794945-2955-4282-8e0d-4b9bcb4925fa
# ╟─a309e9a5-9224-41fc-a11a-57a3b2b79efd
# ╟─f787570d-d967-4785-a681-9c423f1d31bd
# ╟─c287b09d-f21b-4a9d-a0a1-669e6ec8d0ad
# ╟─615ba357-8109-46b5-935a-313f0d8a91ae
# ╟─560b28f7-fdb8-43c5-b655-1575dfcc6498
# ╟─384581a2-a5ad-4a01-9a97-d107fc747a85
# ╟─0dd15cef-e3b5-4c7a-b691-b8fa0d423a2f
# ╟─e1434a56-9ce3-4c0d-aa91-a1d166fbdf6a
# ╟─52a28df6-7b6c-439e-ae2e-dd923c902c54
# ╟─d5bf41ed-edeb-402a-a535-e6be95ae2609
# ╟─b53c0154-512e-4cfa-ad91-334ecad0c384
# ╟─f8076bd4-7f16-47cc-9d2b-a0373be7c0b5
# ╟─45a11b7b-a339-4b60-a083-22be2b1f2abf
# ╟─6ac94edd-35ac-4163-b442-f065f9ef5f0e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
