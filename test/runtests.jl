using SERC
using Test

@testset "SERC.jl" begin
    include("local_strong_accessibility.jl")
    include("split_svdvals.jl")
end
