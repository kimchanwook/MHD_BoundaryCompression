function fs = profile_user_defined(params, s)
%PROFILE_USER_DEFINED Use a caller-supplied function handle.
    if ~isfield(params, 'fun') || ~isa(params.fun, 'function_handle')
        error('profile_user_defined requires params.fun as a function handle.');
    end
    fs = params.fun(s);
end
