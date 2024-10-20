function [s,v] = vcurve(nump,acc_pct,method)

if strcmpi(method,'poly3')
    a = -2./acc_pct.^3;
    b = 3./acc_pct.^2;
    t = linspace(0,1,nump);
    va = a(1)*t.^3+b(1)*t.^2; va(t>acc_pct(1)) = 0;
    vb = ones(1,nump); vb(t<=acc_pct(1) | t>=1-acc_pct(2)) = 0;
    vc = a(2)*(-t+1).^3+b(2)*(-t+1).^2; vc(t<1-acc_pct(2)) = 0;
    v = va+vb+vc;
s = cumsum(v)/sum(v);
elseif strcmpi(method,'sine')
    t = linspace(0,1,nump);
    va = -cos(pi/acc_pct(1)*t)/2+1/2; va(t>acc_pct(1)) = 0;
    vb = ones(1,nump); vb(t<=acc_pct(1) | t>=1-acc_pct(2)) = 0;
    vc = -cos(-pi/acc_pct(2)*(t-1))/2+1/2; vc(t<1-acc_pct(2)) = 0;
        v = va+vb+vc;
s = cumsum(v)/sum(v);
elseif strcmpi(method,'const')
    v = ones(1,nump); 
    s = linspace(0,1,nump);
else
    error('Method Error')
end

end