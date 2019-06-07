function dy=ode(t,V)
    global ws
    dy=zeros(4,1);
    dy(1)=V(2);
    dy(2)=-0.1*(V(2)-ws);
    dy(3)=V(4);
    dy(4)=-9.8;
end