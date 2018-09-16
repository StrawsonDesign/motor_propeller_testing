function fig=Import_Plot_experiment(filename)
% Read Data
X=csvread(filename,1,1,[1 1 11 1]); %ESC signal (µs)
T=csvread(filename,1,5,[1 5 11 5]); % Thrust (gf)
V=csvread(filename,1,6,[1 6 11 6]); %Voltage (V)
C=csvread(filename,1,7,[1 7 11 7]); %Current (A)
RPM=csvread(filename,1,8,[1 8 11 8]); %Motor Electrical Speed (RPM)
P=csvread(filename,1,10,[1 10 11 10]); % Electrical Power (W)
E=csvread(filename,1,11,[1 11 11 11]); % Efficiency (gfW)
axis([0 18 1000 2000])
% Plot Thrust
plot(X,T/100)
hold on;
%Plot Voltage
plot(X,V)
hold on;
%Plot current
plot(X,C)
hold on;
%Plot RPM
plot(X,RPM/1000)
hold on;
%Plot power
plot(X,P/10)
hold on;
%Plot efficiency
plot(X,E)
hold on;
xlabel('ESC signals (µs)');
ylabel('Experimental Data');
axis([1000 2000 0 18])
hold off;

end