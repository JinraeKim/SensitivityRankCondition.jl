using Test
using SERC
using LinearAlgebra


"""
[Example2, 1]

# Notes
- The original MATLAB implementation [2] has a typo in the definition of dynamics.
`reported_svdvals` are the recalculated values by fixing the dynamics.
- The values in [Example2, 1] are different from the original code [2].

# Reference
[1] L. G. Van Willigenburg, J. D. Stigter, and J. Molenaar, “Sensitivity Matrices as Keys to Local Structural System Properties of Large-scale Nonlinear Systems,” Nonlinear Dyn, vol. 107, no. 3, pp. 2599–2618, Feb. 2022, doi: 10.1007/s11071-021-07125-4.
[2] https://kr.mathworks.com/matlabcentral/fileexchange/106000-identifiability-controllability-observability-detection/?s_tid=mlc_lp_leaf
"""
function example2()
    f(x, u) = [cos(x[3]+x[4]), sin(x[3]+x[4]), sin(x[4]), 0] * u[1] + [0, 0, 0, 1] * u[2]
    tN = 1.0
    reported_svdvals = [
                        [3.4256, 2.9972, 0.5010, 0.0489],
                        [3.4391, 3.0000, 2.6986e-16, 4.8033e-33],
                       ]
    for (i, u) in enumerate([t -> [sin(2*pi*t/tN), cos(2*pi*t/tN)], t -> zeros(2)])
        xN = [1.0129, 0.9605, 0.8504, 0.5950]
        U_xN = sensitivity_matrix_lsa(xN, u, f; tN=tN)
        @show svdvals(U_xN)
        @test isapprox(svdvals(U_xN), reported_svdvals[i], rtol=1e-2)
    end
end


@testset "local_strong_accessibility" begin
    example2()
end
