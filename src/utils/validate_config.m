function validate_config(cfg)
%VALIDATE_CONFIG Basic configuration consistency checks.
    assert(cfg.grid.Nx >= 3 && cfg.grid.Ny >= 3, 'Grid must have at least 3 points in each direction.');
    assert(cfg.grid.Lx > 0 && cfg.grid.Ly > 0, 'Domain lengths must be positive.');
    assert(cfg.initial.rho0 > 0, 'Initial density must be positive.');
    assert(cfg.initial.p0 > 0, 'Initial pressure must be positive.');
    assert(cfg.physics.gamma > 1, 'Gamma must exceed 1.');
end
