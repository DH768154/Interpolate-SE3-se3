function T_path = interpSE3(T0,T1,s_path,type)
% 
% T0,T1: Initial, Goal
% s_path: steps, from 0 to 1
% type: linear or screw motion
%

%% Linear
if strcmpi(type,'linear')
    [dp,dw,mag] = diffSE3(T1,T0,'world'); % Distance from T0 to T1
    udw = dw/mag(2); % axis vector of axis-angle
    theta = mag(2)*s_path; % angle of axis-angle
    dws = udw*theta; % axis-angle of n axis-angle
    dR = ExpRot2(dws);
    R_path = pagemtimes(dR,T0(1:3,1:3));
    P_path = T0(1:3,4) + s_path.*dp;
    T_path = R2T(R_path,P_path);

%% Screw
elseif strcmpi(type,'screw')
    T01 = HomInv(T0) * T1; % Difference
    [W,V,mag] = ExpHomInv(T01); % SE3 to se3
    uXi = [V;W]; % unit screw
    theta = mag*s_path;
    T_path = pagemtimes(T0,ExpHom2(uXi*theta)); % Screw Motion Path
end

end