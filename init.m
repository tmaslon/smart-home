clear all;
close all;

timeStep = 5; % minutes
days = 4;

stepsInDay = 24*60/timeStep;
intervals = days*stepsInDay; % 288 5 minute intervals per 24hours

sunrise = floor(0.25*stepsInDay);   
sunset = floor(0.8*stepsInDay);

%shutters thresholds
T_low = -5; %open 
T_high = 24; %close

% simulated schedule of inhabitant movement ------------
sleepSchedule   = 8*60/timeStep;
workSchedule    = 8*60/timeStep;
driveSchedule   = 2*60/timeStep;
freeSchedule    = 1*60/timeStep;

inhabitant = zeros(1,workSchedule);
inhabitant = [inhabitant, zeros(1,driveSchedule)];

for j = 1:6
    inhabitant = [inhabitant, (j)*ones(1, freeSchedule)];
end

inhabitant      = [inhabitant, zeros(1,workSchedule)];
temp_inhabitant = inhabitant;

for j = 2:days
    inhabitant = [inhabitant, temp_inhabitant];
end
inhabitant      = [inhabitant, 0];
inhabitant_movement   = timeseries(inhabitant);

% simulated GPS of inhabitant ---------------------------
inhabitant_gps = zeros(1,workSchedule);
inhabitant_gps = [inhabitant_gps, linspace(0,1,driveSchedule)];
inhabitant_gps = [inhabitant_gps, zeros(1, 14*60/timeStep)];

if days>1
    inhabitant_temp = inhabitant_gps;
    for i=1:days
        inhabitant_gps = [inhabitant_gps, inhabitant_temp];
    end
end
inhabitant_gps = timeseries(inhabitant_gps);

% simulated rain ----------------------------------------
rain_prediction = [];
if days<3
    rain_prediction = timeseries(ones(1, intervals));
else
    for i=1:days
        if mod(i, 4) == 0
            rain_prediction = [rain_prediction, zeros(1, stepsInDay)];
        else
            rain_prediction = [rain_prediction, ones(1, stepsInDay)];
        end
    end
    rain_prediction = timeseries(rain_prediction);
end

good_q =    100;
bad_q =     300;
% -------------------------------------------------------
