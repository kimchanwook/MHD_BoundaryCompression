function state = apply_state_floors(state, physics, numerics)
%APPLY_STATE_FLOORS Enforce simple density and pressure floors.
    primitive = conservative_to_primitive(state, physics);
    primitive.rho = max(primitive.rho, numerics.rhoFloor);
    primitive.p = max(primitive.p, numerics.pFloor);
    state = primitive_to_conservative(primitive.rho, primitive.vx, primitive.vy, ...
                                      primitive.Bx, primitive.By, primitive.Bz, ...
                                      primitive.p, physics);
    state.primitive = primitive;
end
