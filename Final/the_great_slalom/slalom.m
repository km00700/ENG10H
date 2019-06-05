function derivative=slalom(t,V) %V is column vector with x0, vx0, y0, vy0
    global ax ay
    derivative=[V(2,1); ax; V(4,1); ay];
end