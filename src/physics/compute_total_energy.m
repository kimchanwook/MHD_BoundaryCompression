function E = compute_total_energy(rho, vx, vy, Bx, By, Bz, p, gamma, mu0)
%COMPUTE_TOTAL_ENERGY Compute total energy density.
    internal = p ./ (gamma - 1);
    kinetic = 0.5 .* rho .* (vx.^2 + vy.^2);
    magnetic = 0.5 ./ mu0 .* (Bx.^2 + By.^2 + Bz.^2);
    E = internal + kinetic + magnetic;
end
