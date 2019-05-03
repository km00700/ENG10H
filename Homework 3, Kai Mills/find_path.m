function [positions, depth, counter] = find_path(position, max_tree_depth, ast_coords)
    %Returns current position and previous depth if Millenium Falcon is 
    %colliding with an asteroid.
    if(check_collision(position, ast_coords) >= 1) 
        positions = position;
        depth = position(2) - 1;
        counter = 1;
    %Returns current position and current depth if Millenium Falcon has
    %reached the maximum search depth.
    elseif(max_tree_depth <= 0)
        positions = position;
        depth = position(2);
        counter = 1;
    %Returns the postions from the recursive search for the largest depth.
    else
        left_path_length = -1;
        right_path_length = -1;
        center_path_length = 0;
        
        left_count = 0;
        right_count = 0;
        
        [center_path, center_depth, center_count] = find_path(position + [0, 1], max_tree_depth - 1, ast_coords);
        center_path_length = center_depth;
       
        if(position(1) > 0)
            [left_path, left_depth, left_count] = find_path(position + [-1, 1], max_tree_depth - 1, ast_coords);
            left_path_length = left_depth;
        end
        
        if(position(1) < 20)
            [right_path, right_depth, right_count] = find_path(position + [1, 1], max_tree_depth - 1, ast_coords);
            right_path_length = right_depth;
        end
        
        longest_path = center_path; 
        longest_depth = center_depth;
        if(right_path_length > center_path_length)
            longest_path = right_path;
            longest_depth = right_depth;
        end
        if(left_path_length > center_path_length & left_path_length > right_path_length)
            longest_path = left_path;
            longest_depth = left_depth;
        end
        
        positions = [position; longest_path];
        depth = longest_depth;
        counter = left_count + right_count + center_count;
    end
end