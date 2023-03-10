using SERC
using Test

@testset "SERC.jl" begin
    include("test/local_strong_accessibility.jl")
    include("test/split_svdvals.jl")
end
