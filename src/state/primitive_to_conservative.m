function state = primitive_to_conservative(rho, vx, vy, Bx, By, Bz, p, physics)
%PRIMITIVE_TO_CONSERVATIVE Convert primitive variables to conservative form.
    kinetic = 0.5 * rho .* (vx.^2 + vy.^2);
    magnetic = 0.5 / physics.mu0 * (Bx.^2 + By.^2 + Bz.^2);
    internal = p / (physics.gamma - 1);
    E = internal + kinetic + magnetic;

    state.U.rho = rho;
    state.U.mx  = rho .* vx;
    state.U.my  = rho .* vy;
    state.U.Bx  = Bx;
    state.U.By  = By;
    state.U.Bz  = Bz;
    state.U.E   = E;
end
