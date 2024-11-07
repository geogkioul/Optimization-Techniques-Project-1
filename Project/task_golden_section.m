function task_golden_section(functions, a, b)
    % Inputs: 
    %   functions - The function handles for all three functions f1, f2, f3
    %   a   - The left boundary of the initial interval
    %   b   - The right boundary of the initial interval

    %% SubTask 1: Change l
    % Create the values l will take
    l_vals = linspace(0.001, 1, 100);
    l_length = length(l_vals);

    % Preallocate a matrix to hold the f_vals with respect to l_vals
    plotting_mat = zeros(3, l_length); 
    % 3 rows, one for each function and l_length cols for each l

    for i = 1:3 % For each function
        for j = 1:l_length % For every value of l
            l = l_vals(j);
            % Run golden_section with that value
            [~, ~, f_vals] = golden_section(functions{i}, a, b, l);
            % Store the f_vals for i-th function and j-th l value
            plotting_mat(i, j) = f_vals; 
        end
    end
    % Plot each function's results in a different figure
    for i=1:3 % For each function
        figure; % Create a new figure
        plot(l_vals, plotting_mat(i, :), 'DisplayName', ['Function ' num2str(i)], 'LineWidth', 0.5, 'Marker','x');
        xlabel('l values');
        ylabel(sprintf('Number of function %d evaluations', i));
        title(sprintf('Number of function %d evaluations for different l values - Golden Section Method', i));
        legend('show');
        grid on;
    end

    %% SubTask 2: Plot interval boundaries for different l values

    l_vals = [0.1, 0.05, 0.01, 0.005, 0.0025];
    
    l_length = length(l_vals);
    markers = {'o', 'd', 'x', 's', '^'}; % Different markers for each l

    for i = 1:3 % For each function
        figure; % Create a new figure
        hold on;

        for j = 1:l_length % For every value of l
            l = l_vals(j);
            % Run golden_section with that value
            [a_vals, b_vals, ~] = golden_section(functions{i}, a, b, l);
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
        title(sprintf('Values of interval borders [a,b] for function %d across iterations - Golden Section Method', i));
        legend('show', 'Location','best', 'NumColumns', 5);
        grid on;
        hold off;
    end
end