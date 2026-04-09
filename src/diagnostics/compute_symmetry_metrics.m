function sym = compute_symmetry_metrics(field)
%COMPUTE_SYMMETRY_METRICS Reflection-based symmetry measures.
leftRight = norm(field - fliplr(field), 'fro') / max(norm(field,'fro'), eps);
topBottom = norm(field - flipud(field), 'fro') / max(norm(field,'fro'), eps);
diagMain  = norm(field - field.', 'fro') / max(norm(field,'fro'), eps);
diagAnti  = norm(field - rot90(field.', 2), 'fro') / max(norm(field,'fro'), eps);

sym = struct();
sym.leftRight = leftRight;
sym.topBottom = topBottom;
sym.diagMain  = diagMain;
sym.diagAnti  = diagAnti;
sym.meanPenalty = mean([leftRight, topBottom, diagMain, diagAnti]);
end
