using Test
using SensitivityRankCondition
using PyCall


function main()
    np = pyimport("numpy")
    f(x, u) = [cos(x[3]+x[4]), sin(x[3]+x[4]), sin(x[4]), 0] * u[1] + [0, 0, 0, 1] * u[2]
    tN = 1.0
    u = t -> np.array([np.sin(2*np.pi*t/tN), np.cos(2*np.pi*t/tN)])
    xN = np.array([1.0129, 0.9605, 0.8504, 0.5950])
    U_xN = sensitivity_matrix_lsa(xN, u, f; tN=tN)
    U_xN_julia = [0.125068    0.992148     0.560509   0.0;
                  0.0         0.0          0.0        1.0;
                  0.234464    0.972894     0.46396    0.0;
                  0.0448217  -0.00868248  -0.0404988  1.0;
                  0.276584    0.963298     0.422177   0.0;
                  0.144379   -0.0313147   -0.141808   1.0;
                  0.240221    0.968531     0.463962   0.0;
                  0.233846   -0.0462999   -0.243119   1.0;
                  0.156664    0.968211     0.560508   0.0;
                  0.268602   -0.0473597   -0.283618   1.0;
                  0.0711225   0.955643     0.649966   0.0;
                  0.232716   -0.0532919   -0.247166   1.0;
                  0.0327892   0.948681     0.684672   0.0;
                  0.138235   -0.0696183   -0.164038   1.0;
                  0.0767315   0.95109      0.649964   0.0;
                  0.0338938  -0.0780056   -0.080908   1.0;
                  0.18743     0.943266     0.56051    0.0;
                  -0.01178    -0.0759961   -0.0444647  1.0]  # obtained only with Julia
    @test isapprox(U_xN, U_xN_julia,
                   rtol=1e-6,
                   atol=1e-3,
                  )
end


@testset "python" begin
    main()
end
