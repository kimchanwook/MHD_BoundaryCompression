function suite = postprocess_sweep_results(results, outDir, baseName)
%POSTPROCESS_SWEEP_RESULTS Rank runs, export tables, and make comparison plots.
if ~exist(outDir, 'dir')
    mkdir(outDir);
end

ranking = rank_parameter_sweep(results);
exportPaths = export_run_tables(results, outDir, baseName);
comparisonFig = plot_sweep_summary(results, baseName, outDir);
barFig = plot_ranked_objective_bar(ranking, baseName, outDir);

suite = struct();
suite.results = results;
suite.ranking = ranking;
suite.bestRunName = ranking(1).runName;
suite.exportPaths = exportPaths;
suite.figurePaths = struct('comparison', comparisonFig, 'rankingBar', barFig);
end
