function [action] = EvaluateTraining(training, observation)
    act = getAction(training, {observation});
    action = act{1};
end

