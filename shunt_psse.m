mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_shunt_raw";

% Open output file
fid = fopen(output_file, 'w');

% % Write the header lines for PSS/E RAW file fixed shunt data
% fprintf(fid, '0 / BEGIN FIXED SHUNT DATA,\n');

% Assuming fixed shunt data could be part of bus data or a separate structure
% This script needs to be adjusted based on how your MATPOWER case file is structured
for i = 1:size(mpc.bus, 1)
    ibus = mpc.bus(i, 1); % Bus number
    shntid = '1'; % Default shunt identifier
    stat = 1; % Assuming shunt is in service
    gl = mpc.bus(i,5); % Default active component of shunt admittance
    bl = mpc.bus(i,6); % Default reactive component of shunt admittance
    
    % Example customization: Adjust gl and bl based on your MATPOWER case
    % For example, mpc.shunt could be a structure you have for shunt data
    % if isfield(mpc, 'shunt')
    %     % Find shunt data for this bus and adjust gl and bl accordingly
    % end
    
    % Write shunt data to file, with commas
    fprintf(fid, '%d, ''%s'', %d, %.2f, %.2f\n', ...
            ibus, shntid, stat, gl, bl);
end

% % End of fixed shunt data
% fprintf(fid, '0 / END FIXED SHUNT DATA,\n');

% Close the file
fclose(fid);

