function cf = compute_fast_speed(rho, p, Bx, By, Bz, normalDir, physics)
cs2 = physics.gamma * p ./ rho; B2 = Bx.^2 + By.^2 + Bz.^2; va2 = B2 ./ (physics.mu0 * rho);
if strcmpi(normalDir,'x'), van2 = Bx.^2 ./ (physics.mu0 * rho); else, van2 = By.^2 ./ (physics.mu0 * rho); end
term = (cs2 + va2).^2 - 4*cs2.*van2; term = max(term,0); cf = sqrt(0.5 * ((cs2 + va2) + sqrt(term)));
end
