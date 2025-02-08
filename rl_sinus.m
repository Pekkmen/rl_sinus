close all
clear
clc

obs_info = rlNumericSpec([1 1], LowerLimit=0, UpperLimit=2*pi);
obs_info.Name = "Sinus Parameter";

act_info = rlNumericSpec([1 1], LowerLimit=0, UpperLimit=2);
act_info.Name = "Sinus Result";

reset_fcn_handle = @()reset_train();
step_fcn_handle = @(action, portfolio)step_train( ...
    action, portfolio);

sinus_train_env = rlFunctionEnv( ...
    obs_info, act_info, step_fcn_handle, reset_fcn_handle);

function [initial_observation, portfolio] = reset_train()
    portfolio = struct;
    initial_observation = rand(1)*pi*2; %2*pi*rand(1)-pi; 
    portfolio.LastValue = initial_observation;
end

function [next_observation, reward, is_done, portfolioOut] = step_train( ...
    action, portfolio)
    expected_prediction = 1+sin(portfolio.LastValue);
    % reward = 1 / 100 / (0.01 + abs(action - expected_prediction));
    % reward = exp(-5*abs(action-expected_prediction));
    if (abs(action-expected_prediction) > 0.03)
        reward = -abs(action-expected_prediction);
    else 
        reward = 1;
    end
    next_observation = rand(1)*pi*2; %2*pi*rand(1)-pi;
    %portfolioOut = portfolio;
    portfolioOut = struct;
    portfolioOut.LastValue = next_observation;
    is_done = false;
end

