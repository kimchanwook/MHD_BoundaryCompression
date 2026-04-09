function va = compute_alfven_speed(rho, Bn, physics)
va = abs(Bn) ./ sqrt(physics.mu0 * rho);
end
