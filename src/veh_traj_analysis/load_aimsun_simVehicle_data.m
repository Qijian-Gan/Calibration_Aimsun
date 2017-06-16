classdef load_aimsun_simVehicle_data
    properties
        folderLocation          % Location of the folder that stores the simVehicle data files
        outputFolderLocation    % Location of the output folder

        fileList                % Obtain the file list inside the folder
    end
    
    methods ( Access = public )
        
        function [this]=load_aimsun_simVehicle_data(folder,outputFolder)
            %% This function is to load the simVehicle data file
            
            if nargin>0
                this.folderLocation=folder;
                this.outputFolderLocation=outputFolder;
            else
                % Default folder location
                this.folderLocation=findCalibrationFolder.simVehTrajectory;
                this.outputFolderLocation=findCalibrationFolder.temp_vehicles;
            end   
            
            tmp=dir(this.folderLocation);
            this.fileList=tmp(3:end);
            
        end
        
        function [data]=parse_csv(this,file, location)
            % This function is to parse the csv file with only number inputs
            
            % Get the simulation date and time
            tmp=strsplit(file,'.');
            tmp=strsplit(tmp{1},'_');
            SimulationTime=tmp{2};
            InputFormat='yyyy-MM-dd HHmmss';
            SimulationTime=datenum(datetime(SimulationTime,'InputFormat',InputFormat));
            
            % Open the file
            tmp_data=csvread(fullfile(location,file),1,0); % Skip the header
            
            % Get wrong simulated vehicles
            idx=(tmp_data(:,6)<0 | tmp_data(:,9)==0 |tmp_data(:,10)==0 ); % Lane ID not negative, and OD ID greater than zero
            wrong_veh=unique(tmp_data(idx,2)); % Get the set of wrong simulated vehicles
            clear idx
            
            % Remove wrong vehicles
            idx=ismember(tmp_data(:,2),wrong_veh);
            data=tmp_data(~idx,:);

            data=[data,SimulationTime*ones(size(data,1),1)];

        end
        
        function save_data(this,data)
            %This function is used to save the data based on the section
            %IDs
            
            % Get the list of sections
            sections=unique(data(:,4));
            numSections=length(sections);
            
            % Loop for each section
            for i=1:numSections
                idx=(data(:,4)==sections(i));
                dataSection=data(idx,:); % Select data for a given section
                
                % Get the file name
                fileName=fullfile(this.outputFolderLocation,sprintf('SimVehInSection_%d.mat',sections(i)));
                
                if(exist(fileName,'file')) % If the file exists
                    load(fileName); % Variable: 'vehSectionAll'   
                    vehSectionAll=[vehSectionAll;dataSection];
                    vehSectionAll=unique(vehSectionAll,'rows'); % Get unique values
                else    
                    % If it is the first time
                    vehSectionAll=dataSection;                    
                end
                
                % Save the health report
                save(fileName,'vehSectionAll');                
            end
            
        end
        
    end
    
     methods ( Static)

       
     end
end

