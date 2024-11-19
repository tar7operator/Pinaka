LaunchAngle = deg2rad(20); %Enter Angle here
f = @(x) (2.*x./((21 - x) .* log((10.5+x)/10.5))) - (127.38603007190 + 9.81*3.5)/(143.53048456686 * cos(LaunchAngle));
i = 1.9253:0.000000001:1.9254;
format long
mp = f(i);
k = [i', mp'];
writematrix(k, "20DegMotorMassError.txt")
