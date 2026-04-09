function rates = compute_convergence_rates(resultsTable)
%COMPUTE_CONVERGENCE_RATES Estimate local observed order from successive grid refinements.
rates = table();
if height(resultsTable) < 3
    return;
end
N = resultsTable.N;
e1 = resultsTable.error_peakObjective;
e2 = resultsTable.error_peakRhoCompression;
e3 = resultsTable.error_minRhoUniformity;

nRows = height(resultsTable) - 2;
rates.Ncoarse = N(1:nRows);
rates.Nmid = N(2:nRows+1);
rates.Nfine = N(3:nRows+2);
rates.order_peakObjective = local_order(e1);
rates.order_peakRhoCompression = local_order(e2);
rates.order_minRhoUniformity = local_order(e3);
end

function p = local_order(err)
p = nan(numel(err)-2,1);
for i = 1:numel(p)
    if err(i+1) > 0 && err(i+2) > 0
        p(i) = log(err(i) / err(i+1)) / log(2);
    end
end
end
