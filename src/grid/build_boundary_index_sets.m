function boundaryInfo = build_boundary_index_sets(gridData)
%BUILD_BOUNDARY_INDEX_SETS Define side names, normals, and edge coordinates.
    x = gridData.x;
    y = gridData.y;

    boundaryInfo.left.name = 'left';
    boundaryInfo.left.normal = [1, 0];
    boundaryInfo.left.s = y(:);
    boundaryInfo.left.x = zeros(size(y(:)));
    boundaryInfo.left.y = y(:);

    boundaryInfo.right.name = 'right';
    boundaryInfo.right.normal = [-1, 0];
    boundaryInfo.right.s = y(:);
    boundaryInfo.right.x = gridData.Lx * ones(size(y(:)));
    boundaryInfo.right.y = y(:);

    boundaryInfo.bottom.name = 'bottom';
    boundaryInfo.bottom.normal = [0, 1];
    boundaryInfo.bottom.s = x(:);
    boundaryInfo.bottom.x = x(:);
    boundaryInfo.bottom.y = zeros(size(x(:)));

    boundaryInfo.top.name = 'top';
    boundaryInfo.top.normal = [0, -1];
    boundaryInfo.top.s = x(:);
    boundaryInfo.top.x = x(:);
    boundaryInfo.top.y = gridData.Ly * ones(size(x(:)));
end
