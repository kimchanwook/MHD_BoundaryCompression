function bcData = drive_prescribed_inward_velocity(driveModel, boundarySegment, t, ~, ~)
%DRIVE_PRESCRIBED_INWARD_VELOCITY Evaluate the baseline inward-velocity drive.
    params = driveModel.parameters;
    bcData.active = ismember(boundarySegment.name, params.boundaries);
    bcData.mode = 'prescribed_normal_velocity';
    bcData.vn = zeros(size(boundarySegment.s));
    bcData.vt = zeros(size(boundarySegment.s));
    bcData.p = [];
    bcData.Bn = [];
    bcData.Bt = [];

    if ~bcData.active
        return;
    end

    tLocal = apply_side_time_offset(params, boundarySegment.name, t);
    ft = evaluate_temporal_profile(params.temporal_profile, params.temporal_parameters, tLocal);
    fs = evaluate_spatial_profile(params.spatial_profile, params.spatial_parameters, boundarySegment.s);

    bcData.vn = params.amplitude .* ft .* fs;

    switch params.tangential_rule
        case 'zero'
            bcData.vt = zeros(size(boundarySegment.s));
        otherwise
            error('Unsupported tangential rule: %s', params.tangential_rule);
    end
end

function tLocal = apply_side_time_offset(params, sideName, t)
    tLocal = t;
    if isfield(params, 'side_time_offsets') && isfield(params.side_time_offsets, sideName)
        tLocal = t - params.side_time_offsets.(sideName);
    end
end
