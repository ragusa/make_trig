function [cell_ID, surf_ID]  = create_boundary(x_bundle_center, y_bundle_center, cell_ID, surf_ID, file_handle_cell, file_handle_surf)        

alu_mat_ID   = 7;
alu_density  = -2.7; % strucural aluminium 6061 in g/cc
% hard coded geometric parameters
% delta   = 1.9272;  % is L_block/2
z_min   = 1;
z_max   = 2;
L_block = 3.8544; % block is a square 
inter_x = 0.218; % to have a bundle square

% boundary between two bundles

% border on the right
surf_ID=surf_ID+1; % increment surface ID
% write new cylinder surface in file_handle_surf
fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_bundle_center+L_block,x_bundle_center+L_block+inter_x,y_bundle_center-L_block,y_bundle_center+L_block,z_min,z_max);
cell_ID=cell_ID+1; % increment cell ID
% write new cell in file_handle_cell
fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,z_min,-z_max);

% border on the left
surf_ID=surf_ID+1; % increment surface ID
% write new cylinder surface in file_handle_surf
fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_bundle_center-L_block,x_bundle_center-L_block-inter_x,y_bundle_center-L_block,y_bundle_center+L_block,z_min,z_max);
cell_ID=cell_ID+1; % increment cell ID
% write new cell in file_handle_cell
fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,z_min,-z_max);  
