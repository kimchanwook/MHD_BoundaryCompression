function vA = compute_alfven_speed(rho, Bmag, mu0)
%COMPUTE_ALFVEN_SPEED Compute Alfvén speed magnitude.
    vA = Bmag ./ sqrt(mu0 .* rho);
end
