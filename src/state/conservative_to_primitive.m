function prim = conservative_to_primitive(U, physics, numerics)
rho = max(U(:,:,1), numerics.densityFloor);
mx = U(:,:,2); my = U(:,:,3); mz = U(:,:,4);
Bx = U(:,:,5); By = U(:,:,6); Bz = U(:,:,7);
E  = U(:,:,8);
if size(U,3) >= 9
    psi = U(:,:,9);
else
    psi = zeros(size(rho));
end

vx = mx ./ rho; vy = my ./ rho; vz = mz ./ rho;
kin = 0.5 * rho .* (vx.^2 + vy.^2 + vz.^2);
mag = 0.5 / physics.mu0 * (Bx.^2 + By.^2 + Bz.^2);
p = (physics.gamma - 1) .* (E - kin - mag);
p = max(p, numerics.pressureFloor);
prim = struct('rho',rho,'vx',vx,'vy',vy,'vz',vz, ...
    'Bx',Bx,'By',By,'Bz',Bz,'p',p,'E',E,'psi',psi);
end
