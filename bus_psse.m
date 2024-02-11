mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_raw";

% Open output file
fid = fopen(output_file, 'w');

% % Write the header lines for PSS/E RAW file
% fprintf(fid, '0 / BEGIN BUS DATA\n');

% Loop through each bus in MATPOWER case
for i = 1:size(mpc.bus, 1)
    bus = mpc.bus(i, :);
    busNum = bus(1);
    busType = bus(2);
    Pd = bus(3); % Not directly used in PSSE RAW format but may be relevant for load data
    Qd = bus(4); % Same as above
    Gs = bus(5); % Not directly used, represents shunt conductance
    Bs = bus(6); % Not directly used, represents shunt susceptance
    area = bus(7); % Not typically specified in MATPOWER, default to 1 if missing
    Vm = bus(8);
    Va = bus(9); % Convert radians to degrees for PSSE
    baseKV = bus(10);
    
    % Assuming mpc.bus_name exists and has names for each bus
    busName = '';
    if isfield(mpc, 'bus_name') && length(mpc.bus_name) >= i
        busName = mpc.bus_name{i};
    end
    
    % For missing fields, use defaults or leave blank
    zone = bus(11); % Default or extract if available
    owner = 1; % Default or extract if available
    nvhi = bus(12); % Default high voltage limit
    nvlo = bus(13); % Default low voltage limit
    evhi = 1.1; % Default emergency high voltage limit
    evlo = 0.9; % Default emergency low voltage limit
    
    % Write bus data to file, with commas
    fprintf(fid, '%d, ''%s'', %.2f, %d, %d, %d, %d, %.4f, %.4f, %.2f, %.2f, %.2f, %.2f\n', ...
            busNum, busName, baseKV, busType, area, zone, owner, ...
            Vm, Va, nvhi, nvlo, evhi, evlo);
end

% % End of bus data
% fprintf(fid, '0 / END BUS DATA\n');

% Close the file
fclose(fid);

