%% This script is to read the simulated detector data files
clear
clc
close all

%% Load the list of files to be updated
% Load the list of files that have been read if it exists (saved in the 'Obj' folder)
folderLocation=findCalibrationFolder.objects;

fileName=fullfile(folderLocation,'simDetector_file_have_been_read_Aimsun.mat');
folderLocation=findCalibrationFolder.simDetectorData();
outputFolderLocation=findCalibrationFolder.temp_detectors();

if(exist(fileName,'file'))
    % If found
    load(fileName);
else
    fileRead=[]; % This is the variable save in the mat file 'simDetector_file_have_been_read_Aimsun.mat'
end

% Load the simVehicle data and get the list of files that is needed to be updated
dp=load_aimsun_detector_data(folderLocation,outputFolderLocation);
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