function q_table = slalom_train(flags)
    q_table=zeros(11,3); %column 1=-vmax, 2=0, 3=vmax
    x=0;
    y=0;
    vx0=0;
    while y~=-10
        
        