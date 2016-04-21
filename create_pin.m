function [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf)
%

% hardcoded values: material IDs
zr_rod_mat_ID    = 1;
fuel_meat_mat_ID = 2;
clad_mat_ID      = 3;
graphite_mat_ID  = 4;
water_mat_ID     = 5;
air_mat_ID       = 6;
% densities
zr_rod_density    = -6.51; % in g/cc or 0.01296
fuel_meat_density = 8.71115E-02; % atom density for fresh fuel
clad_density      = -8.0; % in g/cc 
graphite_density  = -1.7; % in g/cc or 8.5210E-2
water_density     = -0.10004; % light water in g/cc
air_density       = -1.0E-05; % in g/cc
% radii
radius_zr_rod    = 0.3175;
radius_fuel_meat = 1.7412;
radius_clad      = 1.7919; %radius_clad = radius_graphite=water_radius
% z-plane surf ID
z_min     = 1;
z_max     = 2;
z_int_inf = 7;
z_int_sup = 8;
z_org     = 9; 

switch pin_type
    
    case 'regular_fuel_rod'
        
        % inner Zr rod
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_zr_rod);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,zr_rod_mat_ID,zr_rod_density,-surf_ID,z_int_inf,-z_int_sup);
        
        % fuel meat
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d %d  imp:n=1\n',cell_ID,fuel_meat_mat_ID,fuel_meat_density,-surf_ID,surf_ID-1,z_int_inf,-z_int_sup);
        
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d %d  imp:n=1\n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_int_inf,-z_int_sup);
        
        %graphite extremities
        %upper rod, use same surfID as cladding cylinder
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_int_sup,-z_max);
        %lower rod
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_min,-z_int_inf);
        
        case 'fuel-followed_control_rod'
      
        % fuel lower part
        % inner zr rod 
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprint(file_handle_surf,'%5   C/Z %g %g %g /n', surf_ID,x_center,y_center,radius_zr_rod);
        cell_ID=celle_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprinf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1',cell_ID,zr_rod_mat_ID,zr_rod_mat_density,-surf_ID,z_min,-z_org);
        % fuel meat
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprint(file_handle_surf,'%5   C/Z %g %g %g /n', surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=celle_ID+1; % increment cell ID
        % write new celle in file_handle_cell
        fprinf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1',cell_ID,fuel_meat_mat_ID,fuel_meat_density,-surf_ID,surf_ID-1,z_min,-z_org);
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprint(file_handle_surf,'%5   C/Z %g %g %g /n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=celle_ID+1; % increment cell ID
        % write new celle in file_handle_cell
        fprinf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_org);
               
        % graphite upper part
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_org,-z_max);
        
        case 'water-followed_control_rod'
        % graphite upper part
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_org,-z_max);
        
        % water lower part
        cell_ID=celle_ID+1; % increment cell ID
        % write new celle in file_handle_cell
        fprinf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1',cell_ID,water_mat_ID,water_density,-surf_ID,surf_ID-1,z_min,-z_org);
        
%         case 'air-followed_transient_rod'
%         % graphite upper part
%         surf_ID=surf_ID+1; % increment surface ID
%         % write new cylinder surface in file_handle_surf
%         fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_clad);
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_org,-z_max);
%         
%         % air lower part
%         surf_ID=surf_ID+1; % increment surface ID
%         % write new cylinder surface in file_handle_surf
%         fprint(file_handle_surf,'%5   C/Z %g %g %g /n', surf_ID,x_center,y_center,radius_clad);
%         cell_ID=celle_ID+1; % increment cell ID
%         % write new celle in file_handle_cell
%         fprinf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1',cell_ID,air_mat_ID,air_density,-surf_ID,surf_ID-1,z_min,-z_org);
%         
    otherwise
        error('other pin types not coded yet');
end 
