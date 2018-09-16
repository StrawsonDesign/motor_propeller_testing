function [E150,Emax,Emin]=Import_Plot_csv(filename)
% Read Data

T=csvread(filename,1,5,[1 5 11 5]); % Thrust (gf)
E=csvread(filename,1,11,[1 11 11 11]); % Efficiency (gfW)

% Plot Data
plot(T,E)
xlabel('Thrust (gf)');
ylabel('Efficiency (gfW)');
hold on;

% Find Highest Efficiency @ 150 gf
k=find(abs(T-150)<30,2,'last');
if length(k)<2 % if we cannot find 2 close points
    k=find(abs(T-150)<50,2,'last');
    if length(k)<2 % if we still cannot find 2 close points
        disp('Jesus')
        disp(filename)
    end
end
if k(1)>150 % if 150 is bounded
    disp('sth is wrong')
    disp(filename)
else
    E150=E(k(1))+(150-T(k(1)))*(E(k(2))-E(k(1)))/(T(k(2))-T(k(1))); % Efficiency @ 150 gf by interpolation
end
Emax=max(E); % Max Efficiency
Emin=min(E); % Min Efficiency
end