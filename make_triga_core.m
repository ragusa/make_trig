clear all; close all; clc;

file_handle_cell=fopen('cell.txt','w+');
fprintf(file_handle_cell,'TESTING TRIGA CORE\n');
file_handle_surf=fopen('surf.txt','w+');

% file_handle_data=fopen('data.txt','r');

% create x/y/z min/max surfaces
% 1/2: z min/max
% 3/4: x min/max
% 5/6: y min/max
% 7/8: z intermediate boundaries 
% 9  : z origin
fprintf(file_handle_surf,'%5d  PZ %g \n',1,-40.0);
fprintf(file_handle_surf,'%5d  PZ %g \n',2,40.0);
fprintf(file_handle_surf,'%5d  PX %g \n',3,-36.45027);
fprintf(file_handle_surf,'%5d  PX %g \n',4,36.45027); 
fprintf(file_handle_surf,'%5d  PY %g \n',5,-26.98115);
fprintf(file_handle_surf,'%5d  PY %g \n',6,19.27225); 
fprintf(file_handle_surf,'%5d  PZ %g \n',7,-17.78); 
fprintf(file_handle_surf,'%5d  PZ %g \n',8,17.78);
fprintf(file_handle_surf,'%5d  PZ %g \n',9,0); 

pitch_x=10;
pitch_y=10;

% starting IDs for automatically generated ID's
surf_ID=20;
cell_ID=20;
cell_ID_start=cell_ID;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_center=4.5; y_center=3.85445; 
max_row=6;
max_col=9;
for i=1:max_col
    for j=1:max_row
        bundle_type{i,j}='fuel_bundle';
    end
end

for i=1:max_col
%     for j=1:max_row
        [cell_ID, surf_ID]  = create_bundle((i-0.5)*pitch_x, (j-0.5)*pitch_y, bundle_type{i,j}, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%



% get last cell ID used
cell_ID_end=cell_ID;

% finish box
cell_ID=cell_ID+1; % increment cell ID
water_mat_ID = 4;
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

