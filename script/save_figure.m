%% Save figure
function save_figure(fig,simName,detectorName)
    % Save figure as .fig and .png under output folder
    % Save in output\figures for .fig, output\images for .png
    folder = findCalibrationFolder.outputs();
    figName = strcat('\',erase(strcat(simName,'-',detectorName),' '));
    saveas(fig,strcat(folder,strcat('\figures',figName,'.fig')));
    saveas(fig,strcat(folder,strcat('\images',figName,'.png')));
    close all
end


