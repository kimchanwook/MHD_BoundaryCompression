function shock = compute_shock_indicators(U, physics, numerics)
P = conservative_to_primitive(U, physics, numerics); shock.maxPressure = max(P.p(:)); shock.maxDensity = max(P.rho(:));
end
