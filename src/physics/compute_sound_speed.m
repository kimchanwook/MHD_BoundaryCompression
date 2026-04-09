function cs = compute_sound_speed(rho, p, physics)
cs = sqrt(physics.gamma * p ./ rho);
end
