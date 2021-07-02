% fun2Wood

function s = fun2WoodMore(s,Span,Es,Sz,r)
% x and y locations for fungi
[Funloc1, Funloc2] = find(s~=0&~isnan(s));

% Calculate the variance of Es
Es = Es(1:find(Es==0,1)-1);
E = Es(end);

if Es>=5
    Var = var(Es(end-4:end));
else
    Var = var(Es);
end
    
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
G = 4.*(Span-t).*exp(E-1).*t./(Span^2);
% D =  (t./Span).^(E./(G.*Var.*(r/2+0.5)+1));
%D =  (t./Span).^(E);
D = 0.00001;

s(RanPatch<D&D~=0) = NaN;

% The death when the fungi arives the maximum age
s(~isnan(s)&s~=0) = s(~isnan(s)&s~=0)+1;
s(s>=Span) = NaN;
end