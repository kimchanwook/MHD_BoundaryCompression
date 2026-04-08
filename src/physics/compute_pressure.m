function p = compute_pressure(state, physics)
%COMPUTE_PRESSURE Compute thermal pressure from conservative state.
    primitive = conservative_to_primitive(state, physics);
    p = primitive.p;
end
