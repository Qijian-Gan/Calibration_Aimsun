% Sort vehicle trajectory data into folders separated by simulation.
% Within each folder are files of vehicle trajectories, where each file
% consists of data for ONE specific vehicle in the simulation.

read_or_update_simVehTrajectory();
dataFiles = dir(findCalibrationFolder.temp_vehicles());

% Load all available data into workspace
data = [];
for i = 3:size(dataFiles,1) % First two files are '.' and '..'?
   filename = dataFiles(i).name;
   data = [data; load(filename)];  
end

simulationFiles = {fileList.name};
tmp_names = arrayfun(@(x) erase(x,'VehicleInf_'),simulationFiles);
indices = cell2mat(arrayfun(@(x) strfind(x,'_'),tmp_names))-1;
simNames = arrayfun(

% for i = 1:size(fileList,1) % Loop through each file
%    simName = erase(erase(fileList(i).name,'DetectorData_'),'.csv');
%    
% end