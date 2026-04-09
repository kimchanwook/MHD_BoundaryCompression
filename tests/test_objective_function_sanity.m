function test_objective_function_sanity()
metrics = struct('rhoCoreMean',1.0,'BmagCoreMean',1.0,'rhoUniformity',0.0,'BmagUniformity',0.0,'vCoreMean',0.0); metrics = assemble_objective_function(metrics); assert(abs(metrics.objective - 1.5) < 1e-12); disp('test_objective_function_sanity passed');
end
