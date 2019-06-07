data=zeros(9,500);
for i=1:500
    data(1,i)=randi(125);
    data(2,i)=randi(200);
    data(3,i)=randi(125);
    data(4,i)=randi(200);
    data(5,i)=randi(125);
    data(6,i)=randi(200);
    data(7,i)=randi(50);
    data(8,i)=(pi/2)*rand;
    data(9,i)=50+randi(150);
end