function plot_and_save(flow,occ,time,simName,detectorName)
close all
    % Create 2x1 subplot of:
        % flow vs. occ
        % flow vs. time, occ vs. time on double y-axis
    % 
    fig = figure('Visible','off'); % doesn't work, figure still pops up
    
    subplot(1,2,1);
    set(gca,'FontSize',8);
    suptitle({strcat('Simulation: ',simName,', Detector: ',detectorName), ' '});
    
    % Flow vs. occupancy
    % Separate by AM/PM
    middle_index = floor(size(time,2)/2); % Finds middle of day (noon)
    scatter(occ(1:middle_index),flow(1:middle_index));
    hold on
    scatter(occ(middle_index:end),flow(middle_index:end));
    title('Flow vs. Occupancy');
    xlabel('Occupancy');
    ylabel('Flow');
    legend('AM','PM');
    legend boxoff
    hold off
    
    
    % Flow and Occupancy vs. Time
    subplot(1,2,2);
    set(gca,'FontSize',8);
    yyaxis left
    scatter(time, flow);
    xlabel('Time');
    ylabel('Flow');
    title('Flow and Occupancy vs. Time');
    
    yyaxis right
    scatter(time,occ);
    ylabel('Occupancy');
    
    save_figure(fig,simName,detectorName);
    
end
