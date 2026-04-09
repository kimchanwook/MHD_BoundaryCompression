function core = get_core_region_indices(grid, diagnostics)
%GET_CORE_REGION_INDICES Return central active-cell indices used for metrics.
ix = grid.ix;
iy = grid.iy;

if nargin < 2 || ~isfield(diagnostics, 'coreFraction') || isempty(diagnostics.coreFraction)
    coreFraction = 0.50;
else
    coreFraction = diagnostics.coreFraction;
end

coreFraction = max(min(coreFraction, 1.0), 0.05);

nx = numel(ix);
ny = numel(iy);
mx = max(1, round(coreFraction * nx));
my = max(1, round(coreFraction * ny));

ixStart = floor((nx - mx)/2) + 1;
iyStart = floor((ny - my)/2) + 1;

core.i = ix(ixStart : ixStart + mx - 1);
core.j = iy(iyStart : iyStart + my - 1);
core.coreFraction = coreFraction;
end
