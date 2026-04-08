function shock = compute_shock_indicators(state, gridData)
%COMPUTE_SHOCK_INDICATORS Basic gradient-based compression indicator.
    rho = state.primitive.rho;
    [drho_dx, drho_dy] = gradient(rho, gridData.dx, gridData.dy);
    shock.maxGradRho = max(sqrt(drho_dx.^2 + drho_dy.^2), [], 'all');
end
