close all
clear
clc

obs_info = rlNumericSpec([1 1], LowerLimit=-pi, UpperLimit=pi);
obs_info.Name = "Sinus Parameter";

act_info = rlNumericSpec([1 1], LowerLimit=-1, UpperLimit=1);
act_info.Name = "Sinus Result";

reset_fcn_handle = @()reset_train();
step_fcn_handle = @(action, portfolio)step_train( ...
    action, portfolio);

sinus_train_env = rlFunctionEnv( ...
    obs_info, act_info, step_fcn_handle, reset_fcn_handle);

% train_opts = rlTrainingOptions(MaxEpisodes=100000, MaxStepsPerEpisode=100, UseParallel=true);
% 
% PG_init_opt = rlAgentInitializationOptions(Normalization="rescale-zero-one", NumHiddenUnit=32);
% PG_agent = rlPGAgent(obs_info, act_info, PG_init_opt);
% PG_critic = getCritic(PG_agent);
% PG_critic.UseDevice = "gpu";
% PG_agent = setCritic(PG_agent, PG_critic);
% PG_actor = getActor(PG_agent);
% PG_actor.UseDevice = "gpu";
% PG_agent = setActor(PG_agent, PG_actor);
% PG_trained_agent_stats = train(PG_agent, sinus_train_env, train_opts);

% DOCS: The MiniBatchSize value must be less than or equal to the ...
% ExperienceHorizon value (The MiniBatchSize = 128 and ...
% ExperienceHorizon = 512 by default)
% DOCS: For on-policy agents that support LearningFrequency property ...
% (PPO and TRPO), set LearningFrequency to an integer multiple of ...
% MiniBatchSize
% PPO_init_opt = rlPPOAgentOptions(ExperienceHorizon= 12, LearningFrequency=256, NormalizedAdvantageMethod="current");
% PPO_agent = rlPPOAgent(obs_info, act_info, PPO_init_opt);
% PPO_trained_agent_stats = train(PPO_agent, sinus_train_env, train_opts);


function [initial_observation, portfolio] = reset_train()
    portfolio = struct;
    initial_observation = (2*pi*rand(1)-pi); %(rand(1)*pi*2); %2*pi*rand(1)-pi; 
    portfolio.LastValue = initial_observation;
end

function [next_observation, reward, is_done, portfolioOut] = step_train( ...
    action, portfolio)
    expected_prediction = (sin(portfolio.LastValue));
    % reward = 1 / (0.01 + abs(action - expected_prediction));
    % reward = exp(-5*abs(action-expected_prediction));
    % if (abs(action-expected_prediction) > 0.03)
    %     reward = -abs(action-expected_prediction);
    %     %reward = -1;
    % else 
    %     reward = 1;
    % end
    % disp("EXP = " + expected_prediction + ", ACT = " + action + ", RWD = " + reward)
    reward = 1-hyperbolicPenalty(expected_prediction - action,-0.01,0.01,1,0.01);
    next_observation = 2*pi*rand(1)-pi;%(rand(1)*pi*2); %2*pi*rand(1)-pi;
    %portfolioOut = portfolio;
    portfolioOut = struct;
    portfolioOut.LastValue = next_observation;
    is_done = false;
end

