% Parachute Area Calculator

% Inputs
mass = input('Enter the mass of the CanSat (kg): '); % Mass in kilograms
descent_velocity = input('Enter the desired descent velocity (m/s): '); % Velocity in m/s
drag_coefficient = input('Enter the drag coefficient of the parachute: '); % Drag coefficient

% Constants
gravity = 9.81; % Acceleration due to gravity in m/s^2
air_density = 1.225; % Air density at sea level in kg/m^3

% Calculation
parachute_area = (2 * mass * gravity) / (air_density * drag_coefficient * descent_velocity^2);

% For the circular parachute
radius_circle = sqrt(parachute_area / pi);  % Calculate the radius of the circle
diameter_circle = 2 * radius_circle;  % Calculate the diameter of the circle

% For the dome-shaped parachute (hemisphere)
radius_dome = sqrt(parachute_area / (2 * pi));  % Calculate the radius of the dome (half of the hemisphere's surface area)
diameter_dome = 2 * radius_dome;  % Calculate the diameter of the dome

% Output
fprintf('The required parachute area is %.4f m².\n', parachute_area);

% Display results
fprintf('The equivalent diameter for the circle is: %.4f meters\n', diameter_circle);
fprintf('The equivalent diameter for the dome is: %.4f meters\n', diameter_dome);


