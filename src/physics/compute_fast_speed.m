function cf = compute_fast_speed(rho, p, Bx, By, Bz, gamma, mu0)
%COMPUTE_FAST_SPEED Approximate fast magnetosonic speed magnitude.
    Bmag = sqrt(Bx.^2 + By.^2 + Bz.^2);
    cs = compute_sound_speed(rho, p, gamma);
    vA = compute_alfven_speed(rho, Bmag, mu0);
    cf = sqrt(cs.^2 + vA.^2);
end
