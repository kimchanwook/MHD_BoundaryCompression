function figPaths = plot_state_2d(grid, U, physics, runName, outDir)
prim = conservative_to_primitive(U, physics);
rho = prim(:,:,1);
Bmag = sqrt(prim(:,:,6).^2 + prim(:,:,7).^2 + prim(:,:,8).^2);

figPaths = struct();
figure('Name',[runName ' rho']);
imagesc(grid.xc, grid.yc, rho(grid.ng+1:end-grid.ng, grid.ng+1:end-grid.ng)');
axis xy equal tight; colorbar; xlabel('x'); ylabel('y'); title([runName ' density']);
figPaths.rho = save_figure_if_requested(runName, 'rho2d', outDir);

figure('Name',[runName ' Bmag']);
imagesc(grid.xc, grid.yc, Bmag(grid.ng+1:end-grid.ng, grid.ng+1:end-grid.ng)');
axis xy equal tight; colorbar; xlabel('x'); ylabel('y'); title([runName ' |B|']);
figPaths.Bmag = save_figure_if_requested(runName, 'Bmag2d', outDir);
end
