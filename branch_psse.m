mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_branch_raw";

% Open output file
fid = fopen(output_file, 'w');

% % Write the header lines for PSS/E RAW file branch data
% fprintf(fid, '0 / BEGIN BRANCH DATA,\n');

% Loop through each branch in the MATPOWER case
for i = 1:size(mpc.branch, 1)
    branch = mpc.branch(i, :);
    if branch(9) ~= 0 % If it is a transformer 
        continue
    end

    ibus = branch(1); % From bus number
    jbus = branch(2); % To bus number
    r = branch(3); % Resistance, pu
    x = branch(4); % Reactance, pu
    b = branch(5); % Total line charging susceptance, pu
    rateA = branch(6); % RateA, MVA
    % rateB = branch(7); % RateB, MVA
    % rateC = branch(8); % RateC, MVA
    rateB = rateA; % RateB, MVA
    rateC = rateA; % RateC, MVA
    status = branch(11); % Branch status (1 - in service, 0 - out of service)
    % Default or placeholder values for PSSE-specific fields
    ckt = '1'; % Circuit identifier
    gi = 0; % G at the from bus end
    bi = 0; % B at the from bus end
    gj = 0; % G at the to bus end
    bj = 0; % B at the to bus end
    len = 0; % Line length, default or placeholder
    name = ' ';
    % Write branch data to file, with commas
    fprintf(fid, '%d, %d, ''%s'', %.5f, %.5f, %.5f, ''%s'' , %.2f, %.2f, %.2f, 0.0, 0.0, 0.0, 0.0, %d,  1, 1 \n', ...
            ibus, jbus, ckt, r, x, b,name, rateA, rateB, rateC, status);

end

% % End of branch data
% fprintf(fid, '0 / END BRANCH DATA,\n');

% Close the file
fclose(fid);