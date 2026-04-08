function export_run_tables(history, cfg)
%EXPORT_RUN_TABLES Write basic time-history data to CSV.
    T = table(history.t, history.step, history.dt, history.meanRho, history.meanB, ...
              history.uniformityRho, history.uniformityB, history.coreSpeed, ...
              'VariableNames', {'t','step','dt','meanRho','meanB','uniformityRho','uniformityB','coreSpeed'});
    writetable(T, fullfile(cfg.output.dataDir, 'time_history.csv'));
end
