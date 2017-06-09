%% Plot flow vs. occupany for different demand profiles 
%close all

%% Extract data from previously ran simulations

read_or_update_simDetectorData; 
dataFiles = dir(findCalibrationFolder.temp());

% Load all available data into workspace
data = [];
for i = 3:length(dataFiles) % First two files are '.' and '..'?
   filename = dataFiles(i).name;
   data = [data; load(filename)];  
end

% If oneIntersection = 1, extract data only from intersection specified by
% intersectionID (first 4 digits of External detector ID at desired location)
oneIntersection = 1;
if oneIntersection
    intersectionID = '6082'; % must be string
    combinedData = combineData(data, intersectionID); 
else
    combinedData = combineData(data); 
end

%% Separate data by simulation, plot flow/occ, occ/time, flow/time graphs

% Create array
sims = {};
for i = 1:length(combinedData)
    simulationTime = combinedData(i).SimulationTime; % e.g. '2017-06-07 123227'
    sims = [sims simulationTime]; % array of strings of simulation times
end

uniqueSims = unique(sims);
numSims = length(uniqueSims);

% Create struct array of length numSims, where each entry holds vectors of
% data for certain simulation
separatedSimData = repmat(struct('DetectorID',[],'DetectorExternalID',[],...
    'SimulationTime',[],'SimulationTimeDouble',[],'Time',[],'Volume',[],...
    'Occupancy',[]), 1, numSims);

for i = 1:length(combinedData)
    index = find(strcmp(combinedData(i).SimulationTime,uniqueSims));
    separatedSimData(index).DetectorID = [combinedData(i).DetectorID;
 
end


    
    %plot_and_save(___);
 
    % -Plot flow/occ, flow/time, occ/time (last two on same plot: use yyaxis
    %   function) for each detector
    % -Save each detector plot as .fig and .png
    % -Combine detector plots into one subplot, maybe organize by advanced
    %   and stopbar detectors


%% Plot Flow vs Occ

% available_colors = linspace(1,10,6);
% colors = [];
% 
%%% To do: clean up colors assignments, get rid of idInf %%%
% for i = 1:length(flow)
%    time = idInf(i,1);
%    if time < 21600
%        colors(i) = available_colors(1);
%    elseif time < 32400
%        colors(i) = available_colors(6);
%    elseif time < 55800
%        colors(i) = available_colors(1);
%    elseif time < 68400
%        colors(i) = available_colors(6);
%    elseif time < 75600
%        colors(i) = available_colors(1);
%    else
%        colors(i) = available_colors(1);
%    end
% end
% 
% figure(1)
% 
% subplot(2,2,1)
% set(gca,'FontSize',11);
% xlabel('Occupancy');
% ylabel('Flow');
% %scatter(flow, occupancy, [], color);
% scatter(occupancy, flow,[], colors);
% title('Flow vs Occupancy');
% 
% 
% 
% 
% subplot(2,2,2)
% set(gca,'FontSize',11);
% xlabel('Time');
% ylabel('Flow');
% scatter(Timesec, flow,[], colors);
% title('Flow vs Time');
% 
% subplot(2,2,3)
% set(gca,'FontSize',11);
% xlabel('Time');
% ylabel('Occupancy');
% scatter(Timesec, occupancy, [], colors);
% title('Occupancy vs Time');


%% Function to combine data into one struct, with optional specification of intersection
function [combinedData] = combineData(data, intersectionID)
    % Inputs: 
        % data: dx1 struct, where d = # unique detectors. Each entry is
        %       struct containing data from all time steps at that detector
        % intersectionID: first 4 digits of External detector ID at desired
        %       intersection (optional)
        
    % Outputs:
        % combinedData: nx1 struct, where n = (# time steps in
        %       simulation)*(number of simulations)

    if nargin < 1
        error('Must supply data');
    elseif nargin < 2
       intersectionID =  nan;
    end
    
    combinedData = [];
    for i = 1:length(data)
        
        if(~isnan(intersectionID))  % Extract data from only one intersection
            % To do: clean up following 3 lines to find currInt ID
            extID = data(i).detectorDataAll.DetectorExternalID;
            extIDstring = num2str(extID);
            currInt = extIDstring(1:4);  % current intersection ID
  
            if(strcmp(intersectionID, currInt))  % desired intersection, so add to data
                combinedData = [combinedData; data(i).detectorDataAll];
            end
        else    % Extract all data
            combinedData = [combinedData; data(i).detectorDataAll];
        end
    end
    if (isempty(combinedData) & ~isnan(intersectionID))
        error('No data at selected intersection'); 
    end
   
end






