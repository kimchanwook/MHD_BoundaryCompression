function plot_state_2d(state, gridData, fieldName, cfg)
%PLOT_STATE_2D Plot a requested 2D primitive field.
    if ~cfg.output.makePlots
        return;
    end
    primitive = state.primitive;
    switch fieldName
        case 'rho'
            field = primitive.rho;
            plotTitle = 'Density';
        case 'p'
            field = primitive.p;
            plotTitle = 'Pressure';
        otherwise
            error('Unsupported field for plot_state_2d: %s', fieldName);
    end

    fig = figure('Visible','off');
    imagesc(gridData.x, gridData.y, field);
    axis xy equal tight;
    colorbar;
    xlabel('x'); ylabel('y');
    title(sprintf('%s: %s', cfg.caseName, plotTitle));
    saveas(fig, fullfile(cfg.output.figureDir, ['state_' fieldName '.png']));
    close(fig);
end
