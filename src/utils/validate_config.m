function validate_config(caseConfig)
assert(isfield(caseConfig,'grid'),'Missing grid configuration.'); assert(isfield(caseConfig,'physics'),'Missing physics configuration.'); assert(isfield(caseConfig,'drive'),'Missing drive configuration.'); assert(isfield(caseConfig.drive,'type'),'Missing drive type.');
end
