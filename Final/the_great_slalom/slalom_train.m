function q_table = slalom_train(flags)

vmax=1.65; %APPEARS IN SLALOM_RUN
yfinal=-25; %APPEARS IN SLALOM_RUN

direct_steps=(abs(yfinal)/vmax);
q_table_length=5 * (abs(yfinal) + 1);
q_table=zeros(q_table_length,3); %rows 1-5: y=0, rows 6-10: y=-1, etc
epsilon=1;
beta=0.999;
gamma=0.8;
alpha=0.5;
rstep=-1.0/(abs(yfinal)^2/vmax);
rbounds=-15000;
rgate=5*direct_steps*rstep/length(flags);
rend=direct_steps*150*vmax;

br=false;
global ax ay
for trials=1:(5*abs(yfinal)^2)
    x0=0;
    y0=0;
    vx0=0;
    vy0=-(vmax^2-vx0^2)^(0.5);
    exploration=rand;
    while y0>=yfinal && abs(x0)<=2.5
        if exploration<epsilon %exploration case
            choice=randi(3);
            if choice==1
                vx=-vmax;
            elseif choice==2
                vx=0;
            elseif choice==3
                vx=vmax;
            end
        else %exploitation case
            index=(round(x0)+3)-5*round(y0);
            choice=max(q_table(index, :));
            if choice==q_table(index,1)
                choice=1;
                vx=-vmax;
            elseif choice==q_table(index,2)
                choice=2;
                vx=0;
            elseif choice==q_table(index,3)
                choice=3;
                vx=vmax;
            end
            %center-biasing
            if(q_table(index, 1)==q_table(index, 2)&&q_table(index, 2)==q_table(index, 3))
                choice=2;
                vx=0;
            end
        end
        if round(vx)==-round(vx0)
            vx=0;
            choice=2;
        end
        
        vy=-((vmax^2-vx^2)^(0.5));
        ax=vx-vx0;
        ay=vy-vy0;
        initial=[x0;vx0;y0;vy0];
        tspan=[0:1];
        [t, vals]=ode23(@slalom, tspan, initial);
        x=vals(:,1);
        vx=vals(:,2);
        y=vals(:,3);
        index=min(55,(round(x0)+3)-5*round(y0));
        if abs(x(11,1))>2.5 %assigning rewards
            q_table(index,choice)=(1-alpha)*q_table(index,choice)+alpha*rbounds;
        elseif y(11,1)<=yfinal
            q_table(index,choice)=(1-alpha)*q_table(index,choice)+alpha*rend;
        else
            for i=1:length(flags)
                for j=1:11
                    if (flags(i,1)-0.5)<x(j,1) && x(j,1)<(flags(i,1)+0.5)
                        if (flags(i,2)-0.5)<y(j,1) && y(j,1)<(flags(i,2)+0.5)
                            yval=y(11,1);
                            if yval<yfinal
                                yval=yfinal;
                            end
                            xval=x(11,1);
                            index2=round(round(xval)+3-5*round(yval));
                            q_table(index,choice)=(1-alpha)*q_table(index,choice)+alpha*(rgate+gamma*max(q_table(index2,:)));
                            br=true;
                            break
                        end
                    end
                end
                if br==true
                    break;
                end
            end
            yval=y(11,1);
            if yval<yfinal
                yval=yfinal;
            end
            xval=x(11,1);
            index2=round(xval)+3-5*round(yval);
            q_table(index,choice)=(1-alpha)*q_table(index,choice)+alpha*(rstep+gamma*max(q_table(index2,:)));
            if br==false
                %{
                yval=y(11,1);
                if yval<yfinal
                    yval=yfinal;
                end
                xval=x(11,1);
                index2=round(xval)+3-5*round(yval);
                q_table(index,choice)=(1-alpha)*q_table(index,choice)+alpha*(rstep+gamma*max(q_table(index2,:)));
                %}
            elseif br==true
                br=false;
            end
        end
        vx0=vx(11,1);
        x0=x(11,1);
        y0=y(11,1);
        vy0=-(vmax^2-vx0^2)^(0.5);
    end
    epsilon=epsilon*beta;
end
save('q_values', 'q_table','flags')