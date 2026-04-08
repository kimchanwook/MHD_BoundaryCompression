function cs = compute_sound_speed(rho, p, gamma)
%COMPUTE_SOUND_SPEED Compute ideal-gas sound speed.
    cs = sqrt(gamma .* p ./ rho);
end
