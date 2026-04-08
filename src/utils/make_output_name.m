function name = make_output_name(baseName, suffix)
%MAKE_OUTPUT_NAME Construct a standardized output file stem.
    name = sprintf('%s_%s', baseName, suffix);
end
