function integrals = compute_global_integrals(state, gridData, physics)
%COMPUTE_GLOBAL_INTEGRALS Compute simple domain-integrated quantities.
    primitive = conservative_to_primitive(state, physics);
    dA = gridData.dx * gridData.dy;
    integrals.mass = sum(primitive.rho, 'all') * dA;
    integrals.energy = sum(state.U.E, 'all') * dA;
    integrals.meanB = mean(sqrt(primitive.Bx.^2 + primitive.By.^2 + primitive.Bz.^2), 'all');
end
