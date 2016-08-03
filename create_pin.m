function [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf)


% hardcoded values: material IDs
zr_rod_mat_ID         = 1;
fuel_meat_mat_ID      = 2;
clad_mat_ID           = 3;
graphite_mat_ID       = 4;
water_mat_ID          = 5;
air_mat_ID            = 6;
alu_mat_ID            = 7; % is the spacer material too
detector_mat_ID       = water_mat_ID; % water inside in the MCNP input
pneumatic_mat_ID      = air_mat_ID;
pneu_clad_mat_ID      = alu_mat_ID; % small and large pneumatics clads are Aluminium
source_mat_ID         = graphite_mat_ID; % air or water
lead_mat_ID           = 8;
spacer_mat_ID         = clad_mat_ID;
can_mat_ID            = air_mat_ID;
clad_long_tube_mat_ID = clad_mat_ID;
abs_mat_ID            = 9;
% densities
zr_rod_density         = -0.99799; % in g/cc or 0.01296
fuel_meat_density      = 8.71115E-02; % atom density for fresh fuel according to Barnfire files
clad_density           = -0.99799; % atom density for fresh fuel according to Barnfire files
graphite_density       = -0.99799; % in g/cc or 8.5210E-2
water_density          = -0.99799; % light water in g/cc
air_density            = -0.99799;
alu_density            = -0.99799; % strucural aluminium 6061 in g/cc
%% alu is also the spacer material, the grid material and the bottom plug material
detector_density       = water_density; % water_density
pneumatic_density      = air_density;
spacer_density         = clad_density; % SS-304,SS-304L or steanless aluminium
pneu_clad_mat_density  = clad_density; 
source_density         = graphite_density;
lead_density           = -0.99799; % g/cc
can_density            = air_density;
clad_long_tube_density = clad_density;
abs_density            = -0.99799;
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
thickness_box_x          = 1.9050;
thickness_box_y          = 0.63500;
radius_A_row             = 3.05;
radius_clad_A_row        = 3.3675;
radius_low               = 3.865;
radius_high              = 3.05; 
% % radius_D_row             = 3.05;
% % radius_clad_D_row        = 3.3675;
% z-plane surf ID
z_min               = 1;
z_max               = 2;
z_min_shim          = 7;
z_1_shim            = 8;
z_2_shim            = 9;
z_3_shim            = 10;
z_4_shim            = 11;
z_5_shim            = 12;
z_6_shim            = 13;
z_7_shim            = 14;
z_8_shim            = 15;
z_max_shim          = 16;
z_min_transient     = 17;
z_1_transient       = 18;
z_2_transient       = 19;
z_3_transient       = 20;
z_4_transient       = 21;
z_max_transient     = 22;
z_min_regulating    = 23;
z_1_regulating      = 24;
z_2_regulating      = 25;
z_max_regulating    = 26;
z_min_fuel          = 27;
z_1_fuel            = 28;
z_2_fuel            = 29;
z_3_fuel            = 30;
z_4_fuel            = 31;
z_max_fuel          = 32;
z_org               = 33;
z_min_source        = 34;
z_min_water_hole    = 35;
z_max_water_hole    = 36;
z_1_detector        = 39;
z_2_detector        = 40;
z_3_detector        = 41;
z_1_tube            = 42;
z_2_tube            = 43;
z_3_tube            = 44;
z_4_tube            = 45;
z_min_pneum         = 46;
z_max_pneum         = 47;


