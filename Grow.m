function s = Grow(s,Span,E,Sz)
% x and y locations for fungi
[Funloc1, Funloc2] = find(s~=0&~isnan(s));

% The death in all in all year group

Ran = rand(Sz(1),Sz(2));
RanPatch = Ran(Sz(1),Sz(2));
t = zeros(Sz(1),Sz(2));
t(Funloc1,Funloc2) = s(Funloc1,Funloc2);
%G = 4.*(Span-exp(E-1).*t).*exp(E-1).*t./(Span^2);
G = 4.*(Span-t).*exp(E-1).*t./(Span^2);
[Gcellsx,Gcellsy] = find(G>RanPatch);

for i = 1:size(Gcellsx,1)
    x = Gcellsx(i); y = Gcellsy(i);
    neighs = [x,y-1;x+1,y-1;x+1,y;x+1,y+1;x,y+1;x-1,y+1;x-1,y;x-1,y-1]';
    del = randi(8);
    del0 = del;
    
    if any(neighs(1,:)>Sz(1)|neighs(1,:)<1|neighs(2,:)>Sz(2)|neighs(2,:)<1)
        continue
    end
    b = 0;
    
    while s(neighs(1,del),neighs(2,del))~=0
        
        if del<8
            if del == del0
                b = 1;
            end
            del = del+1;
            if del == del0
                b = 1;
            end
        end
        
        if b== 1
            break
        end
        
        if del ==8
            del =1;
        end
    end
    
    m = neighs(1,del); n = neighs(2,del);
    Neighs = [m,n-1;m+1,n-1;m+1,n;m+1,n+1;m,n+1;m-1,n+1;m-1,n;m-1,n-1]';
    WooNum = 0;
    for Neigh = Neighs 
        if isempty(Neighs); break; end
        if Neigh(1)> Sz(1) || Neigh(1)<0 || Neigh(2)<0||Neigh(1)>Sz(2)
            break;
        end
        if isnan(s(Neigh(1),Neigh(2))); WooNum = WooNum+1;end
    end
    
    if WooNum >3
        s(neighs(1,del),neighs(2,del)) = 1;
    end
end
end
