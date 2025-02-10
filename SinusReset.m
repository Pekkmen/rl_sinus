function [InitialObservation,Info] = SinusReset
    x_values = 2*pi*rand([500,1])-pi;
    x_values = sort(x_values);
    Info = struct;
    Info.x_values = x_values;
    Info.LastIndex = 1;
    InitialObservation = Info.x_values(Info.LastIndex);
end

