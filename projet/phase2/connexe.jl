include("node.jl")
efkwjnef







mutable struct BinaryTree{T} <: AbstractNode{T} name::String
     data::T
     left::Union{BinaryTree{T}, Nothing}
     right::Union{BinaryTree{T}, Nothing}
     parent::Union{BinaryTree{T}, Nothing}
end
function BinaryTree(data::T; name::String="",
left::Union{BinaryTree{T}, Nothing}=nothing, right::Union{BinaryTree{T}, Nothing}=nothing, parent::Union{BinaryTree{T}, Nothing}=nothing) where T
     BinaryTree(name, data, left, right, parent)
end
 left(bt::BinaryTree) = bt.left
 right(bt::BinaryTree) = bt.right
 parent(bt::BinaryTree) = bt.parent