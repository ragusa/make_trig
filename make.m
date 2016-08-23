clear all; close all; clc;

file_handle_cell=fopen('cell.txt','w+');
fprintf(file_handle_cell,'TESTING TRIGA CORE\n');
file_handle_surf=fopen('surf.txt','w+');

%file_handle_data=fopen('data.txt','r');

water_thickness_x=237.87; % distance between the concrete and the outer pool surfaces on the x axis
water_thickness_y=280.72; % distance between the concrete and the outer pool surfaces on the y axis
% active core dimensions
Lx = 72.90054;
Ly = 46.2534;
max_row=9;
max_col=6;
Lx_bundle = Lx/max_row;
Ly_bundle = Ly/max_col;
% given for the definition of the center of the bundle
% % % % pitch_x = 4.05;
% % % % pitch_y = 3.7089;
z_min_cm = -100;
z_max_cm = 200;


% create the surfaces to define the core
fprintf(file_handle_surf,'%5d  pz %g \n',1,z_min_cm);
fprintf(file_handle_surf,'%5d  pz %g \n',2,z_max_cm);
% % planes 3 4 5 6: x/y limits of the active core
% fprintf(file_handle_surf,'%5d  px %g \n',3,0 -water_thickness_x);   have been replace
% fprintf(file_handle_surf,'%5d  px %g \n',4,Lx+water_thickness_x);   by the rpp surface
% fprintf(file_handle_surf,'%5d  py %g \n',5,0 -water_thickness_y);   coded at the end 
% fprintf(file_handle_surf,'%5d  py %g \n',6,Ly+water_thickness_y);   of the make 
% define plans pz =0 and intermediates plans pz to create pins
%% pz for the shim safety rods or control rods
fprintf(file_handle_surf,'%5d  pz %g \n',7,-75.56 );
fprintf(file_handle_surf,'%5d  pz %g \n',8,-61.59 );
fprintf(file_handle_surf,'%5d  pz %g \n',9,-59.05 );
fprintf(file_handle_surf,'%5d  pz %g \n',10,-20.95); 
fprintf(file_handle_surf,'%5d  pz %g \n',11,-20.31);  
fprintf(file_handle_surf,'%5d  pz %g \n',12,-19.04); 
fprintf(file_handle_surf,'%5d  pz %g \n',13,19.06);  
fprintf(file_handle_surf,'%5d  pz %g \n',14,19.38);  
fprintf(file_handle_surf,'%5d  pz %g \n',15,20.65);  
fprintf(file_handle_surf,'%5d  pz %g \n',16,33.236); 
%% pz for the transient rod
fprintf(file_handle_surf,'%5d  pz %g \n',17,-20.31); 
fprintf(file_handle_surf,'%5d  pz %g \n',18,-19.04); 
fprintf(file_handle_surf,'%5d  pz %g \n',19,19.06 );  
fprintf(file_handle_surf,'%5d  pz %g \n',20,19.38 );  
fprintf(file_handle_surf,'%5d  pz %g \n',21,20.65 );  
fprintf(file_handle_surf,'%5d  pz %g \n',22,33.236); 
fprintf(file_handle_surf,'%5d  pz %g \n',49,-76.825);  
fprintf(file_handle_surf,'%5d  pz %g \n',50,112.601); 
%% pz for the regulating rod
fprintf(file_handle_surf,'%5d  pz %g \n',23,19.06 ); 
fprintf(file_handle_surf,'%5d  pz %g \n',24,19.38 ); 
fprintf(file_handle_surf,'%5d  pz %g \n',25,20.65 );  
fprintf(file_handle_surf,'%5d  pz %g \n',26,33.236);  
fprintf(file_handle_surf,'%5d  pz %g \n',48,54.816);  
%% pz for the regular fuel rods
fprintf(file_handle_surf,'%5d  pz %g \n',27,-38.1);
fprintf(file_handle_surf,'%5d  pz %g \n',28,-27.94);
fprintf(file_handle_surf,'%5d  pz %g \n',29,-19.05);
fprintf(file_handle_surf,'%5d  pz %g \n',30,19.05);
fprintf(file_handle_surf,'%5d  pz %g \n',31,27.94);
fprintf(file_handle_surf,'%5d  pz %g \n',32,38.1);
%% pz origin
fprintf(file_handle_surf,'%5d  pz %g \n',34,-0.430);
%% pz for water holes
fprintf(file_handle_surf,'%5d  pz %5g \n',35,-52.53);
fprintf(file_handle_surf,'%5d  pz %5g \n',36,-38.89);
%% pz for the detectors 
fprintf(file_handle_surf,'%5d  pz %5g \n',39,-33.135);
fprintf(file_handle_surf,'%5d  pz %5g \n',40,67.835);
fprintf(file_handle_surf,'%5d  pz %5g \n',41,68.15);
%% pz for the long tubes 
fprintf(file_handle_surf,'%5d  pz %5g \n',42,-16.28);
fprintf(file_handle_surf,'%5d  pz %5g \n',43,-15.68);
fprintf(file_handle_surf,'%5d  pz %5g \n',44,-10.68);
fprintf(file_handle_surf,'%5d  pz %5g \n',45,10.68);
%% PZ for the pneumatics
fprintf(file_handle_surf,'%5d  pz %5g \n',46,-33.81);
fprintf(file_handle_surf,'%5d  pz %5g \n',47,166.19);

