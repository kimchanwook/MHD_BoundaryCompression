function dt = compute_dt_cfl(state, physics, numerics, gridData)
%COMPUTE_DT_CFL Compute a simple CFL time step from the fast speed.
    primitive = conservative_to_primitive(state, physics);
    cf = compute_fast_speed(primitive.rho, primitive.p, primitive.Bx, primitive.By, ...
                            primitive.Bz, physics.gamma, physics.mu0);
    speed = sqrt(primitive.vx.^2 + primitive.vy.^2) + cf;
    maxSpeed = max(speed, [], 'all');
    dt = numerics.cfl * min(gridData.dx, gridData.dy) / max(maxSpeed, 1e-12);
end
