function f = profile_cosine_taper(s)
if isempty(s), f = s; return; end
smin = min(s(:)); smax = max(s(:)); if abs(smax-smin) < eps, xi = zeros(size(s)); else, xi = (s - smin) ./ (smax - smin); end
f = sin(pi*xi).^2;
end
