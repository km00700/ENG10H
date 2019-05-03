function f = check_collision(position, asteroid_field);
    f = 0;
    ast_x = asteroid_field(:,1);
    ast_y = asteroid_field(:,2);
    ast_rad = asteroid_field(:,3);
    for k = 1:length(asteroid_field)
        if(norm(position-[ast_x(k), ast_y(k)]) < (0.5 + ast_rad(k)))
            f = 1;
            return;
        end
    end
end