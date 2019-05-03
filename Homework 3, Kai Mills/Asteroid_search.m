starting_position = [10, 0];
course_depth = 20;
maximum_search_depth = 9;
maximum_movement_distance = 4;
asteroid_field = load('asteroids.mat');
asteroid_field = asteroid_field.ast_coords;

path = starting_position;

for(i = 1:ceil(course_depth/maximum_movement_distance))
   route = find_path(starting_position, maximum_search_depth, asteroid_field);
   path = [path; route(2:maximum_movement_distance + 1,:)];
   starting_position = route(maximum_movement_distance + 1,:);
end
path = path(1: course_depth + 1, :);
disp(path);
animate_system(path, asteroid_field);