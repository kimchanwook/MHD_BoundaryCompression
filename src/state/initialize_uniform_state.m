function state = initialize_uniform_state(gridData, physics, initial)
%INITIALIZE_UNIFORM_STATE Create a uniform initial ideal-MHD state.
    rho = initial.rho0 * ones(gridData.Ny, gridData.Nx);
    vx  = initial.vx0  * ones(gridData.Ny, gridData.Nx);
    vy  = initial.vy0  * ones(gridData.Ny, gridData.Nx);
    Bx  = initial.Bx0  * ones(gridData.Ny, gridData.Nx);
    By  = initial.By0  * ones(gridData.Ny, gridData.Nx);
    Bz  = initial.Bz0  * ones(gridData.Ny, gridData.Nx);
    p   = initial.p0   * ones(gridData.Ny, gridData.Nx);

    state = primitive_to_conservative(rho, vx, vy, Bx, By, Bz, p, physics);
    state.primitive.rho = rho;
    state.primitive.vx = vx;
    state.primitive.vy = vy;
    state.primitive.Bx = Bx;
    state.primitive.By = By;
    state.primitive.Bz = Bz;
    state.primitive.p  = p;
end
