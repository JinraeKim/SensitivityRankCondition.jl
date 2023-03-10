# SERC
Julia implementation of
"Sensitivity Matrices as Keys to Local Structural System Properties of Large-scale Nonlinear Systems" [^1].

The original MATLAB implementation [1] can be found in
https://kr.mathworks.com/matlabcentral/fileexchange/106000-identifiability-controllability-observability-detection/?s_tid=mlc_lp_leaf.

SERC stands for "sensitivity rank condition".


## Documentation
- Local strong accessibility (LSA): `sensitivity_matrix_lsa`
- Split SVD values: `split_svdvals`


## References
[^1]: L. G. Van Willigenburg, J. D. Stigter, and J. Molenaar, “Sensitivity Matrices as Keys to Local Structural System Properties of Large-scale Nonlinear Systems,” Nonlinear Dyn, vol. 107, no. 3, pp. 2599–2618, Feb. 2022, doi: 10.1007/s11071-021-07125-4.
