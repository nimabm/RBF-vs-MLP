% Solve an Input-Output Fitting problem with a Neural Network
close all;clear;clc;

%% Set inputs range
xmin = 0;
xmax = 2*pi;

%% without noise
nsample = 20;
x = linspace(xmin,xmax,nsample);
y = sin(x);

% %% with noise
% x1 = linspace(xmin,xmax,nsample);
% y1 = sin(x1);   % model;
% 
% x = [x1,x1,x1,x1,x1,x1];
% % x = x1;
% x = x +  randn(size(x))*.1;
% y = sin(x) + randn(size(x))*.1;
% plot(x1,y1,'r','linewidth',3),hold on,plot(x,y,'.')
% legend('Model','Noisy data')

%% Input & Target
inputs = x;
targets = y;

%% Create a Fitting Network
hiddenLayerSize = 5;
net = fitnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% network training function
% net.trainFcn = 'trainlm';  % Levenberg-Marquardt
net.trainFcn = 'trainbr';  % Bayesian Regularization

% Train the Network
net = train(net,inputs,targets);
view(net)

%% Test MLP Network
xtest = linspace(xmin,xmax,17);
ytest = sin(xtest);
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

