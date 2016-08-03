
function [cell_ID, surf_ID]  = create_bundle(x_bundle_center, y_bundle_center, bundle_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf)

% distances from bundle center to pin centers
L_block =46.2534/6; % dimension of a single bundle, treated as a square
delta =  L_block/4;  % is 1/4 length of the block

switch bundle_type
    
	case 'bundle_test'
		
       pin_type='fuel_control_rod';
       % north west: pin 1
       x_center = x_bundle_center - delta;
       y_center = y_bundle_center + delta;
       [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
       
	
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
        
        % south east: pin 3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south west: pin 4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        pin_type='fuel_control_rod';
        % north east: pin 2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
    case 'water_regulating_bundle'
        
        pin_type='regulating_rod';
        % north west: pin 1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
         
        pin_type='regular_fuel_rod';
        % south west: pin 4
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
        
        % south west: pin 4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        pin_type='transient_rod';
        % south east: pin 3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
   
    case 'half_bundle'
        
        pin_type='regular_fuel_rod';
        % north west:1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % north east:2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
	
	case 'water_filled_rod_bundle'
        
        pin_type='water-followed_rod';
        % south east: pin 3
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south west: pin 4
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center - delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);   
        
        pin_type='regular_fuel_rod';
        % north west: pin 1
        x_center = x_bundle_center - delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        % north east: pin 2
        x_center = x_bundle_center + delta;
        y_center = y_bundle_center + delta;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
       
   
    case 'water_holes'
        pin_type='water2';
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

    case 'empty_block'
          pin_type='empty';
          % water 
          x_center = x_bundle_center;
          y_center = y_bundle_center;
          [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
     
    case 'source_block'
          pin_type='source1';
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
   

      otherwise
          error('other bundle types not coded yet');
end 
