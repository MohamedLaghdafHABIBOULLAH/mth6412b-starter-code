
## fonction qui transforme l'arbre en vecteur d'arêtes
function transform_edge(mst)
    vector_edge_sorted = []
    for edge in mst
        valeurs = split.(edge.name, "-")
        push!(vector_edge_sorted, [parse(Int, valeurs[1]), parse(Int, valeurs[2]), edge.weight])
    end
    return vector_edge_sorted
end

#Fonction qui trouve le edge (présent dans mst) relié a un certain noeud avec le cout le plus faible
function find_edge_in_mst(edges_mst_sorted, tournee_minimale)
    linkfound = 0
    a = 1
    go = 1
    for edge in edges_mst_sorted
        if edge[1] == tournee_minimale[end][2]
            for edge_tourne in tournee_minimale[1:end-1]
                if edge_tourne[2] == edge[2]
                    go = 0
                end
            end
            if go == 1
                push!(tournee_minimale, [edge[1], edge[2], edge[3]])
            end
            deleteat!(edges_mst_sorted, a)
            linkfound = 1
            break
        end
        if edge[2] == tournee_minimale[end][2]
            for edge_tourne in tournee_minimale[1:end-1]
                if edge_tourne[2] == edge[1]
                    go = 0
                end
            end
            if go == 1
                push!(tournee_minimale, [edge[2], edge[1], edge[3]])
            end
            deleteat!(edges_mst_sorted, a)
            linkfound = 1
            break
        end
        a = a + 1
    end
    return edges_mst_sorted, tournee_minimale, linkfound
end


#fonction qui remonte dans la tournée pour trouver un noeud qui a un deuxieme lien pour continuer la tournée
function remonte_in_edge(tournee_minimale, edges_mst_sorted, edges_all)
    linkfound = 0
    poid = 0
    a = 1
    delete = 0
    while linkfound == 0
        if a < size(tournee_minimale, 1)
            for edge in edges_mst_sorted
                if edge[1] == tournee_minimale[end-a][2]
                    #trouve le poid du edge reliant deux node quelconques parmi tous les edges
                    for edg in edges_all
                        if edg[1] == edge[1] && edg[2] == edge[2]
                            poid = edg[3]
                        end
                    end
                    push!(tournee_minimale, [tournee_minimale[end][2], edge[2], poid])
                    linkfound = 1
                    delete = edge[1]
                    break
                end
                if edge[2] == tournee_minimale[end-a][2]
                    for edg in edges_all
                        if edg[1] == edge[1] && edg[2] == edge[2]
                            poid = edg[3]
                        end
                    end
                    push!(tournee_minimale, [tournee_minimale[end][2], edge[1], poid])
                    linkfound = 1
                    delete = edge[2]
                    break
                end
            end
            a = a + 1
        else
            for edge in edges_mst_sorted
                if edge[1] == tournee_minimale[1][1]
                    for edg in edges_all
                        if edg[1] == edge[1] && edg[2] == edge[2]
                            poid = edg[3]
                        end
                    end
                    push!(tournee_minimale, [tournee_minimale[end][2], edge[2], poid])
                    linkfound = 1
                    delete = edge[1]
                    break
                end
                if edge[2] == tournee_minimale[1][1]
                    for edg in edges_all
                        if edg[1] == edge[1] && edg[2] == edge[2]
                            poid = edg[3]
                        end
                    end
                    push!(tournee_minimale, [tournee_minimale[end][2], edge[1], poid])
                    linkfound = 1
                    delete = edge[2]
                    break
                end
            end
        end
    end
    return tournee_minimale, [delete, tournee_minimale[end][2]]
end

#fonction RSL
function rsl(edges_mst_sorted, edges_all, root, graph_inst)
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
    #la racine est le premier element de l'edge avec le plus petit weight
    # push!(tournee_minimale, [edges_mst_sorted[1][1], edges_mst_sorted[1][2], edges_mst_sorted[1][3]]) 
    #quand on ajoute un edge à la tournée minimale, on le supprime du minimum_spanning_tree
    # deleteat!(edges_mst_sorted, 1)
    #on construit la tournée jusqu'à ce que le mst soit vide
    while !isempty(edges_mst_sorted)
        #indicateur de si on a reussi a trouvé un edge a rajouté dans la tournée 
        linkfound = 0
        # println("mst: ", edges_mst_sorted)
        edges_mst_sorted, tournee_minimale, linkfound = find_edge_in_mst(edges_mst_sorted, tournee_minimale)
        # println("linkfound: ", linkfound)
        if linkfound == 0
            tournee_minimale, couple_delete = remonte_in_edge(tournee_minimale, edges_mst_sorted, edges_all)
            # println("delete: ", couple_delete)
            k = 1
            for edge in edges_mst_sorted
                if couple_delete[1] == edge[1] && couple_delete[2] == edge[2] || couple_delete[1] == edge[2] && couple_delete[2] == edge[1]
                    deleteat!(edges_mst_sorted, k)
                end
                k = k + 1
            end
        end
        # println("tournee: ", tournee_minimale)
        # println(" ")
    end


    poid = 0
    # ici je rajoute le poid de la liaison entre le dernier noeud de la tournée et le premier noeud
    for edg in edges_all
        if edg[1] == tournee_minimale[1][1] && edg[2] == tournee_minimale[end][2]
            push!(tournee_minimale, [edg[2], edg[1], edg[3]])
        end
        if edg[2] == tournee_minimale[1][1] && edg[1] == tournee_minimale[end][2]
            push!(tournee_minimale, [edg[1], edg[2], edg[3]])
        end
    end

    #ici je rajoute le poid de tous les edges de la tournée
    total_weight = 0
    for edge in graph_inst.edges
        for i in eachindex(tournee_minimale)
            if (edge.node1.name == string(Int(tournee_minimale[i][1])) && edge.node2.name == string(Int(tournee_minimale[i][2]))) || (edge.node1.name == string(Int(tournee_minimale[i][2])) && edge.node2.name == string(Int(tournee_minimale[i][1])))
                tournee_minimale[i][3] = edge.weight
                total_weight += edge.weight
            end
        end
    end
    return tournee_minimale, total_weight
end
