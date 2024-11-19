clc; close all; clear ;

% File Data
y = readmatrix('MotorDataPrepared.xlsx'); % Load data from Excel file

tth = y(:,1); % Timing of thrust
th = y(:,2);  % Thrust values
mm = y(:,3);  % Motor mass values

% Initial Data
dt = 0.01;     % Step size for time
t = 0:dt:120;  % Time array (from 0 to 75 seconds)

mr = 8912;    % Rocket dry mass (g)
mmc = 1400;   % Motor casing mass (g)
g = 9.81;     % Gravitational acceleration (m/s^2)

% Interpolation
tc = interp1(tth, th, t);    % Thrust interpolation
tc(isnan(tc)) = 0;           % Set NaN thrust values to 0

mc = interp1(tth, mm, t);    % Mass interpolation
mc(isnan(mc)) = 0;           % Set NaN mass values to 0

mass=(mc + mmc + mr) ./ 1000;  % Total mass in kg (converted from g)

vy = zeros(size(t)); % Initial vertical velocity (0 m/s)
vx = zeros(size(t)); % Initial horizontal velocity (0 m/s)
ay = zeros(size(t)); % Initial vertical position (0 m)
ax = zeros(size(t)); % Initial horizontal position (0 m)
acv = zeros(size(t)); % vertical Acceleration array
ach = zeros(size(t)); % horizontal Acceleration array

drag = @(v) 1/2 * 1.225 * v^2 * 0.331839254852915 * 0.025086006922186;

% Trigger mechanisms
PayloadTriggered = 0;
ParachuteTriggered = 0;
alpha = pi/2 - pi/12;
i =1;
endSim =0;

while i

    Av= @(v) (tc(i) * sin(alpha)  - drag(v) * sin(alpha) - mass(i)*g)/mass(i);
    Ah = @(v) (tc(i) * cos(alpha) - drag(v) * cos(alpha)) / mass(i);

    acv(i+1) = Av(vy(i));
    ach(i+1) = Ah(vx(i));
    
    % Compute k-values for vertical velocity (Vy)
    k1_Vy = dt * Av(vy(i));
    k2_Vy = dt * Av(vy(i) + 0.5*k1_Vy);
    k3_Vy = dt * Av(vy(i) + 0.5*k2_Vy);
    k4_Vy = dt * Av(vy(i) + k3_Vy);
   
    vy(i+1) = vy(i) + (1/6) * (k1_Vy + 2 * k2_Vy + 2 * k3_Vy + k4_Vy);

    % Compute k-values for positions (x and y)
    k1_y = dt * vy(i);
    k2_y = dt * (vy(i) + 0.5 * k1_Vy);
    k3_y = dt * (vy(i) + 0.5 * k2_Vy);
    k4_y = dt * (vy(i) + k3_Vy);

    ay(i+1) = ay(i) + (1/6) * (k1_y + 2 * k2_y + 2 * k3_y + k4_y);

    % Runge-Kutta 4th-order method for horizontal velocity
    k1_Vx = dt * Ah(vx(i));
    k2_Vx = dt * Ah(vx(i) + 0.5 * k1_Vx);
    k3_Vx = dt * Ah(vx(i) + 0.5 * k2_Vx);
    k4_Vx = dt * Ah(vx(i) + k3_Vx);

    vx(i+1) = vx(i) + (1/6) * (k1_Vx + 2 * k2_Vx + 2 * k3_Vx + k4_Vx);

    % Runge-Kutta 4th-order method for horizontal position
    k1_x = dt * vx(i);
    k2_x = dt * (vx(i) + 0.5 * k1_Vx);
    k3_x = dt * (vx(i) + 0.5 * k2_Vx);
    k4_x = dt * (vx(i) + k3_Vx);

    ax(i+1) = ax(i) + (1/6) * (k1_x + 2 * k2_x + 2 * k3_x + k4_x);

    if (ay(i+1) - ay(i)) < 0 && vy(i) < 0 && t(i) > max(tth)
        break;
    end
    i=i+1;
    % fprintf("(%f) Net Altitude: %f Net Velocity: %f Net Acceleration: %f \n", i, altitude(i), velocity(i),  An(velocity(i)) );
