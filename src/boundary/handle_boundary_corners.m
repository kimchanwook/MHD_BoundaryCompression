function U = handle_boundary_corners(U, grid)
ng = grid.ng; U(1:ng, 1:ng, :) = U(ng+1, ng+1, :); U(1:ng, end-ng+1:end, :) = U(ng+1, end-ng, :); U(end-ng+1:end, 1:ng, :) = U(end-ng, ng+1, :); U(end-ng+1:end, end-ng+1:end, :) = U(end-ng, end-ng, :);
end
