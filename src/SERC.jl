module SERC


using ForwardDiff
using OrdinaryDiffEq
using ComponentArrays
using LinearAlgebra


include("local_strong_accessibility.jl")
include("split_svdvals.jl")


export sensitivity_matrix_lsa
export split_svdvals


end