end

ap = i;
% fprintf("--------------------------------\n");


while i

    Av= @(v) (drag(v) - mass(i)*g)/mass(i);
    Ah = @(v) (tc(i) * cos(alpha) - drag(v) * cos(alpha)) / mass(i);

    acv(i+1) = Av(vy(i));
    ach(i+1) = Ah(vx(i));
    
    % Compute k-values for vertical velocity (Vy)
    k1_Vy = dt * Av(vy(i));
    k2_Vy = dt * Av(vy(i) + 0.5*k1_Vy);
    k3_Vy = dt * Av(vy(i) + 0.5*k2_Vy);
    k4_Vy = dt * Av(vy(i) + k3_Vy);
   
    vy(i+1) = vy(i) + (1/6) * (k1_Vy + 2 * k2_Vy + 2 * k3_Vy + k4_Vy);

    % Compute k-values for positions (x and y)
    k1_y = dt * vy(i);
    k2_y = dt * (vy(i) + 0.5 * k1_Vy);
    k3_y = dt * (vy(i) + 0.5 * k2_Vy);
    k4_y = dt * (vy(i) + k3_Vy);

    ay(i+1) = ay(i) + (1/6) * (k1_y + 2 * k2_y + 2 * k3_y + k4_y);

    % Runge-Kutta 4th-order method for horizontal velocity
    k1_Vx = dt * Ah(vx(i));
    k2_Vx = dt * Ah(vx(i) + 0.5 * k1_Vx);
    k3_Vx = dt * Ah(vx(i) + 0.5 * k2_Vx);
    k4_Vx = dt * Ah(vx(i) + k3_Vx);

    vx(i+1) = vx(i) + (1/6) * (k1_Vx + 2 * k2_Vx + 2 * k3_Vx + k4_Vx);

    % Runge-Kutta 4th-order method for horizontal position
    k1_x = dt * vx(i);
    k2_x = dt * (vx(i) + 0.5 * k1_Vx);
    k3_x = dt * (vx(i) + 0.5 * k2_Vx);
    k4_x = dt * (vx(i) + k3_Vx);

    ax(i+1) = ax(i) + (1/6) * (k1_x + 2 * k2_x + 2 * k3_x + k4_x);

    if ay(i+1) < -1
        endSim =i
        break;
    end
    i=i+1;
    % fprintf("(%f) Net Altitude: %f Net Velocity: %f Net Acceleration: %f \n", i, altitude(i), velocity(i),  An(velocity(i)) );
end
% Plot results
figure;

% Plot altitude
subplot(4, 1, 1);
plot(t(1:endSim), ay(1:endSim));
xlabel('Time (s)');
ylabel('Altitude (m)');
title('Altitude');
yline(ay(ap), "-k", {"Apogee:", ay(ap)});
grid on;

% Plot vertical velocity
subplot(4, 1, 2);
plot(t(1:endSim), vy(1:endSim));
xlabel('Time (s)');
ylabel('Vertical Velocity (m/s)');
yline(max(vy), "-k", {"Apogee:", max(vy)});

title('Vertical Velocity');
grid on;

% Plot horizontal velocity
subplot(4, 1, 3);
plot(t(1:endSim), vx(1:endSim));
xlabel('Time (s)');
ylabel('Horizontal Velocity (m/s)');
title('Horizontal Velocity');
grid on;

% Plot horizontal distance
subplot(4, 1, 4);
plot(t(1:endSim), ax(1:endSim));
xlabel('Time (s)');
ylabel('Horizontal Distance (m)');
title('Horizontal Distance');
grid on;
