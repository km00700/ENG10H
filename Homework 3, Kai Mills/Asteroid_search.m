starting_position = [18, 0];
maximum_search_depth = 10;
maximum_movement_distance = 4;
asteroid_field = load('asteroids.mat');
asteroid_field = asteroid_field.ast_coords;

path = starting_position;

for(i = 1:5)
   [route, depth] = find_path(starting_position, maximum_search_depth, asteroid_field);
   path = [path; route(2:maximum_movement_distance + 1,:)];
   starting_position = route(maximum_movement_distance + 1,:);
end

disp(path);

animate_system(path, asteroid_field);