function figPath = save_figure_if_requested(runName, suffix, outDir)
figPath = '';
if nargin < 3 || isempty(outDir)
    return;
end
if ~exist(outDir, 'dir')
    mkdir(outDir);
end
figPath = fullfile(outDir, sprintf('%s_%s.png', runName, suffix));
saveas(gcf, figPath);
end
