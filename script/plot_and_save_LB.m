% For lane blockage detection simulations
function plot_and_save_LB(flow,occ,time,simName,detectorName)

    % Create 2 plots of:
        % 1. Flow vs. occupancy
        % 2. Flow vs. Time, Occupancy vs. Time on double y-axis
    
    color_gradient = linspace(1,10,length(flow));
    colors = [[121,204,55]; [20,20,204];[238,128,19];[166, 0, 250];...
        [2,153,59];[49,99,206];[203,51,0];[2,152,29]]./255; % RGB color triples
   
   
    figSize = [240, 160, 780, 450];
    % Flow vs. occupancy
    fig = figure('Visible','off','Position',figSize); 
    set(gca,'FontSize',12);
   
    % Flow vs. occupancy
    hold on
    title({'Flow vs. Occupancy';horzcat('Simulation:  ',simName,',  Detector:  ',...
        detectorName)});
    scatter(occ,flow,[],color_gradient);
    xlabel('Occupancy');
    ylabel('Flow');
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
