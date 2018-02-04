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

%% Create a RBF Network
goal = 0.000; %Mean squared error goal (default = 0.0)
spread = 1;  % Spread of radial basis functions (default = 1.0)
MN = 250; %Maximum number of neurons 
DF = 50;    %Number of neurons to add between displays (default = 25)
net = newrb(inputs,targets,goal,spread,MN,DF);
view(net)

%% Test RBF Network
R = [-2,2];
d = 7;
[Xtest,Ytest,Ztest] = ackley2D(R,R,d);
figure,mesh(Xtest,Ytest,Ztest)

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



   