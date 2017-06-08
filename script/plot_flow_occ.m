%% Plot flow vs. occupany for different demand profiles 
%close all

%% Extract flow vs. occupancy for all simulations at given intersection

% Extract data
read_or_update_simDetectorData;

numSimulations = length(dp.fileList);
for i = 1:numSimulations
    % -Read SimulationTime to separate out unique simluations
    % -Vectorize data fields across time steps (use horzcat as below)
    % -Plot flow/occ, flow/time, occ/time (last two on same plot: use yyaxis
    %   function) for each detector
    % -Save each detector plot as .fig and .png
    % -Combine detector plots into one subplot, maybe organize by advanced
    %   and stopbar detectors
    % 
    
    % Merge data fields into one vector
    ExternalIDs = horzcat(data.DetectorExternalID); % Do this for other fields too
    
    
end





%% Plot Flow vs Occ

% available_colors = linspace(1,10,6);
% colors = [];
% 
%%% To do: clean up colors assignments, get rid of idInf %%%
% for i = 1:length(flow)
%    time = idInf(i,1);
%    if time < 21600
%        colors(i) = available_colors(1);
%    elseif time < 32400
%        colors(i) = available_colors(6);
%    elseif time < 55800
%        colors(i) = available_colors(1);
%    elseif time < 68400
%        colors(i) = available_colors(6);
%    elseif time < 75600
%        colors(i) = available_colors(1);
%    else
%        colors(i) = available_colors(1);
%    end
% end
% 
% figure(1)
% 
% subplot(2,2,1)
% set(gca,'FontSize',11);
% xlabel('Occupancy');
% ylabel('Flow');
% %scatter(flow, occupancy, [], color);
% scatter(occupancy, flow,[], colors);
% title('Flow vs Occupancy');
% 
% 
% 
% 
% subplot(2,2,2)
% set(gca,'FontSize',11);
% xlabel('Time');
% ylabel('Flow');
% scatter(Timesec, flow,[], colors);
% title('Flow vs Time');
% 
% subplot(2,2,3)
% set(gca,'FontSize',11);
% xlabel('Time');
% ylabel('Occupancy');
% scatter(Timesec, occupancy, [], colors);
% title('Occupancy vs Time');







