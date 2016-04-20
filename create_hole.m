function [cell_ID, surf_ID]  = create_hole(x_hole, y_hole, cell_ID, surf_ID, file_handle_cell, file_handle_surf)

% hardcoded values: material IDs
water_mat_ID     = 5;
alu_mat_ID       = 7;
% densities
alu_density       = -2.7; % in g/cc 
water_density     = -0.10004; % light water in g/cc
% z-plane surf ID
z_min        = 1;
z_max        = 2;
x_min_block  = 10;
x_max_block  = 11;
y_min_block  = 12;
y_max_block  = 13;
%radii
radius_water_hole = 3.05;
larg_block        = 8.1001; % idem as bundle dimensions
leng_block        = 7.7089; % idem as bundle dimensions

% Alumunium 
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%6d  rpp %g %g %g %g %g %g \n',surf_ID,x_min_block,x_max_block,y_min_block,y_max_block,z_min_block,z_max_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-surf_ID,-z_min,z_max);

% Water hole
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_hole,y_hole,radius_water_hole);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,water_mat_ID,water_density,-surf_ID,z_min,-z_max);
       
end 
