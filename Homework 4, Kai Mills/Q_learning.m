iterations = 100000;
exploration_likelihood = 1;
alpha = 0.9;
beta = 0.99;
gamma = 0.87;
simulated_trials = 100;
trials_results = zeros(simulated_trials,1);
trials_standings = zeros(simulated_trials,1);
win_reward = 1;
stay_and_lose_reward = -10;
bust_reward = -15;

state_table = zeros(21, 2); % Hit, Stay for all values 1-21

for(i = 1:iterations)
    state_table = explore_game(exploration_likelihood, alpha, gamma, state_table, win_reward, stay_and_lose_reward, bust_reward);
    exploration_likelihood = exploration_likelihood * beta;
end

for(x = 1:simulated_trials)
    trials_results(x,1) = simulate_game(state_table);
    trials_standings(x, 1) = sum(trials_results(1:x,1));
end

plot(trials_standings);
disp(sum(trials_results));
