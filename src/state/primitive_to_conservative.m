function U = primitive_to_conservative(rho, vx, vy, vz, Bx, By, Bz, E, psi)
if nargin < 9
    psi = zeros(size(rho));
end
U = cat(3, rho, rho.*vx, rho.*vy, rho.*vz, Bx, By, Bz, E, psi);
end
