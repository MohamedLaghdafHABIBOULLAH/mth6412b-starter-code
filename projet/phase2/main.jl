using BenchmarkTools

include("../phase2/kruskal.jl")
include("../phase2/prim.jl")


gr17 = graph_from_instance("instances/stsp/gr17.tsp");
mst, tt = kruskal(gr17)
println("Kruskal algorithm with instance ", gr17.name)
for edge in mst
     println("Edge: ", edge.name, ", Weight: ", edge.weight)
 end
 println("Total Weight: ", tt)
 @benchmark kruskal(gr17)

mst, tw = prim(gr17)
println("Prim algorithm with instance ", gr17.name)
for edge in mst
     println("Edge: ", edge.name, ", Weight: ", edge.weight)
 end
 println("Total Weight: ", tw)
 @benchmark prim(gr17)