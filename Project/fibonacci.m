function [a_vals, b_vals, f_evals] = fibonacci(f, a, b, l, e)
    % FIBONACCI performs interval reduction to find minimum.
    % Inputs:
    %   f  - function handle for the function to minimize
    %   a  - initial left bound of interval
    %   b  - initial right bound of interval
    %   l  - desired length of final interval
    %   e  - small positive constant to ensure interval split near the end
    % Outputs:
    %   a_vals  - the values of the left bound of interval during search
    %   b_vals  - the values of the right bound of interval during search
    %   f_evals - the number of times we evaluated the function f at a specific point

    % Step 1: Compute required Fibonacci number n such that Fibonacci(n) > (b-a)/l
    fibs = [1 1]; % The first 2 fibonacci numbers
    while fibs(end) <= (b - a)/l
        fibs = [fibs, fibs(end) + fibs(end-1)];
    end
    n = size(fibs, 2) - 1; % n = the number of total calculations numbers in fibs
    % The -1 is because indexing of Fn in the book starts from 0
    % Initialize storage arrays and store initial values
    a_vals = a;
    b_vals = b;
    
    % Initialize f_evals counter
    f_evals = 0;

    % Initial points and function evaluation at those
    % We need to add +1 to the indexes of fibs matrix because indexing in
    % matlab starts from 1
    x1 = a + (fibs(n - 1) / fibs(n + 1)) * (b - a);
    x2 = a + (fibs(n) / fibs(n + 1)) * (b - a);
    f_x1 = f(x1);
    f_x2 = f(x2);
    f_evals = f_evals + 2; % Two evaluations at x1, x2

    % Main loop
    for k = 1:(n-2) % k = n - 2 is a break condition
        if f_x1 > f_x2 % Enters step 2
            % Update interval
            a = x1; % a becomes x1, b stays the same
            
            % Update x1 and x2
            x1 = x2; % x1 becomes x2
            x2 = a + (fibs(n - k) / fibs(n - k + 1)) * (b - a); % Find new value of x2
            % In the line above the indexes are n-k and n-k+1 instead of
            % n-k-1 and n-k as in the book, because indexes in matlab
            % matrices (fibs in this case) are 1-based and in the break
            % condition k=n-2 the fibs(0) won't be defined
            
            % Store new points
            a_vals = [a_vals, a];
            b_vals = [b_vals, b];
            
            % Update the non-changed function value
            f_x1 = f_x2;

            % Check for break condition
            if k == n - 2
                break; % Exit the main loop
            else
                % Update function value at new point
                f_x2 = f(x2);
                f_evals = f_evals + 1; % Evaluation at x2
            end

        else % Enters step 3
            % Update interval
            b = x2; % b becomes x2, a stays the same
            
            % Update x1 and x2
            x2 = x1; % x2 becomes x1
            x1 = a + (fibs(n - k - 1) / fibs(n - k + 1)) * (b - a); % Find new value of x1
            % In the line above the indexes are n-k and n-k+1 instead of
            % n-k-1 and n-k as in the book, because indexes in matlab
            % matrices (fibs in this case) are 1-based and in the break
            % condition k=n-2 the fibs(0) won't be defined
            
            % Store new points
            a_vals = [a_vals, a];
            b_vals = [b_vals, b];

            % Update the non-changed function value
            f_x2 = f_x1;

            % Check for break condition
            if k == n - 2
                break;
            else
                % Update function value at new point
                f_x1 = f(x1);
                f_evals = f_evals + 1; % Evaluation at x1
            end
        end
    end
    % Handle the case for k = n - 2
    x2 = x1 + e; % In the last iteration x1 doesn't change, while x2 becomes x1 + e
    % f_x1 doesn't change since x1 doesn't change
    % However we need to compute the last f(x2_n)
    f_x2 = f(x2);
    f_evals = f_evals + 1; % Evaluation at x2
    if f_x1 > f_x2 % Check to find the final interval
        a = x1; % a becomes x1, b doesn't change
    else 
        b = x2; % b becomes x2, a doesn't change
    end
    a_vals = [a_vals, a]; % Update the final interval limits
    b_vals = [b_vals, b];
end
