function metrics = compute_uniformity_metrics(fieldValues)
%COMPUTE_UNIFORMITY_METRICS Return mean, std, and coefficient of variation.
    metrics.meanValue = mean(fieldValues(:));
    metrics.stdValue = std(fieldValues(:));
    metrics.coeffVar = metrics.stdValue / max(metrics.meanValue, eps);
end
