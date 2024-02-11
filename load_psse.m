mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_load_raw";

% Open output file
fid = fopen(output_file, 'w');

% % Write the header lines for PSS/E RAW file load data
% fprintf(fid, '0 / BEGIN LOAD DATA,\n');

% Assuming load data is part of mpc.load
% This is a simplification; actual implementation might need adjustments
for i = 1:size(mpc.bus, 1)
    % Basic load data for each bus
    ibus = mpc.bus(i, 1); % Bus number
    loadid = '1'; % Default load ID
    stat = 1; % Assuming load is in service
    area = mpc.bus(i, 7); % Assuming area is specified in bus data
    zone = 1; % Default zone
    pl = mpc.bus(i, 3); % Active power load
    ql = mpc.bus(i, 4); % Reactive power load
    ip = 0; % Default constant current load (active power)
    iq = 0; % Default constant current load (reactive power)
    yp = 0; % Default constant admittance load (active power)
    yq = 0; % Default constant admittance load (reactive power)
    owner = 1; % Default owner
    scale = 1; % Default scale
    intrpt = 0; % Default interruptible load flag
    dgenp = 0; % Default distributed generation (active power)
    dgenq = 0; % Default distributed generation (reactive power)
    dgenm = 0; % Default distributed generation operation mode
    loadtype = ''; % Default load type
    
    % Write load data to file, with commas
    fprintf(fid, '%d, ''%s'', %d, %d, %d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %d, %d, %d, %.2f, %.2f, %d , '' ''\n', ...
            ibus, loadid, stat, area, zone, pl, ql, ip, iq, yp, yq, owner, scale, intrpt, ...
            dgenp, dgenq, dgenm);
end
% 
% % End of load data
% fprintf(fid, '0 / END LOAD DATA,\n');

% Close the file
fclose(fid);