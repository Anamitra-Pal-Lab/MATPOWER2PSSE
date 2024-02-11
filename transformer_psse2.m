mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_trans_raw";

% Open output file
fid = fopen(output_file, 'w');

% Write the header for two-winding transformer data
fprintf(fid, '0 / BEGIN TWO-WINDING TRANSFORMER DATA,\n');

% Identify transformers by non-zero tap setting in mpc.branch
transformer_indices = find(mpc.branch(:, 9) ~= 0);

for idx = transformer_indices'
    branch = mpc.branch(idx, :);
    % Transformer identification
    ibus = branch(1); % From bus
    jbus = branch(2); % To bus
    kbus = 0; % Dummy bus for two-winding transformers
    ckt = '1'; % Circuit identifier
    
    % Default parameters
    cw = 1; % Control winding for adjustment
    cz = 1; % Impedance code
    cm = 1; % Magnetizing admittance code
    mag1 = 0; % Magnetizing conductance
    mag2 = 0; % Magnetizing susceptance
    nmetr = 1; % Non-metered end code
    name = 'TF'; % Default name
    vecgrp = 'DYN11'; % Default vector group
    stat = branch(11); % Status
    % Default ownership and factor
    o1 = 1; f1 = 1.0; 
    % Assuming all other ownerships are not used
    o2 = 0; f2 = 1;
    o3 = 0; f3 = 1;
    o4 = 0; f4 = 1;
    tap = branch(9);
    
    % Detailed parameters
    r = branch(3); % Resistance, p.u.
    x = branch(4); % Reactance, p.u.
    sbase = mpc.baseMVA; % System base MVA
    windv1 = tap; % Winding 1 voltage
    nomv1 = mpc.bus(find(mpc.bus(:,1)==ibus), 10); % Nominal voltage of winding 1
    ang1 = 0; % Phase shift angle
    rate11 = branch(6); % Rating 1
    % Placeholder for additional detailed ratings RATE12 to RATE121
    cod1 = 0; % Control mode
    cont1 = 0; % Controlled bus ID
    node1 = 0; % Node for voltage control
    rma1 = 1.1; % Max tap ratio
    rmi1 = 0.9; % Min tap ratio
    vma1 = 1.1; % Max voltage limit
    vmi1 = 0.9; % Min voltage limit
    ntp1 = 33; % Number of tap positions
    tab1 = 0; % Excitation table
    cr1 = 0; % Regulation range
    cx1 = 0; % Reactive regulation range
    cnxa1 = 0; % Admittance threshold for parallel devices
    
    windv2 = 1.0; % Winding 2 voltage
    nomv2 = mpc.bus(find(mpc.bus(:,1)==jbus), 10); % Nominal voltage of winding 2
    
    % Writing transformer data
    fprintf(fid, '%d, %d, %d, ''%s'', %d, %d, %d, %.5f, %.5f, %d, ''%s'', %d, %d, %.2f, %d, %.2f, %d, %.2f, %d, %.2f, ''%s'' \n %.5f, %.5f, %.2f, %.1f, %.1f, %.1f, %.3f \n %.2f, %.2f\n', ...
        ibus, jbus, kbus, ckt, cw, cz, cm, mag1, mag2, nmetr, name, stat, 1, 1.0, 0, 1.0, 0, 1.0, 0, 1.0, vecgrp,  r, x, sbase, windv1, nomv1, ang1, rate11, windv2, nomv2);
end

% End of two-winding transformer data
fprintf(fid, '0 / END TWO-WINDING TRANSFORMER DATA,\n');

fclose(fid); % Close the file