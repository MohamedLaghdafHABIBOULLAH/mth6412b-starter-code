include("shredder-julia/bin/tools.jl")
include("../phase4/HK_kruskal.jl")
include("../phase4/algo_RSL.jl")

function process_instance(filename::AbstractString, root::Int64)
    instance = graph_from_instance( "projet/phase5/shredder-julia/tsp/instances/$filename.tsp")

    mst, _ = kruskal(instance)
    vector_edge = transform_edge(mst)
    edges_mst_sorted = sort(vector_edge, by=x -> x[3])

    vector_edge_all = transform_edge(instance.edges)
    vector_edge_all = sort(vector_edge_all, by=x -> x[3])

    toumin, weight_root = rsl(deepcopy(edges_mst_sorted), vector_edge_all, root, instance)
    first_col = [Int(x[1]) for x in toumin]
    first_col = filter(x -> x != 1, first_col)
    first_col = vcat(1, first_col)

    weight_root = Float32(weight_root)
    write_tour("$filename-instance-av.tour", first_col, weight_root)
    reconstruct_picture("$filename-instance-av.tour", "projet/phase5/shredder-julia/images/shuffled/$filename.png", "$filename-avant.png")
    println("Fin de la première phase")

    New_root = first_col[end]
    toumin, weight_root = rsl(deepcopy(edges_mst_sorted), vector_edge_all, New_root, instance)
    first_col = [Int(x[1]) for x in toumin]
    first_col = filter(x -> x != 1, first_col)
    first_col = vcat(1, first_col)

    weight_root = Float32(weight_root)
    write_tour("$filename-instance-ap.tour", first_col, weight_root)
    reconstruct_picture("$filename-instance-ap.tour", "projet/phase5/shredder-julia/images/shuffled/$filename.png", "$filename-ap-rec.png")
    println("Fin de la deuxième phase")
end