water_mat_ID = 5;
water_density = -0.99799;

% starting IDs for automatically generated ID's
surf_ID = 50;
cell_ID = 50;

% fill bundle layout with fuel bundle
debug_viz=false;
if debug_viz
    F='empty_bundle';
    for i=1:max_row
        for j=1:max_col
            x_bundle_center(i,j) =  (i-1/2)*(Lx_bundle);
            y_bundle_center(i,j) =  (j-1/2)*(Ly_bundle);
            bundle_type{i,j}=F;
        end
    end
    
%     bundle_type{1,1}='water_holes';
%    bundle_type{1,2}='transient_bundle';
%  bundle_type{1,1}='reflector_block';
%    bundle_type{2,1}='detector_block';
%    bundle_type{2,2}='source_block';
%    bundle_type{2,3}='Lpneumatic_block';
%    bundle_type{3,3}='Spneumatic_block';
%    bundle_type{3,2}='shim_bundle';
%    bundle_type{3,4}='water_regulating_bundle';
	bundle_type{1,1}='bundle_test';
%  bundle_test{1,1}='fuel_bundle';

else
	% fill bundle layout with regular fuel bundles
    F='fuel_bundle';
    for i=1:max_row
        for j=1:max_col
            x_bundle_center(i,j) =  (i-1/2)*(Lx_bundle);
            y_bundle_center(i,j) =  (j-1/2)*(Ly_bundle);
            bundle_type{i,j}=F;
        end
    end
    
