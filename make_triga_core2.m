clear all; close all; clc;

file_handle_cell=fopen('cell.txt','w+');
fprintf(file_handle_cell,'TESTING TRIGA CORE\n');
file_handle_surf=fopen('surf.txt','w+');

% file_handle_data=fopen('data.txt','r');

% create the surfaces to define the core 
fprintf(file_handle_surf,'%5d  PZ %g \n',1,-40.0);
fprintf(file_handle_surf,'%5d  PZ %g \n',2,40.0);
fprintf(file_handle_surf,'%5d  PX %g \n',3,0);
fprintf(file_handle_surf,'%5d  PX %g \n',4,72.90054); 
fprintf(file_handle_surf,'%5d  PY %g \n',5,0);
fprintf(file_handle_surf,'%5d  PY %g \n',6,46.2534); 
% define plans PZ =0 and intermediates plans PZ to create pins
fprintf(file_handle_surf,'%5d  PZ %g \n',7,-17.78); 
fprintf(file_handle_surf,'%5d  PZ %g \n',8,17.78);
fprintf(file_handle_surf,'%5d  PZ %g \n',9,0); 

% given for the definition of the center of the bundle
pitch_x = 72.90054/9; 
pitch_y = 46.2534/6;

% starting IDs for automatically generated ID's
surf_ID=20;
cell_ID=20;
cell_ID_start=cell_ID;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_center=4.5; y_center=3.85445; 
max_row=9;
max_col=6;
for i=1:max_row
    for j=1:max_col
        VX=[4 6];
        VY=[3 5]
        if i==VX
            if i==VY
                bundle_type{i,j}='shim_bundle';
            else 
                bundle_type{i,j}='fuel_bundle';
            end
        else
            bundle_type{i,j}='fuel_bundle';
        end
        if i~=VX & j~=VY
            bundle_type{i,j}='fuel_bundle';
        end
    end
end


for i=1:max_row
     for j=1:max_col
        [cell_ID, surf_ID]  = create_bundle((i-0.5)*pitch_x, (j-0.5)*pitch_y, bundle_type{i,j}, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
     end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get last cell ID used
cell_ID_end=cell_ID;

% finish box
cell_ID=cell_ID+1; % increment cell ID
water_mat_ID = 5;
water_density = -0.10004;
fprintf(file_handle_cell,'%5d  %g %g %d %d %d  %d %d %d\n',cell_ID,water_mat_ID,water_density,1,-2,3,-4,5,-6);
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
    fprintf(file_handle_cell,'     imp:n=1\n');
else
    fprintf(file_handle_cell,'imp:n=1\n');
end
% importance 0
cell_ID=cell_ID+1; % increment cell ID
fprintf(file_handle_cell,'%5d  %g %d:%d:%d:%d:%d:%d imp:n=0\n',cell_ID,0,-1,2,-3,4,-5,6);


fprintf(file_handle_cell,'\n');
fprintf(file_handle_surf,'\n');
fclose(file_handle_cell);
fclose(file_handle_surf);

system('copy cell.txt+surf.txt+data.txt input.inp')
