function numerics = default_numerics_params()
numerics = struct();
numerics.timeIntegrator = 'rk2';
numerics.reconstruction = 'plm';
numerics.limiter        = 'mc';
numerics.riemannSolver  = 'hll';
numerics.densityFloor   = 1.0e-8;
numerics.pressureFloor  = 1.0e-8;
numerics.smallNumber    = 1.0e-12;

% Divergence control options
% 'none'      : no special handling
% 'diffusive' : legacy diffusive cleaning B <- B - kappa grad(div B)
% 'glm'       : hyperbolic-parabolic Dedner-style cleaning with scalar psi
numerics.divergenceControl = 'glm';
numerics.divergenceCleaningStrength = 0.02;

% GLM cleaning parameters.
% c_h is chosen adaptively from the current fast-wave speed, and these
% factors scale the hyperbolic transport speed and the damping rate.
numerics.glmChFactor = 1.0;
numerics.glmDampingFactor = 1.0;
end
