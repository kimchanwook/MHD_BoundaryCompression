function E = compute_total_energy(rho, vx, vy, vz, p, Bx, By, Bz, physics)
kin = 0.5 * rho .* (vx.^2 + vy.^2 + vz.^2); mag = 0.5 / physics.mu0 * (Bx.^2 + By.^2 + Bz.^2); int = p ./ (physics.gamma - 1); E = int + kin + mag;
end
