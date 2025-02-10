function [] = PlotTraining(training)
    x_values = linspace(-pi, pi, 1000);
    eval_function = @(x) EvaluateTraining(training, x);
    y_values = arrayfun(eval_function, x_values);
    plot(x_values, y_values);
end
