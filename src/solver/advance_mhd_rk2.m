function result = advance_mhd_rk2(U, grid, physics, numerics, timeParams, driveModel, output, diagnostics)
t = 0.0;
step = 0;
history = initialize_history();

if nargin < 8 || isempty(diagnostics)
    diagnostics = default_diagnostics_params();
end

while t < timeParams.tEnd && step < timeParams.maxSteps
    U = apply_ghost_cells(U, grid, physics, numerics, driveModel, t);

    dt = compute_dt_cfl(U, grid, physics, numerics, timeParams.cfl);
    dt = min(dt, timeParams.tEnd - t);

    k1 = compute_rhs_mhd(U, grid, physics, numerics, driveModel, t);
    U1 = apply_state_floors(U + dt * k1, physics, numerics);
    U1 = apply_divergence_cleaning(U1, grid, numerics, physics);
    U1 = apply_ghost_cells(U1, grid, physics, numerics, driveModel, t + dt);

    k2 = compute_rhs_mhd(U1, grid, physics, numerics, driveModel, t + dt);
    U = apply_state_floors(0.5 * (U + U1 + dt * k2), physics, numerics);
    U = apply_divergence_cleaning(U, grid, numerics, physics);
    U = apply_ghost_cells(U, grid, physics, numerics, driveModel, t + dt);

    t = t + dt;
    step = step + 1;
    history = append_history(history, U, grid, physics, numerics, diagnostics, t, step, dt);

    if output.verbose && (mod(step,25)==0 || step==1)
        fprintf('Step %d  t = %.5f  dt = %.5e
', step, t, dt);
    end
end

result = struct('U',U,'t',t,'step',step,'history',history);
end

function history = initialize_history()
history = struct('t',[],'dt',[], ...
    'rhoCoreMean',[],'pCoreMean',[],'BmagCoreMean',[], ...
    'rhoCompressionRatio',[],'pCompressionRatio',[],'BCompressionRatio',[], ...
    'rhoUniformity',[],'pUniformity',[],'BmagUniformity',[], ...
    'symmetryPenalty',[],'symmetryRho',[],'symmetryB',[],'symmetryP',[], ...
    'symmetryLeftRight',[],'symmetryTopBottom',[],'symmetryDiagMain',[],'symmetryDiagAnti',[], ...
    'vCoreMean',[],'vCoreMax',[],'stagnationPenalty',[], ...
    'divBMax',[],'divBRms',[],'psiMax',[],'psiRms',[], ...
    'massTotal',[],'momentumXTotal',[],'momentumYTotal',[],'momentumZTotal',[], ...
    'kineticEnergyTotal',[],'internalEnergyTotal',[],'magneticEnergyTotal',[],'totalEnergyTotal',[], ...
    'compressionReward',[],'uniformityPenalty',[], ...
    'symmetryWeightedPenalty',[],'stagnationWeightedPenalty',[], ...
    'divBWeightedPenalty',[],'objective',[]);
end

function history = append_history(history, U, grid, physics, numerics, diagnostics, t, step, dt)
metrics = compute_all_diagnostics(U, grid, physics, numerics, diagnostics);
metrics = assemble_objective_function(metrics, diagnostics);
psi = zeros(size(U,1), size(U,2));
if size(U,3) >= 9
    psi = U(:,:,9);
end

history.t(step,1) = t;
history.dt(step,1) = dt;
history.rhoCoreMean(step,1) = metrics.rhoCoreMean;
history.pCoreMean(step,1) = metrics.pCoreMean;
history.BmagCoreMean(step,1) = metrics.BmagCoreMean;
history.rhoCompressionRatio(step,1) = metrics.rhoCompressionRatio;
history.pCompressionRatio(step,1) = metrics.pCompressionRatio;
history.BCompressionRatio(step,1) = metrics.BCompressionRatio;
history.rhoUniformity(step,1) = metrics.rhoUniformity;
history.pUniformity(step,1) = metrics.pUniformity;
history.BmagUniformity(step,1) = metrics.BmagUniformity;
history.symmetryPenalty(step,1) = metrics.symmetryPenalty;
history.symmetryRho(step,1) = metrics.symmetryRho;
history.symmetryB(step,1) = metrics.symmetryB;
history.symmetryP(step,1) = metrics.symmetryP;
history.symmetryLeftRight(step,1) = metrics.symmetryLeftRight;
history.symmetryTopBottom(step,1) = metrics.symmetryTopBottom;
history.symmetryDiagMain(step,1) = metrics.symmetryDiagMain;
history.symmetryDiagAnti(step,1) = metrics.symmetryDiagAnti;
history.vCoreMean(step,1) = metrics.vCoreMean;
history.vCoreMax(step,1) = metrics.vCoreMax;
history.stagnationPenalty(step,1) = metrics.stagnationPenalty;
history.divBMax(step,1) = metrics.divBMax;
history.divBRms(step,1) = metrics.divBRms;
history.psiMax(step,1) = max(abs(psi(:)));
history.psiRms(step,1) = sqrt(mean(psi(:).^2));
history.massTotal(step,1) = metrics.massTotal;
history.momentumXTotal(step,1) = metrics.momentumXTotal;
history.momentumYTotal(step,1) = metrics.momentumYTotal;
history.momentumZTotal(step,1) = metrics.momentumZTotal;
history.kineticEnergyTotal(step,1) = metrics.kineticEnergyTotal;
history.internalEnergyTotal(step,1) = metrics.internalEnergyTotal;
history.magneticEnergyTotal(step,1) = metrics.magneticEnergyTotal;
history.totalEnergyTotal(step,1) = metrics.totalEnergyTotal;
history.compressionReward(step,1) = metrics.compressionReward;
history.uniformityPenalty(step,1) = metrics.uniformityPenalty;
history.symmetryWeightedPenalty(step,1) = metrics.symmetryWeightedPenalty;
history.stagnationWeightedPenalty(step,1) = metrics.stagnationWeightedPenalty;
history.divBWeightedPenalty(step,1) = metrics.divBWeightedPenalty;
history.objective(step,1) = metrics.objective;
end
