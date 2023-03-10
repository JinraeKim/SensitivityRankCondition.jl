"""
ispl: index after which split occurs; length(sv) if no split.
mspl: minimum value diff(log(sv))

# Notes
Borrowed from the original MATLAB implementation [1, 2].

# Reference
[1] L. G. Van Willigenburg, J. D. Stigter, and J. Molenaar, “Sensitivity Matrices as Keys to Local Structural System Properties of Large-scale Nonlinear Systems,” Nonlinear Dyn, vol. 107, no. 3, pp. 2599–2618, Feb. 2022, doi: 10.1007/s11071-021-07125-4.
[2] https://kr.mathworks.com/matlabcentral/fileexchange/106000-identifiability-controllability-observability-detection/?s_tid=mlc_lp_leaf
"""
function split_svdvals(sv, maxsv=sqrt(eps()); minfac=333)
    epsilon = eps()
    if sv[1] < 10*epsilon
        # all singular values are zero
        ispl, mspl = 0, 0
    elseif length(sv) == 1
        # single singular value
        if sv[1] < 10*epsilon
            ispl, mspl = 0, 0
        else
            ispl, mspl = 1, sv[1]
        end
    else
        # sort gaps singular values
        dspl = diff(log10.(max.(sv, 1e-4*epsilon)))
        id = sortperm(dspl)
        ddsp = dspl[id]
        # search starting at largest gap for minimal factor (minfac)
        # between split and singular value < maximum value for split
        lsv, ld = length(sv), length(ddsp)
        ispl, mspl = lsv, 0
        k = 1
        while k <= ld
            if ddsp[k] < -log10(minfac) && sv[id[k]+1] < maxsv
                ispl, mspl = id[k], ddsp[k]
                k = ld + 1
            else
                k = k + 1
            end
        end
    end

    return ispl, mspl
end
