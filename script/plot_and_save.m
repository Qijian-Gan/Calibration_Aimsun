function plot_and_save(flow,occ,time,simName,detectorName)

    % Create 2 plots of:
        % 1. Flow vs. occupancy
        % 2. Flow vs. Time, Occupancy vs. Time on double y-axis
    
    colors = [[121,204,55]; [20,20,204];[238,128,19];[166, 0, 250];...
        [2,153,59];[49,99,206];[203,51,0];[2,152,29]]./255; % RGB color triples
   
    figSize = [240, 160, 780, 450];
    % Flow vs. occupancy
    fig = figure('Visible','off','Position',figSize); 
    set(gca,'FontSize',12);
   
    % Flow vs. occupancy
    % Separate by AM/PM
    middle_index = floor(size(time,2)/2); % Finds middle of day (noon)
    hold on
    title({'Flow vs. Occupancy';horzcat('Simulation:  ',simName,',  Detector:  ',...
        detectorName)});
    scatter(occ(1:middle_index),flow(1:middle_index),'MarkerFaceColor',colors(7,:),...
        'MarkerEdgeColor',colors(7,:));
    scatter(occ(middle_index:end),flow(middle_index:end),'MarkerFaceColor',colors(8,:),...
        'MarkerEdgeColor',colors(8,:));
    xlabel('Occupancy');
    ylabel('Flow');
    legend('AM','PM','Location','northwest');
    legend boxoff
    box on
    hold off
    
    save_figure(fig,simName,detectorName,1);
    
    % Flow and Occupancy vs. Time
    fig2 = figure('Visible','off','Position',figSize);
    set(fig2,'defaultAxesColorOrder',[colors(3,:); colors(6,:)]);
    set(gca,'FontSize',12);
    box on
    title({'Flow and Occupancy vs. Time';horzcat('Simulation:  ',simName,',  Detector:  ',...
        detectorName)});
    
    yyaxis left
    scatter(time, flow,'MarkerFaceColor',colors(3,:),'MarkerEdgeColor',colors(3,:));
    xlabel('Time [hours]');
    ylabel('Flow');
    
    yyaxis right
    scatter(time,occ,'MarkerFaceColor',colors(6,:),'MarkerEdgeColor',colors(6,:));
    ylabel('Occupancy');
    
    save_figure(fig2,simName,detectorName,2);

end
