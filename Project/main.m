%% THIS SECTION SHOULD RUN FIRST BEFORE ANY OTHER FUNCTION OR SECTION
% Clear the workspace and command window
clear; clc;

% Define the 3 functions
f1 = @(x) (x-2)^2 + x*log(x+3);
f2 = @(x) exp(-2*x) + (x-2)^2;
f3 = @(x) exp(x)*(x^3-1)+(x-1)*sin(x);

% Store them in a cell array for easy access
functions = {f1, f2, f3};
% Define the starting interval for all functions
a = -1;
b = 3;

% Call each task
%% Task 1 - Bisection Method
task_bisection(functions, a, b);

%% Task 2 - Golden Section Method
task_golden_section(functions, a, b);

%% Task 3 - Fibonacci Method
task_fibonacci(functions, a, b);

%% Task 4 - Bisection with derivatives Method
task_bisection_w_derivs(functions, a, b);
