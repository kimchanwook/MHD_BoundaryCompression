function symmetry = compute_symmetry_metrics(field)
%COMPUTE_SYMMETRY_METRICS Compare a field with its left-right and top-bottom reflections.
    symmetry.leftRight = norm(field - fliplr(field), 'fro') / max(norm(field, 'fro'), eps);
    symmetry.topBottom = norm(field - flipud(field), 'fro') / max(norm(field, 'fro'), eps);
end
