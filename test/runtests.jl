using SensitivityRankCondition
using Test

@testset "SensitivityRankCondition.jl" begin
    include("local_strong_accessibility.jl")
    include("split_svdvals.jl")
end
