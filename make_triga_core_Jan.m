clear all; close all; clc;

file_handle_cell=fopen('cell.txt','w+');
fprintf(file_handle_cell,'TESTING TRIGA CORE\n');
file_handle_surf=fopen('surf.txt','w+');

%file_handle_data=fopen('data.txt','r');

water_thickness_x = 15;  % distance between the concrete and the outer pool surfaces on the x axis
water_thickness_y = 15; % distance between the concrete and the outer pool surfaces on the y axis
h_control_rod     = 0; % place the bottom of the control rod regarding the bottom of the core
h_regulating_rod  = 0; % place the bottom of the regulating rod regarding the bottom of the core
h_transient_rod   = 0; % place the bottom of the transient rod regarding the bottom of the core
% create the surfaces to define the core
fprintf(file_handle_surf,'%5d  PZ %g \n',1,-80.0);
fprintf(file_handle_surf,'%5d  PZ %g \n',2, 80.0);
fprintf(file_handle_surf,'%5d  PX %g \n',3,0       -water_thickness_x);
fprintf(file_handle_surf,'%5d  PX %g \n',4,72.90054+water_thickness_x);
fprintf(file_handle_surf,'%5d  PY %g \n',5,0      -water_thickness_y);
fprintf(file_handle_surf,'%5d  PY %g \n',6,46.2534+water_thickness_y);
% define plans PZ =0 and intermediates plans PZ to create pins
%% PZ for the shim safety rods or control rods
fprintf(file_handle_surf,'%5d  PZ %g \n',7,-75.56 +h_control_rod);
fprintf(file_handle_surf,'%5d  PZ %g \n',8,-61.59 +h_control_rod);
fprintf(file_handle_surf,'%5d  PZ %g \n',9,-59.05 +h_control_rod);
fprintf(file_handle_surf,'%5d  PZ %g \n',10,-20.95+h_control_rod); 
fprintf(file_handle_surf,'%5d  PZ %g \n',11,-30.31+h_control_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',12,-19.04+h_control_rod); 
fprintf(file_handle_surf,'%5d  PZ %g \n',13,19.06 +h_control_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',14,19.38 +h_control_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',15,20.65 +h_control_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',16,33.236+h_control_rod); 
%% PZ for the transient rod
fprintf(file_handle_surf,'%5d  PZ %g \n',17,-20.31+h_transient_rod); 
fprintf(file_handle_surf,'%5d  PZ %g \n',18,-19.04+h_transient_rod); 
fprintf(file_handle_surf,'%5d  PZ %g \n',19,19.06 +h_transient_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',20,19.38 +h_transient_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',21,20.65 +h_transient_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',22,33.236+h_transient_rod); 
%% PZ for the regulating rod
fprintf(file_handle_surf,'%5d  PZ %g \n',23,19.06+h_regulating_rod); 
fprintf(file_handle_surf,'%5d  PZ %g \n',24,19.38+h_regulating_rod); 
fprintf(file_handle_surf,'%5d  PZ %g \n',25,20.65+h_regulating_rod);  
fprintf(file_handle_surf,'%5d  PZ %g \n',26,33.236 +h_regulating_rod);   
%% PZ for the regular fuel rods
fprintf(file_handle_surf,'%5d  PZ %g \n',27,-27.94);
fprintf(file_handle_surf,'%5d  PZ %g \n',28,-19.05);
fprintf(file_handle_surf,'%5d  PZ %g \n',29,19.05);
fprintf(file_handle_surf,'%5d  PZ %g \n',30,27.94);
%% PZ origin
fprintf(file_handle_surf,'%5d  PZ %g \n',31,0.00);
fprintf(file_handle_surf,'%5d  PZ %g \n',32,-0.430);
                                          
										  
% given for the definition of the center of the bundle
pitch_x = 72.90054/9;
pitch_y = 46.2534/6;

% starting IDs for automatically generated ID's
surf_ID=40;
cell_ID=40;
cell_ID_start=cell_ID;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
max_row=9;
max_col=6;

% fill bundle layout with fuel bundle
debug_viz=false;
 if debug_viz
    F='empty_bundle';
    for i=1:max_row
        for j=1:max_col
            bundle_type{i,j}=F;
        end
    end
%     bundle_type{1,2}='water_holes';    
%     bundle_type{1,2}='transient_bundle';
%     bundle_type{1,3}='reflector_block';
%     bundle_type{2,1}='detector_block';
%     bundle_type{2,2}='source_block2';
%     bundle_type{1,2}='Lpneumatic_block';
%     bundle_type{1,2}='Spneumatic_block';
     bundle_type{3,2}='bundle_test';
%     bundle_type{3,3}='water_regulating_bundle';
%     bundle_type{4,1}='fuel_bundle';

else
    F='fuel_bundle';
    for i=1:max_row
        for j=1:max_col
            bundle_type{i,j}=F;
        end
    end
    
    
%     % % % put A-raw_long_tube
%     index_i= [ 2 4 6 8 ];
%     index_j= [ 1 1 1 1 ];
%     for ii=1:length(index_i)
%         i=index_i(ii);
%         for jj=1:length(index_j)
%             j=index_j(jj);
%             bundle_type{i,j}='A-raw_long_tube';
%         end
%     end

    % % % put shim_bundle
    index_i= [ 4 4 ];
    index_j= [ 3 5 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='shim_bundle';
        end
    end
    index_i= [ 6 6];
    index_j= [ 3 5];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='shim_bundle';
        end
    end
    
    % % % put water filled rods
    index_i= [4 6];
    index_j= [2 2];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='water_filled_rod_bundle';
        end
    end
    
    % % % put water_regulating_bundle
    index_i= [ 3 ];
    index_j= [ 6 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='water_regulating_bundle';
        end
    end
    % % % put transient_bundle
    index_i= [ 5 ];
    index_j= [ 4 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='transient_bundle';
        end
    end

%     % % % put water_holes
%     index_i= [ 1 3 5 7 9 ]; 
%     index_j= [ 1 1 1 1 1 ];
%     for ii=1:length(index_i)
%         i=index_i(ii);
%         for jj=1:length(index_j)
%             j=index_j(jj);
%             bundle_type{i,j}='water_holes';
%         end
%     end
    index_i= [ 3 7 ]; 
    index_j= [ 4 4 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='water_holes';
        end
    end
    index_i= [ 2 2 ]; 
    index_j= [ 3 5 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='water_holes';
        end
    end

    % % % put reflector blocks
    index_i= [ 1 1 1 1 ];
    index_j= [ 3 4 5 6 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='reflector_block';
        end
    end
    index_i= [ 2 8 9 ];
    index_j= [ 2 2 2 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='reflector_block';
        end
    end
    index_i= [ 8 8 8 ];
    index_j= [ 4 5 6 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='reflector_block';
        end
    end
    index_i= [ 9 ];
    index_j= [ 6 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='reflector_block';
        end
    end
    
    % % % put detectors
    index_i= [ 9 9 9];
    index_j= [ 3 4 5 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='detector_block';
        end
    end
%     
    % % % put the neutron source type 1
    index_i= [ 8 ];
    index_j= [ 3 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='source_block1';
        end
    end
    
    % % % put the large and small pneumatics
    % put the large pneumatic
    index_i= [ 1 ];
    index_j= [ 2 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='Lpneumatic_block';
        end
    end

    % % %  put the small pneumatic
    index_i= [ 2 ];
    index_j= [ 4 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='Spneumatic_block';
        end
    end   
	
	% % %  put the small pneumatic
    index_i= [ 7 ];
    index_j= [ 6 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='special_bundle';
        end
    end
    
    % % % put nothing
    index_i= [ 1 2 3 4 5 6 7 8 9 ];
    index_j= [ 1 1 1 1 1 1 1 1 1 ];
    for ii=1:length(index_i)
        i=index_i(ii);
        for jj=1:length(index_j)
            j=index_j(jj);
            bundle_type{i,j}='empty_block';
        end
    end
%     index_i= [ 3 7 ]; 
%     index_j= [ 4 4 ];
%     for ii=1:length(index_i)
%         i=index_i(ii);
%         for jj=1:length(index_j)
%             j=index_j(jj);
%             bundle_type{i,j}='empty_block';
%         end
%     end
%     index_i= [ 2 2 ]; 
%     index_j= [ 3 5 ];
%     for ii=1:length(index_i)
%         i=index_i(ii);
%         for jj=1:length(index_j)
%             j=index_j(jj);
%             bundle_type{i,j}='empty_block';
%         end
%     end
    
 end

% create each bundle
for i=1:max_row
    for j=1:max_col
        [cell_ID, surf_ID]  = create_bundle((i-0.5)*pitch_x, (j-0.5)*pitch_y, bundle_type{i,j},cell_ID, surf_ID, file_handle_cell, file_handle_surf);
    end
end

% get last cell ID used
cell_ID_end=cell_ID;

% finish box
cell_ID=cell_ID+1; % increment cell ID
water_mat_ID = 5;
water_density = -0.10004;
fprintf(file_handle_cell,'%5d  %g %g %d %d %d %d %d %d \n',cell_ID,water_mat_ID,water_density,1,-2,3,-4,5,-6);
k=0;
for icell=cell_ID_start+1:cell_ID_end
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
% importance 0
cell_ID=cell_ID+1; % increment cell ID
fprintf(file_handle_cell,'%5d  %g %d:%d:%d:%d:%d:%d imp:n=0 \n',cell_ID,0,-1,2,-3,4,-5,6);


fprintf(file_handle_cell,'\n');
fprintf(file_handle_surf,'\n');
fclose(file_handle_cell);
fclose(file_handle_surf);

system('copy cell.txt+surf.txt+data.txt input.inp');
