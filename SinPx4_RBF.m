close all;clear;clc;

%% Set inputs range
xmin = 0;
xmax = 8;

%% without noise
x = linspace(xmin,xmax,20);
y = sin(pi/4 * x);

%% with noise
x1 = linspace(xmin,xmax,20);
y1 = sin(pi/4 *x1);   % model;

x = [x1,x1,x1,x1,x1,x1];
% x = x1;
x = x +  randn(size(x))*.1;
y = sin(pi/4 *x) + randn(size(x))*.1;
plot(x1,y1,'r','linewidth',3),hold on,plot(x,y,'.')
legend('Model','Noisy data')

%% Input & Target
inputs = x;
targets = y;

%% Create a RBF Network
goal = 0.000;   % Mean squared error goal (default = 0.0)
spread  =  3;   % Spread of radial basis functions (default = 1.0)
MN = 10;         % Maximum number of neurons 
DF = 10;        % Number of neurons to add between displays (default = 25)
net  = newrb(inputs,targets,goal,spread,MN,DF);
view(net)

%% Test RBF Network
xtest = linspace(xmin,xmax,17);
ytest = sin(pi/4 * xtest);
output = net(xtest);

%% Compute error
mse_err = mse(ytest,output);
fprintf('Mean Squared Error of test data is %.4f \n',mse_err)
sse_err = sse(ytest,output);
fprintf('Sum of Squared Error of test data is %.4f \n',sse_err)

%% Plot result
figure
plot(xtest,ytest,'-*r');hold on;
plot(xtest,output,'--+');
xlim([xmin,xmax])
legend('Target','Output')
