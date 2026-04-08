function ensure_output_dirs(output)
%ENSURE_OUTPUT_DIRS Create output directories if they do not exist.
    dirs = {output.outputRoot, output.runDir, output.figureDir, output.dataDir, output.logDir};
    for i = 1:numel(dirs)
        if ~exist(dirs{i}, 'dir')
            mkdir(dirs{i});
        end
    end
end
