% clear
load fitresult

% calculate F G D
Span = 100;
Wood = [50 100];
% 100 75
Sz = [60 250];
MaxT = 300; 
s = initializer(Sz,Wood,Fun);
WoodNum = zeros(1,MaxT);
FunNum = zeros(1,MaxT);
if ~exist('T','var'); T = 25; end
% if ~exist('mois','var'); mois = 0.97; end
if ~exist('ph','var'); ph = 5; end
if ~exist('I','var'); I = 0.8; end
f2.c1 = f2.c1+0.5;
for t =  1: MaxT
   mois = 0.9+0.14*sin((1/pi)*t);
    % wood number and fun numbers
    WoodNum(t) = nnz(isnan(s));
    FunNum(t) = nnz(s>0);
    
    % condition at this moment
    E = (f3(T)*f2(mois)*f1(ph)*I)^(1/4);
    F = E;
    
    % Considering some fungi dies
    s = fun2Wood(s,Span,E,Sz);
   
    
    % Cell moves due to gravity reason
     s = puller(s,Sz);
  
    % Some wood becomes air
    s = woodDecomposer(s,F,Sz);

    % Some fungi grows out
    s = Grow(s,Span,E,Sz);
    
    if ismember(t, 1:100:1000)
        disp(t);
    end
    
    spy(isnan(s),'r')
    hold on
    tf = s~=0&~isnan(s);
    spy(tf,'g')
    title(t)
    hold off
    drawnow
    if ismember(t, [300])
        saveas(gcf,['Single_flua_mois',num2str(t),'.eps'],'epsc');
    end
    
end