function metrics = compute_divB_metrics(U, grid)
Bx = U(:,:,5); By = U(:,:,6); dBxdx = (Bx(:,3:end) - Bx(:,1:end-2)) / (2*grid.dx); dBydy = (By(3:end,:) - By(1:end-2,:)) / (2*grid.dy); common = dBxdx(2:end-1,:) + dBydy(:,2:end-1); metrics.maxAbsDivB = max(abs(common(:))); metrics.rmsDivB = sqrt(mean(common(:).^2));
end
