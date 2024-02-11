mpc = loadcase('case_ACTIVSg10k');
output_file = "case_10k_gen_raw3";
ireg_list = xlsread("Book1_IREG.xlsx");

% Open output file
fid = fopen(output_file, 'w');

% % Write the header lines for PSS/E RAW file generator data
% fprintf(fid, '0 / BEGIN GENERATOR DATA,\n');

% Loop through each generator in the MATPOWER case
for i = 1:size(mpc.gen, 1)
    gen = mpc.gen(i, :);
    ibus = gen(1); % Generator bus number
    machid = '1'; % Default machine ID
    pg = gen(2); % Generator active power output in MW
    qg = gen(3); % Generator reactive power output in Mvar
    qt = gen(4); % Maximum generator reactive power output
    qb = gen(5); % Minimum generator reactive power output
    vs = gen(6); % Default voltage setpoint in pu
    ireg = ireg_list(i); % Default remote bus number for voltage regulation
    nreg = 0; % A node number of bus IREG. If bus IREG is not in a substation, NREG must be specified as 0.
    mbase = gen(7); % Machine base power in MVA
    zr = 0.0; % Real part of machine impedance, default value
    zx = 0.0; % Imaginary part of machine impedance, default value
    rt = 0.0; % Real part of transformer impedance, default value
    xt = 0.0; % Imaginary part of transformer impedance, default value
    gtap = 1.0; % Default transformer tap setting
    stat = gen(8); % Generator status (1 - in service, 0 - out of service)
    % Default values for fields not directly available in MATPOWER
    rmpct = gen(21); % Default participation factor
    pt = gen(9); % Default maximum active power output
    pb = gen(10); % Default minimum active power output
    % Additional default values for PSSE fields not available in MATPOWER
    baslod = 0; % Base load flag, default value
    o1 = 1; f1 = 1.0; % Ownership information, default values
    o2=0; o3=0;o4=0;
    f2=1;f3=1;f4=1;
    % Machine control mode and power factor, default values
    if string(mpc.genfuel(i)) =='solar' || string(mpc.genfuel(i)) == 'wind'
        wmod = 1;
    else
        wmod = 0;
    end

    wpf = 1.0;
    
    % Write generator data to file, with commas
    fprintf(fid, '%d, ''%s'', %.2f, %.2f, %.2f, %.2f, %.2f, %d, %d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %d, %.2f, %.2f, %.2f, %d, %d, %.2f, %d, %.2f, %d, %.2f, %d, %.2f, %d, %.2f\n', ...
            ibus, machid, pg, qg, qt, qb, vs, ireg, nreg, mbase, zr, zx, rt, xt, gtap, stat, rmpct, pt, pb, baslod, o1, f1, o2, f2, o3, f3, o4, f4, wmod, wpf);
end
% 
% % End of generator data
% fprintf(fid, '0 / END GENERATOR DATA,\n');

% Close the file
fclose(fid);
