using Test

include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")
include("../phase1/main.jl")
include("../phase2/kruskal.jl")
include("../phase2/prim.jl")



# Créez des nœuds, des arêtes et un graphe pour les tests

# Exemple d'utilisation
node1 = Node("A", 1)
node2 = Node("B", 2)
node3 = Node("C", 3)
node4 = Node("D", 4)
node5 = Node("E", 4)
node6 = Node("F", 4)
node7 = Node("G", 4)
node8 = Node("H", 4)
node9 = Node("I", 4)

edge1 = Edge("AB", node1, node2, 4)
edge2 = Edge("BC", node2, node3, 8)
edge3 = Edge("CD", node3, node4, 7)
edge4 = Edge("DE", node4, node5, 9)
edge5 = Edge("EF", node5, node6, 10)
edge6 = Edge("FC", node6, node3, 4)
edge7 = Edge("FG", node6, node7, 2)
edge8 = Edge("GI", node9, node7, 6)
edge9 = Edge("HG", node8, node7, 1)
edge10 = Edge("HI", node8, node9, 7)
edge11 = Edge("HA", node8, node1, 8)
edge12 = Edge("HB", node8, node2, 11)
edge13 = Edge("DF", node6, node4, 14)
edge14 = Edge("IC", node9, node3, 2)

nodes_g = [node1, node2, node3, node4, node5, node6, node7, node8, node9]
edges_g = [edge1, edge2, edge3, edge4, edge5, edge6, edge7, edge8, edge9, edge10, edge11, edge12, edge13, edge14]

graph_g = Graph("Test Graph", nodes_g, edges_g)

# Définissez des tests unitaires pour les structures
@testset "Node, Edge, and Graph Tests" begin
    @test node1.name == "A"
    @test node1.data == 1
    @test typeof(node1.data) == Int64
    
    @test edge1.name == "AB"
    @test edge1.node1 == node1
    @test edge1.node2 == node2
    @test edge1.weight == 4
    @test typeof(edge1.weight) == Int64
    
    @test graph_g.name == "Test Graph"
    @test graph_g.nodes == nodes_g
    @test graph_g.edges == edges_g
    @test typeof(graph_g.name) == String

    mst_prim, total_weight_prim = prim(graph_g)
    mst_kruuskal, total_weight_kruskal = kruskal(graph_g)
    @test total_weight_prim == total_weight_kruskal
    @test total_weight_prim == 37 # Le total_weight de la solution de l'exemple du cours
end

# Exécutez les tests en utilisant `test` ou `@test`
# test()  # Si vous avez plusieurs tests à exécuter