%     % % % put the bundles which are empty
%     index_i= [ 2 2 ];
%     index_j= [ 3 5 ];
%     for ii=1:length(index_i)
%         i=index_i(ii);
%         for jj=1:length(index_j)
%             j=index_j(jj);
%             bundle_type{i,j}='empty_bundle';
%         end
%     end
%     index_i= [ 3 7 ];
%     index_j= [ 4 4 ];
%     for ii=1:length(index_i)
%         i=index_i(ii);
%         for jj=1:length(index_j)
%             j=index_j(jj);
%             bundle_type{i,j}='empty_bundle';
%         end
%     end
	
    % % % put shim_bundle
    index_i= [ 4 4 6 6 ];
    index_j= [ 3 5 3 5];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='shim_bundle';
    end
	
    % % % put water_regulating_bundle 
    index_i= [ 3 ];
    index_j= [ 6 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='water_regulating_bundle';
    end
	
    % % % put transient_bundle
    index_i= [ 5 ];
    index_j= [ 4 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='transient_bundle';
    end
    % % % put water_holes
    index_i= [ 1 3 5 7 9 2 2 3 7];
    index_j= [ 1 1 1 1 1 3 5 4 4];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='water_holes';
    end
    
    
    % % % put reflector_block
    index_i= [ 1 1 1 1 2 8 8 8 8 9 9];
    index_j= [ 3 4 5 6 2 2 4 5 6 2 6];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='reflector_block';
    end
    
    
    % % % put detectors
    index_i= [ 9 9 9 ];
    index_j= [ 3 4 5 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='detector_block';
    end
    
    % % % put the neutron source
    index_i= [ 8 ];
    index_j= [ 3 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='source_block';
    end
    
    % % % put the large pneumatic
    index_i= [ 1 ];
    index_j= [ 2 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='Lpneumatic_block';
    end
    
	% % % put the small pneumatic
    index_i= [ 2 ];
    index_j= [ 4 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='Spneumatic_block';
    end
	
	% % % put long tubes
    index_i= [ 2 4 6 8 ];
    index_j= [ 1 1 1 1 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='A-raw_long_tube';
    end
	
	% % % put half fuel bundles
    index_i= [ 4 6 ];
    index_j= [ 2 2 ];
	if length(index_i)~=length(index_j)
	   error('index i/j not of the same length');
	end
    for ii=1:length(index_i)
        i=index_i(ii);
        j=index_j(ii);
        bundle_type{i,j}='half_bundle';
    end
	

	
	
end

% create each bundle
for i=1:max_row
    for j=1:max_col
        % keep track of the cell ID before creating the bundle
        cell_ID_bundle_start = cell_ID;
        [cell_ID, surf_ID]  = create_bundle(x_bundle_center(i,j),y_bundle_center(i,j), bundle_type{i,j},...
            cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        % keep track of the cell ID AFTER creating the bundle
        cell_ID_bundle_end   = cell_ID;
        % finish water box around a given bundle
        % create the 4 planes (MCNP will delete redundant surfaces anyway)
        surf_ID = surf_ID +1;
        fprintf(file_handle_surf,'%5d  px %g \n',surf_ID,(i-1)*Lx/9);
        surf_ID = surf_ID +1;
        fprintf(file_handle_surf,'%5d  px %g \n',surf_ID,(i  )*Lx/9);
        surf_ID = surf_ID +1;
        fprintf(file_handle_surf,'%5d  py %g \n',surf_ID,(j-1)*Ly/6);
        surf_ID = surf_ID +1;
        fprintf(file_handle_surf,'%5d  py %g \n',surf_ID,(j  )*Ly/6);
        % create the water cell for that bundle
        cell_ID=cell_ID+1; % increment cell ID
        fprintf(file_handle_cell,'%5d  %d %g %d %d %d %d %d %d \n',cell_ID,water_mat_ID,water_density,...
            1,-2,(surf_ID-3),-(surf_ID-2),(surf_ID-1),-surf_ID);
        k=0;
        for icell=cell_ID_bundle_start+1:cell_ID_bundle_end
            if k==0
                fprintf(file_handle_cell,'        ');  % just white spaces
            end
            fprintf(file_handle_cell,'#%d  ',icell);  % complement operation
            k=k+1;
            if k==8
                fprintf(file_handle_cell,'\n');
                k=0;
            end
        end
        if k==0
            fprintf(file_handle_cell,'     imp:n=1 \n');
        else
            fprintf(file_handle_cell,'imp:n=1 \n');
        end
    end
end

%
%    +-----------------6----------------+
%    |                                  |
%    |      +----------d---------+      |
%    |      |                    |      |
%    3      a       core         b      4
%    |      |                    |      |
%    |      +----------c---------+      |
%    |                                  |
%    +-----------------5----------------+
%
% RPP a b c d zmin zmax
a = 0;
b = Lx;
c = 0;
d = Ly;
surf_ID = surf_ID +1; 
fprintf(file_handle_surf,'%5d  rpp %g %g %g %g %g %g \n',surf_ID,a,b,c,d,z_min_cm,z_max_cm);
% pool: cylinder
surf_ID = surf_ID +1; 
water_thickness = 111; %%% To be checked;
pool_radius = 137.16; %% hard coded and taken from AA0_Critical.inp Surf 9111
fprintf(file_handle_surf,'%5d  c/z %g %g %g \n',surf_ID,Lx/2,Ly/2,pool_radius );
% cell outside of core, inside of pool
cell_ID=cell_ID+1; % increment cell ID
fprintf(file_handle_cell,'%5d  %d %g %d %d 1 -2 imp:n=1\n',cell_ID,water_mat_ID,water_density,-surf_ID,surf_ID-1);

% % % create the water cell for water outside of the core
% % cell_ID=cell_ID+1; % increment cell ID
% % % fprintf(file_handle_cell,'%5d  %d %g (1 -2 3 -4 d -6):(1 -2 3 -4 5 -c):(1 -2 3 -a c -d):(1 -2 b -4 c -d) \n',cell_ID,water_mat_ID,water_density,...
% % fprintf(file_handle_cell,'%5d  %d %g (1 -2 3 -4 %d -6):(1 -2 3 -4 5 -%d):\n%s(1 -2 3 -%d %d -%d):(1 -2 %d -4 %d -%d) imp:n=1\n',...
% %     cell_ID,water_mat_ID,water_density,d,c,'                  ',a,c,d,b,c,d);
        
% importance 0
cell_ID=cell_ID+1; % increment cell ID
fprintf(file_handle_cell,'%5d  %d %d:%d:%d imp:n=0 \n',cell_ID,0,-1,2,surf_ID);


fprintf(file_handle_cell,'\n');
fprintf(file_handle_surf,'\n');
fclose(file_handle_cell);
fclose(file_handle_surf);

% system('copy cell.txt+surf.txt+data.txt input.inp');
system('copy cell.txt+surf.txt+data.txt+data_RT.txt input.inp');