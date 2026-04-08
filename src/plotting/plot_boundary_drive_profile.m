function plot_boundary_drive_profile(~, boundaryInfo, driveModel, cfg)
%PLOT_BOUNDARY_DRIVE_PROFILE Plot the imposed normal velocity profile at t = 0.
    if ~cfg.output.makePlots
        return;
    end
    sideName = driveModel.boundaries{1};
    bcData = evaluate_drive(driveModel, boundaryInfo.(sideName), 0.0, [], []);

    fig = figure('Visible','off');
    plot(boundaryInfo.(sideName).s, bcData.vn);
    xlabel('Boundary coordinate s');
    ylabel('Prescribed inward normal velocity');
    title(sprintf('%s: drive profile on %s boundary at t = 0', cfg.caseName, sideName));
    saveas(fig, fullfile(cfg.output.figureDir, 'drive_profile.png'));
    close(fig);
end
