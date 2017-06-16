classdef load_aimsun_detector_data
    properties
        folderLocation        % Location of the folder that stores the data files
        outputFolderLocation  % Location of the output folder
        
        fileList              % Obtain the file list inside the folder
    end
    
    methods ( Access = public )
        
        function [this]=load_aimsun_detector_data(folder,outputFolder)
            %% This function is to load the detector data file
            
            if nargin>0
                this.folderLocation=folder;
                this.outputFolderLocation=outputFolder;
            else
                % Default folder location
                this.folderLocation=findCalibrationFolder.simDetectorData;
                this.outputFolderLocation=findCalibrationFolder.temp_detectors;
            end            
            
            % Get the list of files
            tmp=dir(this.folderLocation);
            this.fileList=tmp(3:end);
            
        end
        
        function [data]=parse_csv(this,file, location)
            %% This function is to parse the csv file with both string and number inputs
            
            % Open the file
            fileID = fopen(fullfile(location,file));

            % Get the simulation date and time
           
            tmp=strsplit(file,'.');
            tmp=strsplit(tmp{1},'_');
            SimulationTime=tmp{2};
            InputFormat='yyyy-MM-dd HHmmss';
            SimulationTimeDouble=datenum(datetime(SimulationTime,'InputFormat',InputFormat));
            
            % Start to read the data
            data=[];
            tline=fgetl(fileID); % Ignore the first line
            tline=fgetl(fileID); % Starting from the second line
            count=0;
            while ischar(tline)
                
                % Example: 4115	508102	21900	0	0
                tmp = textscan(tline,'%d %d %d %d %f','Delimiter',',','EmptyValue',-Inf);
                
                % Get the detector ID
                DetectorID=tmp{1};  
                DetectorExternalID=tmp{2};
                Time=tmp{3};
                Volume=tmp{4};
                Occupancy=tmp{5};
                
                tmpData=load_aimsun_detector_data.dataFormat...
                    (DetectorID,DetectorExternalID,SimulationTime,SimulationTimeDouble,Time,Volume,Occupancy);
                data=[data;tmpData];
                tline=fgetl(fileID);
            end
            
            % Close the file
            fclose(fileID);
        end
        
        function save_data(this,data)
            
            uniqueDetectorID=unique([data.DetectorExternalID]');
            numDetector=length(uniqueDetectorID);
            
            for i=1:numDetector
                idx=ismember([data.DetectorExternalID]',uniqueDetectorID(i));
                fileName=fullfile(this.outputFolderLocation,sprintf('simDetector_%d.mat',uniqueDetectorID(i)));
               
                if(exist(fileName,'file')) % If the file exists
                    load(fileName);
                    detectorDataAll=[detectorDataAll;data(idx,:)]; 
                    simDateTime=strcat({detectorDataAll.SimulationTime}',num2str([detectorDataAll.Time]'));
                    [~,I]=unique(simDateTime);
                    detectorDataAll=detectorDataAll(I,:);
                else    
                    % If it is the first time
                    detectorDataAll=data(idx,:);                    
                end
                
                % Save the health report
                save(fileName,'detectorDataAll');
            end
            
        end
    end
    
     methods ( Static)
         
         function [dataFormat]=dataFormat(DetectorID,DetectorExternalID,SimulationTime,SimulationTimeDouble,...
                 Time,Volume,Occupancy)
             %% This function is used to return the structure of data format (From Aimsun)
             
             if(nargin==0)
                 dataFormat=struct(...
                     'DetectorID',           nan,...
                     'DetectorExternalID',   nan,...
                     'SimulationTime',       nan,...
                     'SimulationTimeDouble', nan,...
                     'Time',                 nan,...
                     'Volume',               nan,...
                     'Occupancy',            nan);
             else
                 dataFormat=struct(...
                     'DetectorID',           DetectorID,...
                     'DetectorExternalID',   DetectorExternalID,...
                     'SimulationTime',       SimulationTime,...
                     'SimulationTimeDouble', SimulationTimeDouble,...
                     'Time',                 Time,...
                     'Volume',               Volume,...
                     'Occupancy',            Occupancy);
             end
         end
         
     end % methods
end % classdef

