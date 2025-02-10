function [NextObservation,Reward,IsDone,UpdatedInfo] = SinusStep(Action,Info)
    ExpectedResult = sin(Info.x_values(Info.LastIndex));
    %Reward = 1/100/(0.01+abs(ExpectedResult - Action));
    Reward = 1-hyperbolicPenalty(ExpectedResult - Action,-0.01,0.01,1,0.01);
    Info.LastIndex = Info.LastIndex+1;
    asize = size(Info.x_values, 1);
    UpdatedInfo = Info;
    NextObservation = 0;
    if (Info.LastIndex>asize) 
        IsDone = true;
    else 
        NextObservation = Info.x_values(Info.LastIndex);
        IsDone = false;
    end
end


%x = -5:0.01:5;
%p = hyperbolicPenalty(x,-0.1,0.1,1,0.06);
%plot(x,p)