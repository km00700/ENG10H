data=zeros(10,500);
for i=1:500
    data(1,i)=randi(125); %x for sphere1
    data(2,i)=randi(200); %y for sphere1
    data(3,i)=randi(125); %x for sphere2
    data(4,i)=randi(200); %y for sphere2
    data(5,i)=randi(125); %x for sphere3
    data(6,i)=randi(200); %y for sphere3
    data(7,i)=randi(50); %v initial
    data(8,i)=(pi/2)*rand; %angle
    data(9,i)=50+randi(150); %target x
    data(10,i)=randi([-10, 10]); %wind speed
end