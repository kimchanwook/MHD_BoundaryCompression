function metrics = compute_uniformity_metrics(field)
metrics.meanValue = mean(field(:)); metrics.stdValue = std(field(:)); metrics.coeffVariation = metrics.stdValue / max(metrics.meanValue, eps);
end
