function numerics = default_numerics_params(numericsIn)
%DEFAULT_NUMERICS_PARAMS Fill omitted numerical parameters with defaults.
    numerics = numericsIn;
    if ~isfield(numerics,'t0'); numerics.t0 = 0.0; end
    if ~isfield(numerics,'tEnd'); numerics.tEnd = 1.0; end
    if ~isfield(numerics,'cfl'); numerics.cfl = 0.4; end
    if ~isfield(numerics,'maxSteps'); numerics.maxSteps = 1000; end
    if ~isfield(numerics,'rhoFloor'); numerics.rhoFloor = 1e-8; end
    if ~isfield(numerics,'pFloor'); numerics.pFloor = 1e-8; end
    if ~isfield(numerics,'timeIntegrator'); numerics.timeIntegrator = 'rk2'; end
    if ~isfield(numerics,'reconstruction'); numerics.reconstruction = 'plm'; end
    if ~isfield(numerics,'riemannSolver'); numerics.riemannSolver = 'hll'; end
end
