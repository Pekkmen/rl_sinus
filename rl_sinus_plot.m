function rl_sinus_plot(agent)
    clc;
    close all
    
    interval = linspace(0, 2*pi, 1000);
    expected_answers = zeros(1000);

    for i = 1:length(interval)
        expected_answer = getAction(agent, interval(i));
        expected_answers(i) = expected_answer{1};
        %expected_answers(i) = sin(interval(i));
        disp(interval(i) + " = " + gather(expected_answers(i)) + " (" + num2str(sin(interval(i)), '%.5f') + ")")
    end 

    plot(interval, expected_answers, "-");
    grid on;
end
