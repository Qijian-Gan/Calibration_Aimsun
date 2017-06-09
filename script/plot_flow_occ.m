%% Plot flow vs. occupany for different demand profiles 
%close all
tic
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
   simName = erase(erase(fileList(i).name,'DetectorData_'),'.csv');

   
   for j = 1:size(data,1)
       % For each detector: compare simulation time to desired simulation
       temp_array = cell2mat({data(j).detectorDataAll.DetectorExternalID});
       detectorName = num2str(temp_array(1));
       idx = ismember({data(j).detectorDataAll.SimulationTime}', {simName});
       selectedData = {data(j).detectorDataAll(idx,:)};

       if ~isempty(selectedData{1})
           flow = cell2mat({selectedData{1}.Volume});
           occ = cell2mat({selectedData{1}.Occupancy});
           time = cell2mat({selectedData{1}.Time});
        if j == 1
           plot_and_save(flow,occ,time,simName,detectorName);
        end      

       end
   end
end

toc












