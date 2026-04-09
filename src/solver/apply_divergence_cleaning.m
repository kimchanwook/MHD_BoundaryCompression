function U = apply_divergence_cleaning(U, grid, numerics, physics)
switch lower(numerics.divergenceControl)
    case 'none'
        return;
    case 'diffusive'
        U = apply_diffusive_cleaning(U, grid, numerics);
    case 'glm'
        U = apply_glm_damping(U, grid, numerics, physics);
    otherwise
        error('Unknown divergenceControl option: %s', numerics.divergenceControl);
end
end

function U = apply_diffusive_cleaning(U, grid, numerics)
Bx = U(:,:,5);
By = U(:,:,6);
kappa = numerics.divergenceCleaningStrength;

divB = local_divB(Bx, By, grid.dx, grid.dy);
Bx(2:end-1,2:end-1) = Bx(2:end-1,2:end-1) - kappa * ddx_center(divB, grid.dx);
By(2:end-1,2:end-1) = By(2:end-1,2:end-1) - kappa * ddy_center(divB, grid.dy);
U(:,:,5) = Bx;
U(:,:,6) = By;
end

function U = apply_glm_damping(U, grid, numerics, physics)
if size(U,3) < 9
    return;
end
ch = compute_glm_ch(U, grid, physics, numerics);
cp = numerics.glmDampingFactor * ch;
cp(cp < numerics.smallNumber) = numerics.smallNumber;

% Exponential damping over one local pseudo-time step based on mesh crossing.
% This keeps the implementation simple while preserving the modular GLM state.
dtPseudo = min(grid.dx, grid.dy) ./ ch;
damp = exp(-(ch.^2 ./ (cp.^2 + numerics.smallNumber)) .* dtPseudo);
U(:,:,9) = U(:,:,9) .* damp;
end

function divB = local_divB(Bx, By, dx, dy)
dBxdx = (Bx(:,3:end) - Bx(:,1:end-2)) / (2*dx);
dBydy = (By(3:end,:) - By(1:end-2,:)) / (2*dy);
divB = dBxdx(2:end-1,:) + dBydy(:,2:end-1);
end

function G = ddx_center(F, dx)
G = (F(:,3:end) - F(:,1:end-2)) / (2*dx);
end

function G = ddy_center(F, dy)
G = (F(3:end,:) - F(1:end-2,:)) / (2*dy);
end
