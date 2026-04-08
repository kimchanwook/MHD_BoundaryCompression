function divB = compute_divB_metrics(state, gridData)
%COMPUTE_DIVB_METRICS Compute a simple discrete divergence monitor.
    Bx = state.primitive.Bx;
    By = state.primitive.By;
    [dBx_dx, ~] = gradient(Bx, gridData.dx, gridData.dy);
    [~, dBy_dy] = gradient(By, gridData.dx, gridData.dy);
    div = dBx_dx + dBy_dy;
    divB.maxAbs = max(abs(div), [], 'all');
    divB.rms = sqrt(mean(div.^2, 'all'));
end
