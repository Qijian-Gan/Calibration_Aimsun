%% Plot flow vs. occupany for different demand profiles 
%close all

%% Extract flow vs. occupancy for all simulations at given intersection

intID = '6082'; % Huntington & 2nd intersection
IDstrings = num2str(DetectorFieldID);
idInf = [];
for (i = 1:length(DetectorFieldID))
   if (IDstrings(i,1:4) == intID)
      idInf =  [idInf; Timesec(i) flow(i) occupancy(i)];
   end
end


%% Plot Flow vs Occ

available_colors = linspace(1,10,6);
colors = [];

for i = 1:length(idInf)
   time = idInf(i,1);
   if time < 21600
       colors(i) = available_colors(1);
   elseif time < 32400
       colors(i) = available_colors(6);
   elseif time < 55800
       colors(i) = available_colors(1);
   elseif time < 68400
       colors(i) = available_colors(6);
   elseif time < 75600
       colors(i) = available_colors(1);
   else
       colors(i) = available_colors(1);
   end
end

figure(1)

subplot(2,2,1)
set(gca,'FontSize',11);
xlabel('Occupancy');
ylabel('Flow');
%scatter(flow, occupancy, [], color);
scatter(idInf(:,2), idInf(:,3),[], colors);
title('Flow vs Occupancy');




subplot(2,2,2)
set(gca,'FontSize',11);
xlabel('Time');
ylabel('Flow');
scatter(idInf(:,1), idInf(:,2),[], colors);
title('Flow vs Time');

subplot(2,2,3)
set(gca,'FontSize',11);
xlabel('Time');
ylabel('Occupancy');
scatter(idInf(:,1), idInf(:,3),[], colors);
title('Occupancy vs Time');







