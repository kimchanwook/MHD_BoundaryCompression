function p = compute_pressure(U, physics, numerics)
prim = conservative_to_primitive(U, physics, numerics); p = prim.p;
end
