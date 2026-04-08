function primitive = conservative_to_primitive(state, physics)
%CONSERVATIVE_TO_PRIMITIVE Convert conservative variables to primitive form.
    rho = state.U.rho;
    vx = state.U.mx ./ rho;
    vy = state.U.my ./ rho;
    Bx = state.U.Bx;
    By = state.U.By;
    Bz = state.U.Bz;

    kinetic = 0.5 * rho .* (vx.^2 + vy.^2);
    magnetic = 0.5 / physics.mu0 * (Bx.^2 + By.^2 + Bz.^2);
    p = (physics.gamma - 1) .* (state.U.E - kinetic - magnetic);

    primitive.rho = rho;
    primitive.vx = vx;
    primitive.vy = vy;
    primitive.Bx = Bx;
    primitive.By = By;
    primitive.Bz = Bz;
    primitive.p  = p;
end
