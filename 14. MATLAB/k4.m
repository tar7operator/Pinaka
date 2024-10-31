function y_next = k4(func, y_current, dt)
    % RK4 single step for solving ordinary differential equations
    % func: function handle for the derivatives
    % y_current: current state vector
    % dt: time step
    
    % Calculate k1, k2, k3, k4
    k1 = func(y_current);
    k2 = func(y_current + (dt / 2) * k1);
    k3 = func(y_current + (dt / 2) * k2);
    k4 = func(y_current + dt * k3);
    
    % Update the state using the weighted average of the slopes
    y_next = y_current + (dt / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
end
