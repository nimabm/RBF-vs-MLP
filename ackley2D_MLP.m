% Solve an Input-Output Fitting problem with a Neural Network
close all;clear;clc;

%% Create and show Ackley function
R = [-2,2];
n = 41;
[X,Y,Z] = ackley2D(R,R,n);
 mesh(X,Y,Z)

%% Covert 2D data to 1D
x = X(:);
y = Y(:);
z = Z(:);

%% Input & Target
inputs = [x,y]';
targets = z';

%% Create a Fitting Network
hiddenLayerSize = [10,12];
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
% view(net)

%% Test MLP Network
R = [-2,2];
d = 7;
[Xtest,Ytest,Ztest] = ackley2D(R,R,d);
% figure,mesh(Xtest,Ytest,Ztest)

xtest = [Xtest(:),Ytest(:)]';
ytest = Ztest(:)';
output = net(xtest);

%% Compute error
mse_err = mse(ytest,output);
fprintf('Mean Squared Error of test data is %.4f \n',mse_err)
sse_err = sse(ytest,output);
fprintf('Sum of Squared Error of test data is %.4f \n',sse_err)

%% Plot result
figure
plot3(xtest(1,:),xtest(2,:),ytest,'-*r');hold on;
plot3(xtest(1,:),xtest(2,:),output,'--+');
legend('Target','Output')

figure
plot(ytest,'-*r'),hold on,plot(output,'--+')
legend('Target','Output')
