function plot_time_history(history, cfg)
%PLOT_TIME_HISTORY Plot basic compression metrics versus time.
    if ~cfg.output.makePlots || isempty(history.t)
        return;
    end
    fig = figure('Visible','off');
    plot(history.t, history.meanRho, history.t, history.meanB);
    xlabel('t');
    ylabel('Core mean value');
    legend('mean \rho','mean |B|','Location','best');
    title(sprintf('%s: core compression history', cfg.caseName));
    saveas(fig, fullfile(cfg.output.figureDir, 'time_history.png'));
    close(fig);
end
