% puller
% consider the movement of the cell due to the gravity
function s = puller(s,Sz)
% x and y locations for fungi
[Funloc1, Funloc2] = find(s~=0&~isnan(s));

for i = 1:length(Funloc1)
    x = Funloc1(i);
    y = Funloc2(i);
    neighs = [x,y-1;x+1,y-1;x+1,y;x+1,y+1;x,y+1]';
    Hang = 0;
    
    for neigh = neighs
        if (neigh(2)>Sz(2))||(neigh(2)<1)||(neigh(1)>Sz(1))||(neigh(1)<1)
            break       
        end
        
        if s(neigh(1),neigh(2))==0 || isnan(neigh(1)) || isnan(neigh(2))
            Hang = Hang +1;
        end
    end
    
    if Hang >2 && s(x+1,y) == 0   
        s(x+1,y)=s(x,y);     
        s(x,y) = 0;
    end
end
end