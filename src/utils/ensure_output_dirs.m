function ensure_output_dirs(caseConfig)
baseDir = caseConfig.output.baseDir; if ~exist(baseDir,'dir'), mkdir(baseDir); end; subDirs = {'figures','data','logs'}; for k = 1:numel(subDirs), path = fullfile(baseDir, subDirs{k}); if ~exist(path,'dir'), mkdir(path); end; end
end
