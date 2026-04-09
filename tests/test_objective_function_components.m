function test_objective_function_components()
%TEST_OBJECTIVE_FUNCTION_COMPONENTS Objective should increase with stronger compression reward.
d = default_diagnostics_params();

m1 = struct('rhoCompressionRatio',1.1,'BCompressionRatio',1.0,'pCompressionRatio',1.0, ...
    'rhoUniformity',0.1,'BmagUniformity',0.1,'pUniformity',0.1, ...
    'symmetryPenalty',0.1,'stagnationPenalty',0.1,'divBRms',0.0);
m2 = m1; m2.rhoCompressionRatio = 1.5;

m1 = assemble_objective_function(m1, d);
m2 = assemble_objective_function(m2, d);
assert(m2.objective > m1.objective, 'Objective did not improve with stronger compression reward.');
end
