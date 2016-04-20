function [cell_ID, surf_ID]  = create_bundle(x_bundle_center, y_bundle_center, bundle_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf)

% distances from bundle center to pin centers
delta_x = 2.5;  % CHECK
delta_y = 2.5;  % CHECK

switch bundle_type
    case 'regular_fuel_bundle'
        
        pin_type='regular_fuel';
        
        % north east
        x_center = x_bundle_center + delta_x;
        y_center = y_bundle_center + delta_y;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % north west
        x_center = x_bundle_center - delta_x;
        y_center = y_bundle_center + delta_y;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south west
        x_center = x_bundle_center - delta_x;
        y_center = y_bundle_center - delta_y;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
        % south east
        x_center = x_bundle_center + delta_x;
        y_center = y_bundle_center - delta_y;
        [cell_ID, surf_ID]  = create_pin(x_center, y_center, pin_type, cell_ID, surf_ID, file_handle_cell, file_handle_surf);
        
    otherwise
        error('other bundle types not coded yet');
end