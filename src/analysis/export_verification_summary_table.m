function tablePath = export_verification_summary_table(convergence, outDir)
%EXPORT_VERIFICATION_SUMMARY_TABLE Write convergence and drift metrics to CSV.
if ~exist(outDir, 'dir')
    mkdir(outDir);
end
base = convergence.baseRunName;
tablePath = fullfile(outDir, [base '_verification_summary.csv']);
writetable(convergence.resultsTable, tablePath);

if ~isempty(convergence.estimatedOrders)
    orderPath = fullfile(outDir, [base '_verification_orders.csv']);
    writetable(convergence.estimatedOrders, orderPath);
end
end
