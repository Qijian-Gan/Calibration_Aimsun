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

simNames ={};
simData = {};
for i = 1:length(fileList)
   name = erase(erase(fileList(i).name,'DetectorData_'),'.csv');
   simNames = [simNames name]; 
   % Slow way: use following initialization
  % simData(i,:) = {name, struct('DetectorID',[],'DetectorExternalID',[],...
    %'SimulationTime',[],'SimulationTimeDouble',[],'Time',[],'Volume',[],...
    %'Occupancy',[])};
    
   for j = 1:size(data,1)
       % Sort detector data into corresponding simulations
      idx = ismember({data(j).detectorDataAll.SimulationTime}', {name});
      selectedData = data(j).detectorDataAll(idx,:); 
      % Add selectedData to struct containing info for that simulation
      simData(i,:) = {name, selectedData};
      %simData(i,2) = [simData(i,2) selectedData];


   end
end



%% Separate data by simulation, plot flow/occ, occ/time, flow/time graphs



    
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









