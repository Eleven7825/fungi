% fun2Wood

function s = fun2Wood(s,Span,E,Sz)
% x and y locations for fungi
[Funloc1, Funloc2] = find(s~=0&~isnan(s));

% death because of no neibering wood
for i = 1:size(Funloc1,1)
    x = Funloc1(i); y = Funloc2(i);
    neighs = [x,y-1;x+1,y;x,y+1;x-1,y]';
    
    % if touch the boundary, continue the process
    if any(neighs(1,:)>Sz(1)|neighs(1,:)<1|neighs(2,:)>Sz(2)|neighs(2,:)<1)
        continue
    end
    
    % if the neigber contains the wood, break
    Con = 0;
    for neigh = neighs
        if isnan(s(neigh(1),neigh(2)))
            Con = 1;
            break
        end
    end
    
    % if no wood contains, die
    if Con == 0
        s(x,y) = NaN;
    end
end

% The death in all in all year group

RanPatch = rand(Sz(1),Sz(2));
t = zeros(Sz(1),Sz(2));
t(Funloc1,Funloc2) = s(Funloc1,Funloc2);
D =  (t./Span).^2.^E;
s(RanPatch<D&D~=0) = NaN;

% The death when the fungi arives the maximum age
s(~isnan(s)&s~=0) = s(~isnan(s)&s~=0)+1;
s(s>=Span) = NaN;
end