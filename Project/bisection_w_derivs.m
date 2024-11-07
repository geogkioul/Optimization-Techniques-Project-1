function [a_vals, b_vals, f_evals] = bisection_w_derivs(f, a, b, l)
    % BISECTION_W_DERIVS implements the bisection with derivatives method.
    % Inputs:
    %   f - function handle for the function f(x)
    %   a - initial left endpoint of the interval
    %   b - initial right endpoint of the interval
    %   l - minimum length of the interval for stopping
    %
    % Outputs:
    %   a_vals - values of 'a' at each iteration
    %   b_vals - values of 'b' at each iteration
    %   f_evals - the number of iterations needed to find the final interval

    % Find the number of iterations needed to achieve interval length less
    % than l
    % We want l >= (1/2)^n * (b1 - a1) so n is found to be
    % n >= log_b2_((b1-a1)/l)
    n = ceil( log2 ( (b - a) / l) );
    
    % Convert the function to its symbolic expression
    % This will be needed to find its derivative
    syms x;
    f_sym = f(x);
    % Find the derivative
    f_deriv = diff(f_sym, x);

    % Initialize matrices to store a,b values for each iteration
    a_vals = a;
    b_vals = b;

    % Initialize f_evals
    f_evals = 0;

    % Main loop
    for k = 1:n
        xk = (a + b)/2; % Find the midpoint of the interval at iteration k
        df_dx = double(subs(f_deriv, x, xk)); % Substitute xk in the derivative expression
        f_evals = f_evals + 1; % Calculated derivative at xk
        if df_dx == 0 % Break condition, xk is minimum
            break;
        elseif df_dx > 0 % Enter step 2
            b = xk; % b changes to xk while a stays the same
        else % Enter step 3
            a = xk; % a changes to xk while b stays the same
        end

        % Update a_vals, b_vals
        a_vals = [a_vals, a];
        b_vals = [b_vals, b];
        % We return f_evals instead of n because we might hit the minimum
        % by accident so there is no need for more computations, f_evals <= n 
    end
   