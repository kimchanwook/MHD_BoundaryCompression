function caseData = case_baseline_symmetric()
%CASE_BASELINE_SYMMETRIC First baseline case for MHD_BoundaryCompression.
%
% Physics:
%   - two-dimensional square domain
%   - initially uniform plasma and magnetic field
%   - zero initial velocity
%   - symmetric inward normal boundary velocity on all four sides
%   - smooth finite-duration drive pulse

    caseData.name = 'baseline_symmetric';
    caseData.description = ['Symmetric inward boundary compression on a ', ...
                            'fixed Eulerian grid with prescribed normal velocity.'];

    caseData.grid.Lx = 1.0;
    caseData.grid.Ly = 1.0;
    caseData.grid.Nx = 81;
    caseData.grid.Ny = 81;
    caseData.grid.ng = 2;

    caseData.physics.gamma = 5/3;
    caseData.physics.mu0 = 1.0;

    caseData.initial.rho0 = 1.0;
    caseData.initial.p0   = 1.0;
    caseData.initial.vx0  = 0.0;
    caseData.initial.vy0  = 0.0;
    caseData.initial.Bx0  = 1.0;
    caseData.initial.By0  = 0.0;
    caseData.initial.Bz0  = 0.0;

    caseData.drive.type = 'prescribed_velocity';
    caseData.drive.name = 'symmetric_inward_velocity';
    caseData.drive.boundaries = {'left','right','bottom','top'};
    caseData.drive.amplitude = 0.10;
    caseData.drive.temporal_profile = 'smooth_top_hat';
    caseData.drive.temporal_parameters.t_on = 0.0;
    caseData.drive.temporal_parameters.t_rise = 0.10;
    caseData.drive.temporal_parameters.t_hold = 0.30;
    caseData.drive.temporal_parameters.t_fall = 0.10;
    caseData.drive.spatial_profile = 'uniform';
    caseData.drive.spatial_parameters = struct();
    caseData.drive.tangential_rule = 'zero';

    caseData.numerics.t0 = 0.0;
    caseData.numerics.tEnd = 0.80;
    caseData.numerics.cfl = 0.40;
    caseData.numerics.maxSteps = 2000;
    caseData.numerics.rhoFloor = 1e-8;
    caseData.numerics.pFloor = 1e-8;
    caseData.numerics.timeIntegrator = 'rk2';
    caseData.numerics.reconstruction = 'plm';
    caseData.numerics.riemannSolver = 'hll';

    caseData.output.outputRoot = 'outputs';
    caseData.output.runName = caseData.name;
    caseData.output.saveEvery = 20;
    caseData.output.makePlots = true;
end
