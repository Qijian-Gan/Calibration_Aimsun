%% Plot flow vs. occupany for different demand profiles 
%close all

%% Extract data from previously ran simulations

read_or_update_simDetectorData; 
dataFiles = dir(findCalibrationFolder.temp());

% Load all available data into workspace
data = [];
for i = 3:size(dataFiles,1) % First two files are '.' and '..'?
   filename = dataFiles(i).name;
   data = [data; load(filename)];  
end

for i = 1:size(fileList,1) % Loop through each simulation
   name = erase(erase(fileList(i).name,'DetectorData_'),'.csv');
   flow = [];
   occ = [];
   time = [];
    for j = 1:size(data,1)
        % For each detector: compare simulation time to desired simulation
       idx = ismember({data(j).detectorDataAll.SimulationTime}', {name});
       selectedData = {data(j).detectorDataAll(idx,:)};
       flow = [flow {selectedData{1}.Volume}];
       occ = [occ {selectedData{1}.Occupancy}];
       time = [time {selectedData{1}.Time}];
       plot_and_save(flow,occ,time,name);
    end
end



%% Plot flow/occ, occ/time, flow/time graphs and save figures

function plot_and_save(flow,occ,time,name)
    % Create 2x1 subplot of:
        % flow vs. occ
        % flow vs. time, occ vs. time on double y-axis
    
    % Flow vs. occupancy
    subplot(2,1)
    set(gca,'FontSize',11);
    xlabel('Occupancy');
    ylabel('Flow');
    scatter(
    


end


%% Save figure












