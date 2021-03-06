%% This script is to read the simulated vehicle trajectory data files
clear
clc
close all

%% Load the list of files to be updated
% Load the list of files that have been read if it exists (saved in the 'Obj' folder)
folderLocation=findCalibrationFolder.objects;

fileName=fullfile(folderLocation,'simVehTraj_file_have_been_read_Aimsun.mat');
folderLocation=findCalibrationFolder.simVehTrajectory();
outputFolderLocation=findCalibrationFolder.temp_vehicles();

if(exist(fileName,'file'))
    % If found
    load(fileName);
else
    fileRead=[]; % This is the variable save in the mat file 'simVehTraj_file_have_been_read_Aimsun.mat'
end

% Load the simVehicle data and get the list of files that is needed to be updated
dp=load_aimsun_simVehicle_data(folderLocation,outputFolderLocation);
fileList=dp.fileList; % Get the list of detector files

%% Read the data
numFile=size(fileList,1);

tmpList=[];
data=[];
for i=1:numFile
    fprintf('File number: %d\n', i);
    if(isempty(fileRead) || ~any(strcmp({fileList(i).name},fileRead))) % Empty or Not yet read
        % Parse data
        tmp_data=dp.parse_csv(fileList(i).name,dp.folderLocation);
        % Time,VehicleID,Type,SectionID,SegmentID,NumLane,CurPosition,CurrentSpeed,CentroidOrigin,
        % CentroidDestination,DistanceToEnd,StatusLeft,StatusRight,StatusStop,NextSection,SimulationTime(Scenario)
        data=[data;tmp_data];
        tmpList=[tmpList;{fileList(i).name}];
    end
end
if(~isempty(data))
    dp.save_data(data);
end

% Save the files that have been read
fileRead=[fileRead;tmpList];
save(fileName,'fileRead');



