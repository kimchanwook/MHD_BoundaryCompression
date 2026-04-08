function physics = default_physics_params(physicsIn)
%DEFAULT_PHYSICS_PARAMS Fill any omitted physics parameters with defaults.
    physics = physicsIn;
    if ~isfield(physics, 'gamma'); physics.gamma = 5/3; end
    if ~isfield(physics, 'mu0');   physics.mu0 = 1.0; end
end