switch pin_type
    
    case 'regular_fuel_rod'
        
        % inner Zr rod
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_zr_rod);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,zr_rod_mat_ID,zr_rod_density,-surf_ID,z_2_fuel,-z_3_fuel);
        
        % fuel meat
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,fuel_meat_mat_ID,fuel_meat_density,-surf_ID,surf_ID-1,z_2_fuel,-z_3_fuel);
        
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_2_fuel,-z_3_fuel);
        
        %graphite extremities
        %lower part, use same surfID as cladding cylinder
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-(surf_ID),z_1_fuel,-z_2_fuel);
        %upper part
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,graphite_mat_ID,graphite_density,-(surf_ID),z_3_fuel,-z_4_fuel);
        
		%Aluminium extremities
        %upper rod, use same surfID as cladding cylinder
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID),z_4_fuel,-z_max_fuel);
        %lower rod
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID),z_min_fuel,-z_1_fuel);
		
    case 'fuel_control_rod'
        
        % fuel lower part
        % inner zr rod
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_zr_rod);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,zr_rod_mat_ID,zr_rod_density,-surf_ID,z_2_shim,-z_3_shim);
        % fuel meat
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,fuel_meat_mat_ID,fuel_meat_density,-surf_ID,surf_ID-1,z_2_shim,-z_3_shim);
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_2_shim,-z_3_shim);
		
        %use same surfID as cladding cylinder for spacer, air and aluminium
		
		%spacer 
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID-1),-z_2_shim,z_1_shim);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID-1),-z_5_shim,z_4_shim);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID-1),-z_8_shim,z_7_shim);		
 		
		%air 
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,air_mat_ID,air_density,-(surf_ID-1),-z_1_shim,z_min_shim);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,air_mat_ID,air_density,-(surf_ID-1),-z_4_shim,z_3_shim);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,air_mat_ID,air_density,-(surf_ID-1),-z_7_shim,z_6_shim);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,air_mat_ID,air_density,-(surf_ID-1),-z_max_shim,z_8_shim);		
		
		%aluminium 
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID-1),z_min,-z_min_shim);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,alu_mat_ID,alu_density,-(surf_ID-1),z_max_shim,-z_max);
		
		%absorber 
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1\n',cell_ID,abs_mat_ID,abs_density,-(surf_ID-1),z_5_shim,-z_6_shim);		
		

        
    case 'regulating_rod'
        % absorber
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,abs_mat_ID,abs_density,-surf_ID,-z_min_regulating,z_min);
		
		% air
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,-z_1_regulating,z_min_regulating);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,-z_max_regulating,z_2_regulating);
		
		% spacer
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,-z_2_regulating,z_1_regulating);
        
        % aluminium
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,-z_max,z_max_regulating);
        
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        
    case 'transient_rod'
        % air
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_min,-z_min_transient);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_2_transient,-z_3_transient);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_4_transient,-z_max_transient);
        
		% spacer
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,z_min_transient,-z_1_transient);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,z_3_transient,-z_4_transient);	
		
		% absorber
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,abs_mat_ID,abs_density,-surf_ID,z_1_transient,-z_2_transient);
		
		% Aluminium
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,z_max_transient,-z_max);
		
        % clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        
	case 'water1'
        % Water inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_water_hole);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,z_min,-z_max);
        
        % Alumunium box
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block, -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
  		% Bundle box 
  		surf_ID=surf_ID+1; % increment surface ID
  		% write the box surface in file_handle_surf
  		fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,z_min_fuel,z_max_fuel);
  		cell_ID=cell_ID+1; % increment cell ID
  		% write new cell in file_handle_cell
  		fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-2,z_min_water_hole,-z_max_water_hole);
     
	 case 'water2'
        % Water inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_water_hole);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,z_min_water_hole,-z_max_water_hole);
       
        % Alumunium box
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block, -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-1,z_min_water_hole,-z_max_water_hole);
      
	 
    case 'reflector'
        %graphite block
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_min,-z_max);
    
    case 'empty'
        % filled of water
     
        
    case 'detector'
		% graphite
		surf_ID=surf_ID+1; % increment surfqce ID
		% write new box surface in file_handle_surf
		fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-3.495,x_center-1.31,y_center-3.495,y_center+3.495,-33.135,67.835);
		cell_ID=cell_ID+1; % increment cell ID% 
		% write a new cell in file_handle_cell with graphite inside
		fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,z_1_detector,-z_2_detector);
        % % water
		% surf_ID=surf_ID+1; % increment surface ID
		% % write a new box surface in file_handle_surf
		% fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-1.31,x_center+3.495,y_center-3.495,y_center+3.495,-33.135,67.835);
		% cell_ID=cell_ID+1; % increment cell ID% 
		% % write a new cell in file_handle_cell with graphite inside
		% fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,z_1_detector,-z_2_detector);
		
		% cladding 
		surf_ID=surf_ID+1; % increment surface ID
		% write a new box surface in file_handle_surf
		fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-3.81,x_center+3.81,y_center-3.81,y_center+3.81,-33.135,68.15);
		cell_ID=cell_ID+1; % increment cell ID% 
		% write a new cell in file_handle_cell with clad inside 
		fprintf(file_handle_cell,'%5d  %d %g %d  %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,surf_ID-2,z_1_detector,-z_3_detector);

        
    case 'source1'
        % inner cylinder of the source
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_inner_source);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,source_mat_ID,source_density,-surf_ID,z_min_source,-z_max);
        
        % outer cylinder ot the source
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_outer_source);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,surf_ID-1,z_min_source,-z_max); 
        
        % Graphite box
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block+thickness_box_x,x_center+L_block-thickness_box_x,...
                                                                         y_center-L_block+thickness_box_y,y_center+L_block-thickness_box_y,...
                                                                         -z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
        % Aluminium clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block, y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,alu_mat_ID,alu_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
    case 'source2'
        % source pin
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center-L_block+radius_inner_source,y_center,radius_inner_source);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,source_mat_ID,source_density,-surf_ID,z_min_source,-z_max);
       
        % block of graphite
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,graphite_mat_ID,graphite_density,-surf_ID,+surf_ID-1,z_min,-z_max);
        
    case 'large_pneumatic'
        % Pneumatic inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_inner_Lpneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,pneumatic_mat_ID,pneumatic_density,-surf_ID,z_min_pneum,-z_max_pneum);
        % Pneumatic clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_outer_Lpneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,pneu_clad_mat_ID,pneu_clad_mat_density,-surf_ID,surf_ID-1,z_min_pneum,-z_max_pneum);
        
        
    case 'small_pneumatic'
        % small pneumatic
        % small pneumatic inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center+2,y_center,radius_inner_small_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,pneumatic_mat_ID,pneumatic_density,-surf_ID,z_min_pneum,-z_max_pneum);
        % Pneumatic clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center+2,y_center,radius_outer_small_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,pneu_clad_mat_ID,pneu_clad_mat_density,-surf_ID,surf_ID-1,z_min_pneum,-z_max_pneum);
        
        % large pneumatic inside
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center-2,y_center,radius_inner_large_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,pneumatic_mat_ID,pneumatic_density,-surf_ID,z_min_pneum,-z_max_pneum);
        % Pneumatic clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center-2,y_center,radius_outer_large_Spneu);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,pneu_clad_mat_ID,pneu_clad_mat_density,-surf_ID,surf_ID-1,z_min_pneum,-z_max_pneum);
        
         
		case 'A-raw'
        % From the bottom to the top
        
        % Lead         
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_A_row);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,lead_mat_ID,lead_density,-surf_ID,z_min,-z_1_tube);

        % Spacer
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,spacer_mat_ID,spacer_density,-surf_ID,z_1_tube,-z_2_tube);
        
        % Air
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_2_tube,-z_3_tube);        
        
        % Can
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,can_mat_ID,can_density,-surf_ID,z_3_tube,-z_4_tube);         
 
        % Air
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d imp:n=1 \n',cell_ID,air_mat_ID,air_density,-surf_ID,z_4_tube,-z_max);     
        
        % Clad
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_clad_A_row);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d  imp:n=1\n',cell_ID,clad_long_tube_mat_ID,clad_long_tube_density,-surf_ID,surf_ID-1,z_min,-z_max);
        
        % % Water outside
        % surf_ID=surf_ID+1; % increment surface ID
        % % write new cylinder surface in file_handle_surf
        % fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,x_center-L_block,x_center+L_block,y_center-L_block,y_center+L_block,-z_block,z_block);
        % cell_ID=cell_ID+1; % increment cell ID
        % % write new cell in file_handle_cell
        % fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,water_mat_ID,water_density,-surf_ID,+surf_ID-1,z_min,-z_max);
		
		case 'water-followed_rod'
        % graphite upper part
        surf_ID=surf_ID+1; % increment surface ID
        % write new cylinder surface in file_handle_surf
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,x_center,y_center,radius_fuel_meat);
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
        fprintf(file_handle_surf,'%5d  c/z %g %g %g \n', surf_ID,x_center,y_center,radius_clad);
        cell_ID=cell_ID+1; % increment cell ID
        % write new cell in file_handle_cell
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d imp:n=1 \n',cell_ID,clad_mat_ID,clad_density,-surf_ID,surf_ID-1,z_min,-z_max);
                
    otherwise
        error('other pin types not coded yet');
end
