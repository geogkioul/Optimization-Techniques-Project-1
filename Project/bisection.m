function [a_vals, b_vals, f_evals] = bisection(f, a, b, l, e)
    % BISECTION implements the bisection method.
    % Inputs:
    %   f - function handle for the function f(x)
    %   a - initial left endpoint of the interval
    %   b - initial right endpoint of the interval
    %   l - minimum length of the interval for stopping
    %   e - offset to create x1 and x2
    %
    % Outputs:
    %   a_vals - values of 'a' at each iteration
    %   b_vals - values of 'b' at each iteration
    %   f_evals - the number of times we evaluated the function f at a specific point

    % Initialize the iteration counter and f_evals
    k = 1;
    f_evals = 0;

    % Initialize matrices to store a, b values for each iteration
    a_vals = a;
    b_vals = b;
    
    % Loop until the interval length is less than l
    while (b - a >= l)
        % Calculate x1 and x2 values
        x1 = (a + b) / 2 - e;
        x2 = (a + b) / 2 + e;
              
        % Evaluate f(x1) and f(x2)
        f_x1 = f(x1);
        f_x2 = f(x2);
        f_evals = f_evals + 2; % f evaluated at x1 and x2 so +2
        
        % Change the interval boundaries accordingly
        if f_x1 < f_x2
            b = x2; % update b to x2, while a remains the same
        else
            a = x1; % update a to x1, while b remains the same
        end
        
        % Store the updated values in the result arrays
        a_vals = [a_vals, a];
        b_vals = [b_vals, b];
        
        % Increment the iteration counter
        k = k + 1;
    end
end
