function test_core_region_definition()
%TEST_CORE_REGION_DEFINITION Core region should sit in the center and honor requested fraction.
grid = build_grid(default_grid_params());
d = default_diagnostics_params();
d.coreFraction = 0.50;
core = get_core_region_indices(grid, d);

assert(core.i(1) > grid.ix(1), 'Core region starts at boundary unexpectedly.');
assert(core.i(end) < grid.ix(end), 'Core region ends at boundary unexpectedly.');
assert(core.j(1) > grid.iy(1), 'Core region starts at boundary unexpectedly.');
assert(core.j(end) < grid.iy(end), 'Core region ends at boundary unexpectedly.');
assert(abs(numel(core.i) - round(0.50*numel(grid.ix))) <= 1, 'Unexpected core x-size.');
assert(abs(numel(core.j) - round(0.50*numel(grid.iy))) <= 1, 'Unexpected core y-size.');
end
