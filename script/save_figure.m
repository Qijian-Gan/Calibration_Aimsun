%% Save figure
function save_figure(fig,simName,detectorName,type)
    % Save figure as .fig and .png under output folder
    % Save in output\figures for .fig, output\images for .png
    folder = findCalibrationFolder.outputs();
    if type == 1
        figName = horzcat('\demand3_',erase(strcat(simName,'-',detectorName),' '),'_flow_occ');
    else
        figName = horzcat('\demand3_',erase(strcat(simName,'-',detectorName),' '),'_flow_occ_time');
    end
    saveas(fig,strcat(folder,strcat('\figures',figName,'.fig')));
    saveas(fig,strcat(folder,strcat('\images',figName,'.png')));
    
end


