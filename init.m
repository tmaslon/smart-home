timeStep = 5; % minutes
days =1;

stepsInDay = 24*60/timeStep;
intervals = days*stepsInDay; % 288 5 minute intervals per 24hours

sunrise = floor(0.25*stepsInDay);   
sunset = floor(0.8*stepsInDay);
%sim("test");