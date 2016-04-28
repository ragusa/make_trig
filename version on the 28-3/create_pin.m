function [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf)
%

% hardcoded values: material IDs
zr_rod_mat_ID         = 1;
fuel_meat_mat_ID      = 2;
clad_mat_ID           = 3;
graphite_mat_ID       = 4;
water_mat_ID          = 5;
air_mat_ID            = 6;
alu_mat_ID            = 7;
detector_mat_ID       = water_mat_ID; % water inside in the MCNP input
pneumatic_mat_ID      = air_mat_ID;
pneu_clad_mat_ID      = alu_mat_ID; % small and large pneumatics clads are Aluminium
source_mat_ID         = graphite_mat_ID; % air or water
lead_mat_ID           = 8;
spacer_mat_ID         = 9;
can_mat_ID            = air_mat_ID;
clad_long_tube_mat_ID = spacer_mat_ID;
% densities
zr_rod_density         = -6.51; % in g/cc or 0.01296
fuel_meat_density      = 8.71115E-02; % atom density for fresh fuel
clad_density           = -8.0; % in g/cc
graphite_density       = -1.7; % in g/cc or 8.5210E-2
water_density          = -0.10004; % light water in g/cc
air_density            = 1.0E-05;
alu_density            = -2.7; % strucural aluminium 6061 in g/cc
detector_density       = water_density % water_density
pneumatic_density      = air_density;
spacer_density         = -8.0; % SS-304,SS-304L or steanless aluminium
pneu_clad_mat_density  = spacer_density; % aluminium
source_density         = graphite_density;
lead_density           = -11.34; % g/cc
can_density            = air_density;
clad_long_tube_density = spacer_density
% radii
radius_zr_rod            = 0.3175;
radius_fuel_meat         = 1.7412;
radius_clad              = 1.7919; % radius_clad = radius_graphite
radius_water_hole        = 3.05;   % the water hole is created as a pin and then is is put into the bundle 'water' to match what is in make_triga_core.m
radius_detector          = 3.175;
radius_inner_source      = 1.580;
radius_outer_source      = 1.905;
radius_inner_Lpneu       = 1.580;
radius_outer_Lpneu       = 1.905;
radius_inner_small_Spneu = 0.885;
radius_outer_small_Spneu = 0.950;
radius_inner_large_Spneu = 1.225;
radius_outer_large_Spneu = 1.300;
L_block                  = 3.8544; % block is a square 
z_block                  = 40;
thickness_clad           = 0.32500;
thickness_box_x          = 1.8600;
thickness_box_y          = 0.63500;
radius_A_row             = 3.05;
radius_clad_A_row        = 3.3675;
% % radius_D_row             = 3.05;
% % radius_clad_D_row        = 3.3675;
% z-plane surf ID
z_min        = 1;
z_max        = 2;
z_int_inf    = 7;
z_int_sup    = 8;
z_org        = 9;
z_min_source = 10;
z_1          = 11;
z_2          = 12;
z_3          = 13;
z_4          = 14;


