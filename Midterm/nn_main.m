format long;
data = load('uci_bc.mat');
base_learning_rate = 1.0e-5;
learning_rate = base_learning_rate;
epochs = 1.5e+4;
neuron_count = [200 200 100 50 25 12 1];

count = 1;

input_raw = data.X;
input_normalized = zeros(size(input_raw));
input_results_raw = data.Y;

means = zeros(size(input_raw,1), 1);
standard_deviations = zeros(size(input_raw,1), 1);

% Iterates through all the input variables and stores
% the mean and standard deviation
for(i = 1:size(input_raw,1))
    means(i, 1) = mean(input_raw(i,:));
    standard_deviations(i, 1) = std(input_raw(i,:));
end

% Iterates through all elements and stores the normalized elements of the
% data into a matrix
input_normalized = (input_raw - means) ./ standard_deviations;

%Splits the data into a training set and evaluation set
training_input = input_normalized(:,1:375);
evaluation_input = input_normalized(:,350:500);
training_output = input_results_raw(:,1:375);
evaluation_output = input_results_raw(:,350:500);

% Initializes the weights using Xavier initialization
weights = nn_initialize(neuron_count, size(training_input, 1));

bar = waitbar(0,'Processing...');
% Trains the NN for the given number of epochs
prev_m2_error = inf;
for(x = 1:epochs)
    forwardprop_values = nn_forwardprop(weights, training_input);
    backprop_gradients = nn_backprop(weights, forwardprop_values, ...
        training_output, training_input);
    weights = nn_update(weights, backprop_gradients, learning_rate);
    
    evaluation_prop = nn_forwardprop(weights, evaluation_input);
    m2_error = nn_evaluate(cell2mat(evaluation_prop(:,2)), evaluation_output);
    if(m2_error >= prev_m2_error)
        break;
    end
    prev_m2_error = m2_error;
    %disp(m2_error);
    waitbar(count/epochs, bar, sprintf('%s %.10f','Mean^2 Error:', m2_error));
    count = count + 1;
end
%close(bar);

% Displays average mean-sqared error relative to the training data
m2_error = nn_evaluate(cell2mat(evaluation_prop(:,2)), evaluation_output);
disp(m2_error);