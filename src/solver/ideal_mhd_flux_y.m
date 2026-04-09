function F = ideal_mhd_flux_y(U, physics, numerics)
P = conservative_to_primitive(U, physics, numerics);
B2 = P.Bx.^2 + P.By.^2 + P.Bz.^2;
ptot = P.p + 0.5/physics.mu0 * B2;
vdotB = P.vx.*P.Bx + P.vy.*P.By + P.vz.*P.Bz;

F = zeros(size(U));
F(:,:,1) = P.rho .* P.vy;
F(:,:,2) = P.rho .* P.vx .* P.vy - P.By .* P.Bx / physics.mu0;
F(:,:,3) = P.rho .* P.vy.^2 + ptot - P.By.^2 / physics.mu0;
F(:,:,4) = P.rho .* P.vy .* P.vz - P.By .* P.Bz / physics.mu0;
F(:,:,5) = P.vy .* P.Bx - P.vx .* P.By;
F(:,:,6) = P.psi;
F(:,:,7) = P.vy .* P.Bz - P.vz .* P.By;
F(:,:,8) = (P.E + ptot).*P.vy - (vdotB .* P.By) / physics.mu0;
F(:,:,9) = zeros(size(P.rho));
end
