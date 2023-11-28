include("HK_kruskal.jl")
include("algo_RSL.jl")

### Exemple d'utilisation sur l'instance gr17
gr17 = graph_from_instance("instances/stsp/gr17.tsp");
mst, tt, v, deg = HK_kruskal(gr17.nodes[1], gr17, 1, 100000) ## utilisation de la fonction HK_kruskal
#mst, tt = kruskal(gr17) ## ou utilisation de kruskal

vector_edge = transform_edge(mst)  ## transformation de l'arbre en vecteur d'arêtes
edges_mst_sorted = sort(vector_edge, by=x -> x[3]) ## tri du vecteur d'arêtes par poids croissant
println("mst", edges_mst_sorted)   ## affichage de l'arbre trié

vector_edge_all = transform_edge(gr17.edges) ## transformation de toutes les arêtes en vecteur d'arêtes
vector_edge_all = sort(vector_edge_all, by=x -> x[3]) ## tri du vecteur d'arêtes par poids croissant

x, y = [], [] ## initialisation des vecteurs pour le graphique
for i in eachindex(gr17.nodes)
    toumin, weight_root = rsl(deepcopy(edges_mst_sorted), vector_edge_all, i, gr17) ## utilisation de la fonction rsl en variant la racine
    push!(x, i)
    push!(y, weight_root)
    println(i, "  weight_root ", weight_root)
end

using Plots

p = bar(x, y) ## création du graphique
ylabel!("Weights")
xlabel!("Root")
title!("Weight of the tournee minimale for HK")
hline!([2080.0], label="optimal")
savefig(p, "barplot_gr17_hk.png") ## sauvegarde du graphique



