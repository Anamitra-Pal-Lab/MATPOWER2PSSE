mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_switched_raw";

% Assuming switching device data is stored similarly to branch data in MATPOWER
% Open output file
fid = fopen(output_file, 'w');

% Write the header lines for PSS/E RAW file switching device data
fprintf(fid, '0 / BEGIN SWITCHING DEVICE DATA,\n');

% Example data structure loop. Adapt as necessary for your data structure.
for i = 1:size(mpc.switching_device, 1)
    device = mpc.switching_device(i, :);
    ibus = device(1); % From bus number
    jbus = device(2); % To bus number
    ckt = '1'; % Default circuit identifier if not specified
    xpu = 1.0E-4; % Example reactance, adapt based on your data
    rate1 = device(3); % Example rating, adapt as necessary
    % Continue for rate2 to rate12 as per your data structure
    status = device(4); % Device status, adapt as necessary
    nstatus = 1; % Normal status, adapt as necessary
    metered = 2; % Metered end, adapt as necessary
    stype = 2; % Switching device type, adapt as necessary
    name = ''; % Device name, adapt as necessary
    
    % Write switching device data to file, with commas
    fprintf(fid, '%d, %d, ''%s'', %.5f, %.2f, %d, %d, %d, %d, ''%s''\n', ...
            ibus, jbus, ckt, xpu, rate1, status, nstatus, metered, stype, name);
    % Add rate2 to rate12 values in the fprintf statement as per your data
end

% End of switching device data
fprintf(fid, '0 / END SWITCHING DEVICE DATA,\n');

% Close the file
fclose(fid);

