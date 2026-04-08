function [history, snapshots] = advance_mhd_rk2(state, gridData, boundaryInfo, cfg, driveModel)
%ADVANCE_MHD_RK2 Advance the baseline problem with a placeholder update loop.
% The current version intentionally separates time marching, drive evaluation,
% diagnostics, and plotting hooks before the conservative MHD flux update is
% filled in. This keeps project structure stable while the solver core is
% developed next.

    t = cfg.numerics.t0;
    step = 0;
    history = initialize_history();
    snapshots.final = state;

    while t < cfg.numerics.tEnd && step < cfg.numerics.maxSteps
        step = step + 1;
        dt = compute_dt_cfl(state, cfg.physics, cfg.numerics, gridData);
        if t + dt > cfg.numerics.tEnd
            dt = cfg.numerics.tEnd - t;
        end

        state = apply_boundary_conditions(state, gridData, boundaryInfo, driveModel, t, cfg);
        state = compute_rhs_mhd(state, gridData, cfg, dt);
        state = apply_state_floors(state, cfg.physics, cfg.numerics);

        t = t + dt;
        metrics = compute_compression_metrics(state, gridData, cfg.physics, t);
        history = append_history(history, t, step, dt, metrics);

        if mod(step, cfg.output.saveEvery) == 0 || t >= cfg.numerics.tEnd
            snapshots.final = state;
        end
    end
end

function history = initialize_history()
    history.t = [];
    history.step = [];
    history.dt = [];
    history.meanRho = [];
    history.meanB = [];
    history.uniformityRho = [];
    history.uniformityB = [];
    history.coreSpeed = [];
end

function history = append_history(history, t, step, dt, metrics)
    history.t(end+1,1) = t;
    history.step(end+1,1) = step;
    history.dt(end+1,1) = dt;
    history.meanRho(end+1,1) = metrics.meanRho;
    history.meanB(end+1,1) = metrics.meanB;
    history.uniformityRho(end+1,1) = metrics.uniformityRho;
    history.uniformityB(end+1,1) = metrics.uniformityB;
    history.coreSpeed(end+1,1) = metrics.coreSpeed;
end
