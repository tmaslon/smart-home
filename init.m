timeStep = 5; % minutes
days = 1;

stepsInDay = 24*60/timeStep;
intervals = days*288; % 288 5 minute intervals per 24hours

sim("test");