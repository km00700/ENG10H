function animate_system(mf_coords,ast_coords)
[img, map, alphachannel] = imread('mf.png');
ast_x = ast_coords(:,1);
ast_y = ast_coords(:,2);
ast_radii = ast_coords(:,3);
figure
set(gca,'Color','black')
axis([0 20 0 20])
axis square
hold on
for k = 1:length(ast_coords)
    pos = [ast_x(k)-ast_radii(k), ast_y(k)-ast_radii(k), ...
        2*ast_radii(k), 2*ast_radii(k)];
    rectangle('Position',pos, 'Curvature',1,'FaceColor',[.5 .5 .5]);
end

[tsteps,dims]=size(mf_coords);
for k = 1:tsteps
    pos_curr = mf_coords(k,:);
    if(k>1)
        delete(h)
    end
    h = imagesc([pos_curr(1)-.5 pos_curr(1)+.5],[pos_curr(2)+.5 pos_curr(2)-.5],img,'AlphaData',alphachannel);
    pause(0.5);
end