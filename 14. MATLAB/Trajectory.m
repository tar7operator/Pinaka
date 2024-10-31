clc; close all; clear ;

% File Data
y = readmatrix('motorData.xlsx'); % Load data from Excel file

tth = y(:,3); % Timing of thrust
th = y(:,1);  % Thrust values
mm = y(:,2);  % Motor mass values

% Initial Data
dt = 0.01;     % Step size for time
t = 0:dt:75;  % Time array (from 0 to 75 seconds)

mr = 8912;    % Rocket dry mass (g)
mmc = 1655;   % Motor casing mass (g)
g = 9.81;     % Gravitational acceleration (m/s^2)

% Interpolation
tc = interp1(tth, th, t);    % Thrust interpolation
tc(isnan(tc)) = 0;           % Set NaN thrust values to 0

mc = interp1(tth, mm, t);    % Mass interpolation
mc(isnan(mc)) = 0;           % Set NaN mass values to 0

mass=(mc + mmc + mr) ./ 1000;  % Total mass in kg (converted from g)

velocity = zeros(size(t)); % Initial velocity (0 m/s)
altitude = zeros(size(t)); % Initial altitude (0 m)
acc = zeros(size(t));
i=1;

rho = 

df = @(v) 0.5 * rho * v^2 * Area * Cd
% df = @(v) 0.0040986 * v^2;

while 1

    An= @(v) (tc(i) - df(v) - mass(i)*g)/mass(i);
    acc(i+1) = An(velocity(i));
    % RK4 coefficients
    k1 = dt * An(velocity(i));
    k2 = dt * An(velocity(i) + 0.5*k1);
    k3 = dt * An(velocity(i) + 0.5*k2);
    k4 = dt * An(velocity(i) + k3);

    vn = velocity(i) + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    an = altitude(i) + velocity(i)*dt;

    if an < altitude(i) && vn <= 0 && acc(i) > acc(i-1) && t(i) > max(tth)
    break;
    end

    velocity(i+1) = vn;
    altitude(i+1) = an;
    
    % fprintf("(%f) Net Altitude: %f Net Velocity: %f Net Acceleration: %f \n", i, altitude(i), velocity(i),  An(velocity(i)) );
    i=i+1;
end
% fprintf("--------------------------------\n");
ApT = i-1;
while 1

    An= @(v) (df(v) - mass(i)*g)/mass(i);

    acc(i+1) = An(velocity(i));
    
    % RK4 coefficients
    k1 = dt * An(velocity(i));
    k2 = dt * An(velocity(i) + 0.5*k1);
    k3 = dt * An(velocity(i) + 0.5*k2);
    k4 = dt * An(velocity(i) + k3);

    vn = velocity(i) + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    an = altitude(i) + velocity(i)*dt;

    
    if velocity(i) < 0 && altitude(i) < 0
        break;
    end

    velocity(i+1) = vn;
    altitude(i+1) = an;

    % fprintf("(%f) Net Altitude: %f Net Velocity: %f Net Acceleration: %f \n", i, altitude(i), velocity(i),  An(velocity(i)) );
    
    i=i+1;
end

% Plot results
figure;
subplot(2, 1, 1);
plot(t(1:i),altitude(1:i));
xlabel('Time (s)');
ylabel('Altitude (m)');
title('Altitude');
yline(altitude(ApT),'-r',{'Apogee', altitude(ApT)});
grid on;

subplot(2, 1, 2);
plot(t(1:i),velocity(1:i));
xlabel('Time (s)');
ylabel('Vertical Velocity (m/s)');
title('Vertical Velocity');
grid on;