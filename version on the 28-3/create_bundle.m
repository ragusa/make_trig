function [cell_ID, surf_ID]  = create_bundle(x_bundle_center, y_bundle_center, bundle_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf)

% distances from bundle center to pin centers
delta =  1.9272;  % is L_block/2
%%delta = 1.9272; leng_bundle/4=7.7089/4
L_block = 3.8544; % block is a square 
z_block = 40;

% z-plane surf ID
z_min        = 1;
z_max        = 2;

fprintf('bundle_type %s \n',bundle_type)

switch bundle_type
    
    case 'empty_bundle'
        % do not put anything (for debugging)
        
    case 'fuel_bundle'
        
        pin_type='regular_fuel_rod';
        % north west:1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % north east:2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south east:3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
                 
        % south west:4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        
    case 'shim_bundle'
      
        pin_type='regular_fuel_rod';
        % north west: pin 1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % north east: pin 2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south east: pin 3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        pin_type='fuel-followed_control_rod';
        % south west: pin 4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
       
        
    case 'water_regulating_bundle'
        
        pin_type='water-followed_control_rod';
        % north west: pin 1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        pin_type='regular_fuel_rod';
        % north east: pin 2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south east: pin 3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south west: pin 4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
          
    case 'transient_bundle'
        
        pin_type='regular_fuel_rod';
        % north west: pin 1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % north east: pin 2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south east: pin 3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        pin_type='air-followed_transient_rod';
        % south west: pin 4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
         
    case 'water_holes'
        pin_type='water';
        % hole
        x_center = x_bundle_center;
        y_center = y_bundle_center;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
       
    case 'reflector_block'
          pin_type='reflector';
          % graphite block
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);

     case 'source_block'
          pin_type='source';
          % neutron source
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
          
       
     case 'detector_block'
          pin_type='detector';
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
         
      case 'Lpneumatic_block'
          pin_type='large_pneumatic';
          % large pneumatic
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
     
      case 'Spneumatic_block'
          pin_type='small_pneumatic';
          % small pneumatic
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
          
    case 'A-raw_long_tube'
          pin_type='A-raw';
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
   
%     case 'D-raw_long_tube'
%           pin_type='D-raw';
%           x_center = x_bundle_center;
%           y_center = y_bundle_center;
%           [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);        
        
      otherwise
          error('other bundle types not coded yet');
end 
