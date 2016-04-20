function [cell_ID, surf_ID]  = create_reflector(x_reflector, y_reflector, cell_ID, surf_ID, file_handle_cell, file_handle_surf)

% hardcoded values: material IDs
graphite_mat_ID  = 4;
water_mat_ID     = 5;
% densities
graphite_density  = -1.7; % in g/cc or 8.5210E-2
water_density     = -0.10004; % light water in g/cc
% z-plane surf ID
z_min        = 1;
z_max        = 2;
x_min_block  = 10;
x_max_block  = 11;
y_min_block  = 12;
y_max_block  = 13;
%dimesions of the block = the dimensions of the bundle
x_min = ;

% block of graphite 
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%6d  rpp %g %g %g %g %g %g \n',surf_ID,x_min_block,x_max_block,y_min_block,y_max_block,z_min_block,z_max_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %g %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,-z_min,z_max);

  
end 
