function task_bisection(functions, a, b)
    % Inputs: 
    %   functions - The function handles for all three functions f1, f2, f3
    %   a   - The left boundary of the initial interval
    %   b   - The right boundary of the initial interval
    
    %% SubTask 1: Keep l=0.01 and change e
    l = 0.01;
    % We must ensure that the condition l > 2e will always hold, because 
    % if e >= l/2 then the program will not terminate as the interval
    % boundaries will not change from that point on
    e_vals = linspace(0.0001, 0.0045, 100); 
    % Values of e lower than 0.005 which is the critical value
    e_length = length(e_vals);
        
    % Preallocate a matrix to hold the f_vals with respect to e_vals
    plotting_mat = zeros(3, e_length); 
    % 3 rows, one for each function and e_length cols for each e
    
    for i = 1:3 % For each function
        for j = 1:e_length % For every value of e
            e = e_vals(j);
            % Run bisection with that value
            [~, ~, f_vals] = bisection(functions{i}, a, b, l, e);
            % Store the f_vals for i-th function and j-th e value
            plotting_mat(i, j) = f_vals; 
        end
    end
    
    % Plot each function's results in a different figure
    for i=1:3
        figure; % Create a new figure
        plot(e_vals, plotting_mat(i, :), 'DisplayName', ['Function ' num2str(i)], 'LineWidth', 0.5, 'Marker','o');
        xlabel('e values');
        ylabel(sprintf('Number of function %d evaluations', i));
        title(sprintf('Number of function %d evaluations for different e values, l=0.01 - Bisection method', i));
        legend('show');
        grid on;
    end
    
    % Add labels and title
    

    %% SubTask 2: Keep e = 0.001 and change l
    e = 0.001;
    % We must ensure that the condition l > 2e will always hold, because 
    % if e >= l/2 then the program will not terminate as the interval
    % boundaries will not change from that point on
    l_vals = linspace(0.0025, 1, 100);
    % Values of e higher than 0.002 which is the critical value
    l_length = length(l_vals);
    

    % Preallocate a matrix to hold the f_vals with respect to l_vals
    plotting_mat = zeros(3, l_length);
    % 3 rows, one for each function and l_length cols for each l

    for i = 1:3 % For each function
        % Make cells to store a and b values over iterations for each
        % execution of bisection for every value of l
        a_values = cell(l_length, 1); 
        b_values = cell(l_length, 1);
        for j = 1:l_length % For every value of l
            l = l_vals(j);
            % Run bisection with that value
            [a_vals, b_vals, f_vals] = bisection(functions{i}, a, b, l, e);
            a_values = [a_values; a_vals]; % Store a values for this l value
            b_values = [b_values; b_vals]; % Store b values for this l value
            % Store the f_vals for i-th function and j-th value
            plotting_mat(i, j) = f_vals;
        end
    end

    % Plot each function's results in a different figure
    for i=1:3
        figure; % Create a new figure
        plot(l_vals, plotting_mat(i, :), 'DisplayName', ['Function ' num2str(i)], 'LineWidth', 0.5, 'Marker','x');
        xlabel('l values');
        ylabel(sprintf('Number of function %d evaluations', i));
        title(sprintf('Number of function %d evaluations for different l values, e=0.001 - Bisection method', i));
        legend('show');
        grid on;
    end
   
    %% SubTask 3: Plot interval boundaries for different l values
    e = 0.001; % I will keep the same e as before
    % Set some new values for l, 20 from before was too many
    l_vals = [0.1, 0.05, 0.01, 0.005, 0.0025];
    
    l_length = length(l_vals);
    markers = {'o', 'd', 'x', 's', '^'}; % Different markers for each l

    for i = 1:3 % For each function
        figure; % Create a new figure
        hold on;

        for j = 1:l_length % For every value of l
            l = l_vals(j);
            % Run bisection with that value
            [a_vals, b_vals, ~] = bisection(functions{i}, a, b, l, e);
            iterations = length(a_vals); % Find the total number of iterations
            k_vals = 1:iterations; % The k values for the horizontal axis
            % Plot a_vals and b_vals against k_vals
            plot(k_vals, a_vals, "Color", 'r', 'DisplayName', sprintf('a for l=%.4f',l), 'LineWidth', 0.7, 'MarkerFaceColor','auto');
            plot(k_vals, b_vals, "Color", 'b', 'DisplayName', sprintf('b for l=%.4f',l), 'LineWidth', 0.7, 'MarkerFaceColor','auto');

            % Mark only the endpoints with markers
            plot(iterations, a_vals(end), markers{j}, 'MarkerSize', 8, 'DisplayName', ['Final a for l = ', num2str(l_vals(j))]);
            plot(iterations, b_vals(end), markers{j}, 'MarkerSize', 8, 'DisplayName', ['Final b for l = ', num2str(l_vals(j))]);
            
        end
        % Customize the total figure
        xlabel('Iteration k');
        ylabel('Interval Borders');
        title(sprintf('Values of interval borders [a,b] for function %d across iterations, e=0.001 - Bisection method', i));
        legend('show', 'Location','best', 'NumColumns', 5);
        grid on;
        hold off;
    end
end