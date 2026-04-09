function ghost = impose_velocity_boundary(interior, bcData, side)
n = numel(interior.rho); copy = @(x) repmat(x(:), 1, 2);
ghost.rho = copy(interior.rho);
ghost.p = copy(interior.p);
ghost.Bx = copy(interior.Bx);
ghost.By = copy(interior.By);
ghost.Bz = copy(interior.Bz);
ghost.vz = copy(interior.vz);
ghost.psi = copy(interior.psi);

a = bcData.vn(:); if numel(a)==1, a = repmat(a,n,1); end
switch lower(side)
    case {'left','right'}
        ghost.vx = repmat(a,1,2);
        if strcmpi(bcData.tangential_rule,'copy_from_interior')
            ghost.vy = copy(interior.vy);
        else
            ghost.vy = zeros(n,2);
        end
    case {'bottom','top'}
        ghost.vy = repmat(a,1,2);
        if strcmpi(bcData.tangential_rule,'copy_from_interior')
            ghost.vx = copy(interior.vx);
        else
            ghost.vx = zeros(n,2);
        end
    otherwise
        error('Unknown side: %s', side);
end
end
