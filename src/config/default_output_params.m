function output = default_output_params(outputIn, caseName)
%DEFAULT_OUTPUT_PARAMS Fill omitted output parameters with defaults.
    output = outputIn;
    if ~isfield(output,'outputRoot'); output.outputRoot = 'outputs'; end
    if ~isfield(output,'runName'); output.runName = caseName; end
    if ~isfield(output,'saveEvery'); output.saveEvery = 10; end
    if ~isfield(output,'makePlots'); output.makePlots = true; end

    output.runDir = fullfile(output.outputRoot, output.runName);
    output.figureDir = fullfile(output.runDir, 'figures');
    output.dataDir = fullfile(output.runDir, 'data');
    output.logDir = fullfile(output.runDir, 'logs');
end
