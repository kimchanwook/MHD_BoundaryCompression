function F = hll_flux_y(U, physics, numerics)
[UL, UR] = reconstruct_plm(U, 'y', physics, numerics);
FL = ideal_mhd_flux_y(UL, physics, numerics);
FR = ideal_mhd_flux_y(UR, physics, numerics);

pL = conservative_to_primitive(UL, physics, numerics);
pR = conservative_to_primitive(UR, physics, numerics);

cfL = compute_fast_speed(pL.rho, pL.p, pL.Bx, pL.By, pL.Bz, 'y', physics);
cfR = compute_fast_speed(pR.rho, pR.p, pR.Bx, pR.By, pR.Bz, 'y', physics);
ch = compute_glm_ch(U, grid_dummy_from_size(U), physics, numerics);

SL = min(min(pL.vy - cfL, pR.vy - cfR), -ch);
SR = max(max(pL.vy + cfL, pR.vy + cfR), +ch);

denom = SR - SL;
denom(abs(denom) < numerics.smallNumber) = numerics.smallNumber;

F = zeros(size(UL));
maskL = SL >= 0;
maskR = SR <= 0;
maskM = ~(maskL | maskR);

for m = 1:size(UL,3)
    ULm = UL(:,:,m); URm = UR(:,:,m); FLm = FL(:,:,m); FRm = FR(:,:,m);
    Fm = zeros(size(ULm));
    Fm(maskL) = FLm(maskL);
    Fm(maskR) = FRm(maskR);
    Fm(maskM) = (SR(maskM).*FLm(maskM) - SL(maskM).*FRm(maskM) + SL(maskM).*SR(maskM).*(URm(maskM) - ULm(maskM))) ./ denom(maskM);
    F(:,:,m) = Fm;
end

% GLM subsystem contribution for the psi equation.
% The induction-side psi contribution is already present in ideal_mhd_flux_x/y.
F(:,:,9) = ch.^2 .* 0.5 .* (UL(:,:,6) + UR(:,:,6));
end

function grid = grid_dummy_from_size(U)
grid.dx = 1.0; grid.dy = 1.0; %#ok<STRNU>
end
