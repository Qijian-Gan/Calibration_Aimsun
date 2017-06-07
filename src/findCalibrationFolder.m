classdef findCalibrationFolder
    
    methods(Static)
                
        function [x] = root()
            here = fileparts(mfilename('fullpath'));
            x = fileparts(here);
        end
        
        function [x] = simDetectorData()
            x = fullfile(findCalibrationFolder.root,'data\simDetector');
        end
        
        function [x] = simVehTrajectory()
            x = fullfile(findCalibrationFolder.root,'data\simVehTrajectory');
        end
        
        function [x] = estStateQueue_data()
            x = fullfile(findCalibrationFolder.root,'data\estStateQueueData');
        end
        
        function [x] = source()
            x = fullfile(findCalibrationFolder.root,'src');
        end
        
        function [x] = reports()
            x = fullfile(findCalibrationFolder.root,'reports');
        end
                
        function [x] = config()
            x = fullfile(findCalibrationFolder.root,'config');
        end
                
        function [x] = temp()
            x = fullfile(findCalibrationFolder.root,'temp');
        end
                
        function [x] = objects()
            x = fullfile(findCalibrationFolder.root,'obj');
        end
        
        function [x] = outputs()
            x = fullfile(findCalibrationFolder.root,'output');
        end
        
    end
    
end

