using Test
using SERC


"""
[example2, 1]


[1] L. G. Van Willigenburg, J. D. Stigter, and J. Molenaar, “Sensitivity Matrices as Keys to Local Structural System Properties of Large-scale Nonlinear Systems,” Nonlinear Dyn, vol. 107, no. 3, pp. 2599–2618, Feb. 2022, doi: 10.1007/s11071-021-07125-4.
"""
function example2()
    f(x, u) = [cos(x[3]+x[4]), sin(x[3]+x[4]), sin(x[4]), 0] * u[1] + [0, 0, 0, 1] * u[2]
    tN = 1.0
    reported_svdvals = [
                        [3.4230, 3.0000, 0.1001, 0.01782],
                        [3.4909, 3.0000, 2.6986e-16, 4.8033e-33],
                       ]
    for (i, u) in enumerate([t -> [sin(2*pi*t/tN), cos(2*pi*t/tN)], t -> zeros(2)])
        xN = [1.0129, 0.9605, 0.8504, 0.5950]
        U_xN = sensitivity_matrix_lsa(xN, u, f; tN=tN)
        @show svdvals(U_xN)
        @test isapprox(svdvals(U_xN), reported_svdvals[i]; rtol=1e-1)
    end
end


@testset "local_strong_accessibility" begin
    example2()
end
