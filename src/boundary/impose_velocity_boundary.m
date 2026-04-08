function state = impose_velocity_boundary(state, sideName, vn, vt, physics)
%IMPOSE_VELOCITY_BOUNDARY Directly impose boundary primitive velocities.
% The current version writes boundary cell velocities only. A later version
% should replace this by proper ghost-cell construction before flux updates.
    primitive = state.primitive;
    switch sideName
        case 'left'
            primitive.vx(:,1) = vn(:);
            primitive.vy(:,1) = vt(:);
        case 'right'
            primitive.vx(:,end) = -vn(:);
            primitive.vy(:,end) = vt(:);
        case 'bottom'
            primitive.vx(1,:) = vt(:).';
            primitive.vy(1,:) = vn(:).';
        case 'top'
            primitive.vx(end,:) = vt(:).';
            primitive.vy(end,:) = -vn(:).';
        otherwise
            error('Unknown side name: %s', sideName);
    end
    state = primitive_to_conservative(primitive.rho, primitive.vx, primitive.vy, ...
                                      primitive.Bx, primitive.By, primitive.Bz, ...
                                      primitive.p, physics);
    state.primitive = primitive;
end
