observationInfo = rlNumericSpec( 1, LowerLimit = -pi, UpperLimit = pi );
actionInfo = rlNumericSpec( 1, LowerLimit = -1, UpperLimit = 1 );
rlSinusEnv = rlFunctionEnv( observationInfo, actionInfo, @(Action, Info)SinusStep(Action, Info), @()SinusReset );


