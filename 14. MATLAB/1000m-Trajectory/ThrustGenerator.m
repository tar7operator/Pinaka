% Define the size of the matrix
rows = 48;
cols = 1;
t = 0:4/49:4;

% Define the desired mean
desired_mean = 650;

% Generate a matrix of random numbers
A = 185* randn(rows, cols) + 550;

T = zeros(1,50);
T(2:49) = A;
T = T';

K = [t', T];

mean(T)
writematrix(K, "MotorDataPrepared.xlsx")