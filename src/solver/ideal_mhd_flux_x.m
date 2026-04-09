function F = ideal_mhd_flux_x(U, physics, numerics)
P = conservative_to_primitive(U, physics, numerics);
B2 = P.Bx.^2 + P.By.^2 + P.Bz.^2;
ptot = P.p + 0.5/physics.mu0 * B2;
vdotB = P.vx.*P.Bx + P.vy.*P.By + P.vz.*P.Bz;

F = zeros(size(U));
F(:,:,1) = P.rho .* P.vx;
F(:,:,2) = P.rho .* P.vx.^2 + ptot - P.Bx.^2 / physics.mu0;
F(:,:,3) = P.rho .* P.vx .* P.vy - P.Bx .* P.By / physics.mu0;
F(:,:,4) = P.rho .* P.vx .* P.vz - P.Bx .* P.Bz / physics.mu0;
F(:,:,5) = P.psi;
F(:,:,6) = P.vx .* P.By - P.vy .* P.Bx;
F(:,:,7) = P.vx .* P.Bz - P.vz .* P.Bx;
F(:,:,8) = (P.E + ptot).*P.vx - (vdotB .* P.Bx) / physics.mu0;
F(:,:,9) = zeros(size(P.rho));
end
