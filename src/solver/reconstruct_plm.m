function [UL, UR] = reconstruct_plm(U, dir, physics, numerics)
%RECONSTRUCT_PLM Piecewise-linear MUSCL/PLM reconstruction on primitive variables.
%
% Primitive variables reconstructed here are
% q = [rho, vx, vy, vz, Bx, By, Bz, p, psi].

prim = conservative_to_primitive(U, physics, numerics);
Q = cat(3, prim.rho, prim.vx, prim.vy, prim.vz, prim.Bx, prim.By, prim.Bz, prim.p, prim.psi);

if strcmpi(numerics.reconstruction, 'first_order')
    if strcmpi(dir,'x')
        QL = Q(:,1:end-1,:);
        QR = Q(:,2:end,:);
    else
        QL = Q(1:end-1,:,:);
        QR = Q(2:end,:,:);
    end
else
    QL = reconstruct_left_states(Q, dir, numerics);
    QR = reconstruct_right_states(Q, dir, numerics);
end

UL = primitive_stack_to_conservative(QL, physics, numerics);
UR = primitive_stack_to_conservative(QR, physics, numerics);
end

function QL = reconstruct_left_states(Q, dir, numerics)
if strcmpi(dir,'x')
    slope = compute_limited_slope(Q, 2, numerics);
    QL = Q(:,1:end-1,:) + 0.5 * slope(:,1:end-1,:);
else
    slope = compute_limited_slope(Q, 1, numerics);
    QL = Q(1:end-1,:,:) + 0.5 * slope(1:end-1,:,:);
end
end

function QR = reconstruct_right_states(Q, dir, numerics)
if strcmpi(dir,'x')
    slope = compute_limited_slope(Q, 2, numerics);
    QR = Q(:,2:end,:) - 0.5 * slope(:,2:end,:);
else
    slope = compute_limited_slope(Q, 1, numerics);
    QR = Q(2:end,:,:) - 0.5 * slope(2:end,:,:);
end
end

function slope = compute_limited_slope(Q, dim, numerics)
slope = zeros(size(Q));
switch lower(numerics.limiter)
    case 'minmod'
        limiterFun = @minmod_pair;
    otherwise
        limiterFun = @mc_limiter;
end

if dim == 2
    dqL = Q(:,2:end-1,:) - Q(:,1:end-2,:);
    dqR = Q(:,3:end,:)   - Q(:,2:end-1,:);
    slope(:,2:end-1,:) = limiterFun(dqL, dqR);
else
    dqL = Q(2:end-1,:,:) - Q(1:end-2,:,:);
    dqR = Q(3:end,:,:)   - Q(2:end-1,:,:);
    slope(2:end-1,:,:) = limiterFun(dqL, dqR);
end
end

function s = minmod_pair(a, b)
sameSign = (a .* b) > 0;
s = zeros(size(a));
s(sameSign) = sign(a(sameSign)) .* min(abs(a(sameSign)), abs(b(sameSign)));
end

function s = mc_limiter(a, b)
s = minmod_pair(0.5 * (a + b), minmod_pair(2.0 * a, 2.0 * b));
end

function U = primitive_stack_to_conservative(Q, physics, numerics)
rho = max(Q(:,:,1), numerics.densityFloor);
vx  = Q(:,:,2);
vy  = Q(:,:,3);
vz  = Q(:,:,4);
Bx  = Q(:,:,5);
By  = Q(:,:,6);
Bz  = Q(:,:,7);
p   = max(Q(:,:,8), numerics.pressureFloor);
psi = Q(:,:,9);
E   = compute_total_energy(rho, vx, vy, vz, p, Bx, By, Bz, physics);
U   = primitive_to_conservative(rho, vx, vy, vz, Bx, By, Bz, E, psi);
end
