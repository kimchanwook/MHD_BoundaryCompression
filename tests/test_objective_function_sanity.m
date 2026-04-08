function test_objective_function_sanity()
%TEST_OBJECTIVE_FUNCTION_SANITY Better compression should increase the score.
    weights.rho = 1; weights.B = 1; weights.uniformityRho = 1; weights.uniformityB = 1; weights.coreSpeed = 1;
    a.meanRho = 2; a.meanB = 2; a.uniformityRho = 0.1; a.uniformityB = 0.1; a.coreSpeed = 0.1;
    b.meanRho = 1; b.meanB = 1; b.uniformityRho = 0.2; b.uniformityB = 0.2; b.coreSpeed = 0.2;
    assert(assemble_objective_function(a, weights) > assemble_objective_function(b, weights));
end
