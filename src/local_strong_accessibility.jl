"""
xN: initial guess for terminal state
u: control input, t -> u(t)
f: right-hand side of dynamic equation
tN: terminal time
t0: initial time

# Notes
\\dot{x} = f(x, u)

# Reference
[1] L. G. Van Willigenburg, J. D. Stigter, and J. Molenaar, “Sensitivity Matrices as Keys to Local Structural System Properties of Large-scale Nonlinear Systems,” Nonlinear Dyn, vol. 107, no. 3, pp. 2599–2618, Feb. 2022, doi: 10.1007/s11071-021-07125-4.
"""
function sensitivity_matrix_lsa(
        xN, u, f;
        tN=1.0, t0=0.0, N=2*length(xN),
    )
    ∂f_∂x(x, u) = ForwardDiff.jacobian(x -> f(x, u), x)
    ∂f_∂u(x, u) = ForwardDiff.jacobian(u -> f(x, u), u)
    function dynamics(X, :, t)
        (; x, x_xN) = X
        x_xN_dot = -∂f_∂x(x, u(t))' * x_xN
        x_dot = f(x, u(t))
        X_dot = ComponentArray(x=x_dot, x_xN=x_xN_dot)
        return X_dot
    end
    tspan = (tN, t0)
    X_tf = ComponentArray(x=xN, x_xN=I(length(xN)))
    prob = ODEProblem(dynamics, X_tf, tspan)
    sol = solve(prob, Tsit5())
    U_xN = vcat([∂f_∂u(sol(t).x, u(t))' * sol(t).x_xN for t in LinRange(tN, t0, N+1)]...)
    return U_xN
end