switch pin_type
    
    case 'regular_fuel_rod'
        
        % inner Zr rod
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_zr_rod);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,zr_rod_mat_ID,zr_rod_density,-surf_ID,z_int_inf,-z_int_sup);
        
        % fuel meat
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,fuel_meat_mat_ID,fuel_meat_density,-surf_ID,surf_ID-1,z_int_inf,-z_int_sup);
        
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        %graphite extremities
        %upper rod, use same surfID as cladding cylinder
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-(surf_ID-1),z_int_sup,-z_max);
        %lower rod
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-(surf_ID-1),z_min,-z_int_inf);
        
    case 'fuel-followed_control_rod'
        
        % fuel lower part
        % inner zr rod
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center,y_center,radius_zr_rod);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,zr_rod_mat_ID,zr_rod_density,-surf_ID,z_min,-z_org);
        % fuel meat
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,fuel_meat_mat_ID,fuel_meat_density,-surf_ID,surf_ID-1,z_min,-z_org);
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        % graphite upper part
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-(surf_ID-1),z_org,-z_max);
        
    case 'water-followed_control_rod'
        % graphite upper part
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_org,-z_max);
        
        % water lower part
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,z_min,-z_org);
        
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        
    case 'air-followed_transient_rod'
        % graphite upper part
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_org,-z_max);
        
        % air lower part
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_min,-z_org);
        
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        
    case 'water'
        % Water inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_water_hole);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,z_min,-z_max);
        
        % Alumunium box
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block, -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
        
    case 'reflector'
        %graphite block
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_min,-z_max);
        
        
    case 'detector'
        % detector inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_detector);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,detector_mat_ID,detector_density,-surf_ID,z_min,-z_max);
        
        % Graphite box
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block+thickness_clad,x_center+L_block-thickness_clad, y_center-L_block+thickness_clad,y_center+L_block-thickness_clad, -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
        % Aluminium clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block, y_center-L_block,y_center+L_block, -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
    case 'source'
        % inner cylinder of the source
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_inner_source);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,source_mat_ID,source_density,-surf_ID,z_min_source,-z_max);
        
        % outer cylinder ot the source
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_outer_source);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,surf_ID-1,z_min_source,-z_max); % CHECK
        
        % Graphite box
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block+thickness_box_x,x_center+L_block-thickness_box_x,...
                                                                         y_center-L_block+thickness_box_y,y_center+L_block-thickness_box_y,...
                                                                         -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
        % Aluminium clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block, y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
        
    case 'large_pneumatic'
        % Pneumatic inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_inner_Lpneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,pneumatic_mat_ID,pneumatic_density,-surf_ID,z_min,-z_max);
        % Pneumatic clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center,y_center,radius_outer_Lpneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,pneu_clad_mat_ID,pneu_clad_mat_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        % water block
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
    case 'small_pneumatic'
        % small pneumatic
        % small pneumatic inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center+2,y_center,radius_inner_small_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,pneumatic_mat_ID,pneumatic_density,-surf_ID,z_min,-z_max);
        % Pneumatic clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center+2,y_center,radius_outer_small_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,pneu_clad_mat_ID,pneu_clad_mat_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        % large pneumatic inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center-2,y_center,radius_inner_large_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,pneumatic_mat_ID,pneumatic_density,-surf_ID,z_min,-z_max);
        % Pneumatic clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n', surf_ID,x_center-2,y_center,radius_outer_large_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,pneu_clad_mat_ID,pneu_clad_mat_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        % water block
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,+surf_ID-1,+surf_ID-3,z_min,-z_max);
         
    case 'A-raw'
        % From the bottom to the top
        
        % Lead         
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_A_row);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,lead_mat_ID,lead_density,-surf_ID,z_min,-z_1);

        % Spacer
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,spacer_mat_ID,spacer_density,-surf_ID,z_1,-z_2);
        
        % Air
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_2,-z_3);        
        
        % Can
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,can_mat_ID,can_density,-surf_ID,z_3,-z_4);         
 
        % Air
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_4,-z_max);     
        
        % Clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_clad_A_row);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,clad_long_tube_mat_ID,clad_long_tube_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        % Water outside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
%      case 'D-raw'
%         % From the bottom to the top
%         
%         % Lead         
%         surf_ID=surf_ID+1; % increment surface ID
%         % write new cylinder surface in file_handle_surf
%         fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_D_row);
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,lead_mat_ID,lead_density,-surf_ID,z_min,-z_1);
% 
%         % Spacer
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,spacer_mat_ID,spacer_density,-surf_ID,z_1,-z_2);
%         
%         % Air
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_2,-z_3);        
%         
%         % Can
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,can_mat_ID,can_density,-surf_ID,z_3,-z_4);         
%  
%         % Air
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_4,-z_max);     
%         
%         % Clad
%         surf_ID=surf_ID+1; % increment surface ID
%         % write new cylinder surface in file_handle_surf
%         fprintf(file_handle_surf,'%5d  C/Z %g %g %g \n',surf_ID,x_center,y_center,radius_clad_D_row);
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,clad_long_tube_mat_ID,clad_long_tube_density,-surf_ID,surf_ID-1,z_min,-z_max);
%         
%         % Water outside
%         surf_ID=surf_ID+1; % increment surface ID
%         % write new cylinder surface in file_handle_surf
%         fprintf(file_handle_surf,'%5d  RPP %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
%         cell_ID=cell_ID+1; % increment cell ID
%         % write new cell in file_handle_cell
%         fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
    otherwise
        error('other pin types not coded yet');
end
