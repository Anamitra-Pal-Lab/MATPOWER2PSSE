mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_trans_raw";


% Open output file
fid = fopen(output_file, 'w');

% Write the header lines for PSS/E RAW file two-winding transformer data
fprintf(fid, '0 / BEGIN TWO-WINDING TRANSFORMER DATA,\n');

% Identify two-winding transformers
transformer_indices = find(mpc.branch(:, 9) ~= 0);

% Default values based on PSSE documentation
cw = 1; % Winding data I/O code
cz = 1; % Impedance data I/O code
cm = 1; % Magnetizing admittance I/O code
mag1 = 0; % Magnetizing conductance, pu on system base
mag2 = 0; % Magnetizing susceptance, pu on system base
nmetr = 2; % Metered end code
name = 'T1'; % Default transformer name
vecgrp = 'YNd1'; % Default vector group
% Default ownership and factor
o1 = 1; f1 = 1.0; 
% Assuming all other ownerships are not used
o2 = 0; f2 = 1;
o3 = 0; f3 = 1;
o4 = 0; f4 = 1;

for idx = transformer_indices'
    branch = mpc.branch(idx, :);
    
    % Extract transformer data
    R = branch(3);
    X = branch(4);
    sbase = mpc.baseMVA;
    ibus = branch(1);
    jbus = branch(2);
    kbus = 0; % For two-winding transformers, kbus is 0
    ckt = '1'; % Circuit identifier
    stat = branch(11); % Branch status
    tap = branch(9);
    rate = branch(6);
    
    % Extract or calculate transformer impedance and admittance
    r = branch(3);
    x = branch(4);
    
    % Write two-winding transformer data to file, with commas and all fields
    fprintf(fid, '%d, %d, %d, ''%s'', %d, %d, %d, %.5f, %.5f, %.2f, %.2f, %d, ''%s'', %d, %d, %.2f, %d, %.2f, %d, %.2f, %d, %.2f, ''%s'', %.5f, %.5f, %.5f, %.5f, 0.0, 0.0, %.5f,%.5f,%.5f, 0,  \n', ...
            ibus, jbus, kbus, ckt, cw, cz, cm, mag1, mag2, nmetr, stat, name, o1, f1, o2, f2, o3, f3, o4, f4, vecgrp, R, X, sbase, tap, rate, rate, rate );
end

% End of two-winding transformer data
fprintf(fid, '0 / END TWO-WINDING TRANSFORMER DATA,\n');

% Close the file
fclose(fid);