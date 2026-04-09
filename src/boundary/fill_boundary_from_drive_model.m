function U = fill_boundary_from_drive_model(U, grid, physics, numerics, driveModel, t, side)
prim = conservative_to_primitive(U, physics, numerics); ng = grid.ng;
switch lower(side)
    case 'left'
        j = grid.boundary.left.j; iiGhost = grid.boundary.left.ghost_i; iiInt = grid.boundary.left.interior_i; interior = slice_prim_columns(prim, iiInt(end), j); s = grid.y(j); bcData = evaluate_drive(driveModel, 'left', s, t, interior); ghost = impose_velocity_boundary(interior, bcData, 'left');
        for g = 1:ng, U(j, iiGhost(g), :) = pack_prim_slice(ghost, g, physics); end
    case 'right'
        j = grid.boundary.right.j; iiGhost = grid.boundary.right.ghost_i; iiInt = grid.boundary.right.interior_i; interior = slice_prim_columns(prim, iiInt(1), j); s = grid.y(j); bcData = evaluate_drive(driveModel, 'right', s, t, interior); ghost = impose_velocity_boundary(interior, bcData, 'right');
        for g = 1:ng, U(j, iiGhost(g), :) = pack_prim_slice(ghost, g, physics); end
    case 'bottom'
        i = grid.boundary.bottom.i; jjGhost = grid.boundary.bottom.ghost_j; jjInt = grid.boundary.bottom.interior_j; interior = slice_prim_rows(prim, i, jjInt(end)); s = grid.x(i); bcData = evaluate_drive(driveModel, 'bottom', s, t, interior); ghost = impose_velocity_boundary(interior, bcData, 'bottom');
        for g = 1:ng, U(jjGhost(g), i, :) = pack_prim_slice(ghost, g, physics); end
    case 'top'
        i = grid.boundary.top.i; jjGhost = grid.boundary.top.ghost_j; jjInt = grid.boundary.top.interior_j; interior = slice_prim_rows(prim, i, jjInt(1)); s = grid.x(i); bcData = evaluate_drive(driveModel, 'top', s, t, interior); ghost = impose_velocity_boundary(interior, bcData, 'top');
        for g = 1:ng, U(jjGhost(g), i, :) = pack_prim_slice(ghost, g, physics); end
    otherwise
        error('Unknown boundary side: %s', side);
end
end
function S = slice_prim_columns(prim, iCol, j), S = structfun(@(A) A(j, iCol), prim, 'UniformOutput', false); end
function S = slice_prim_rows(prim, i, jRow), S = structfun(@(A) A(jRow, i), prim, 'UniformOutput', false); end
function Urow = pack_prim_slice(ghost, idx, physics)
rho = ghost.rho(idx); vx = ghost.vx(idx); vy = ghost.vy(idx); vz = ghost.vz(idx); Bx = ghost.Bx(idx); By = ghost.By(idx); Bz = ghost.Bz(idx); p = ghost.p(idx); psi = ghost.psi(idx);
E = compute_total_energy(rho, vx, vy, vz, p, Bx, By, Bz, physics); Urow = reshape([rho, rho*vx, rho*vy, rho*vz, Bx, By, Bz, E, psi], 1,1,9);
end
