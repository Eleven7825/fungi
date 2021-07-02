% initializer
function s = initializer(Sz,Wood,Fun)
s = zeros(Sz(1), Sz(2));

% placing the wood
mid = round(Sz(2)/2);
s(Sz(1)-Wood(1):end,mid-Wood(2):mid+Wood(2)) = NaN;

% placing the fungi
s(Sz(1)-Wood(1)-Fun(1):Sz(1)-Wood(1)-1, mid-Fun(2):mid+Fun(2)) = 1;
end