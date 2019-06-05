load q_table.mat
vmax=2; %note: this value also appears in all three files
x0=0;
y0=0;
vx0=0;
xvals=[];
yvals=[];
t=0;
while y0>=-10 && abs(x0)<=2.5
    choice=max(q_table(abs(round(y0))+1,:)); 
    if choice==q_table(abs(round(y0))+1,1) %vx=-vmax
        vx=-vmax;
        [x y]=slalom(vx0, vx, vx0, y0)
        
                elseif choice==q_table(abs(round(y0))+1,3) %vx=vmax
                    vx=vmax;
                    [x, y]=slalom(vx0, vx, x0, y0);
                    if abs(x(11,1))>2.5 %assigning rewards
                        q_table(abs(round(y0))+1,3)=(1-alpha)*q_table(abs(round(y0))+1,3)+alpha*rbounds;
                    else
                        for i=1:length(flags)
                            for j=1:11
                                if (flags(i,1)-0.5)<x(j,1) && x(j,1)<(flags(i,1)+0.5)
                                    if (flags(i,2)-0.5)<y(j,1) && y(j,1)<(flags(i,2)+0.5)
                                        yval=y(11,1);
                                        if yval<-10
                                            yval=-10;
                                        end
                                        q_table(abs(round(y0))+1,3)=(1-alpha)*q_table(abs(round(y0))+1,3)+alpha*(rgate+gamma*max(q_table(abs(round(yval))+1,:)));
                                        br=true;
                                        break
                                    end
                                end
                            end
                            if br==true
                                break;
                            end
                        end
                        if br==false
                            yval=y(11,1);
                            if yval<-10
                                yval=-10;
                            end
                            q_table(abs(round(y0))+1,3)=(1-alpha)*q_table(abs(round(y0))+1,3)+alpha*(gamma*max(q_table(abs(round(yval))+1,:)));
                        elseif br==true
                            br=false;
                        end
                    end
                end
                vx0=vx; %update vx0, x0, and y0
                x0=x(11,1);
                y0=y(11,1);
            end