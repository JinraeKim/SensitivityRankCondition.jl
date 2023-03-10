using Test
using SensitivityRankCondition


function main()
    svs = [
           [3.4230, 3.0000, 0.1001, 0.01782],
           [3.4909, 3.0000, 2.6986e-16, 4.8033e-33],
          ]
    maxsv = 1e-8
    for sv in svs
        @show ispl, mspl = split_svdvals(sv, maxsv)
    end
end



@testset "split_svdvals" begin
    main()
end
