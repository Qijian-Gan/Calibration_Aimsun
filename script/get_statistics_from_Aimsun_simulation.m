%% This script is to get the statistics from Aimsun simulation
clear
clc
close all

%% Define the set of links belonging to the same approach
% Huntington & Second
AppNB=[458, 631]; % Northbound
AppSB=[24680,531]; % Southbound
AppEB=[24650,569]; % Eastbound
AppWB=[563]; % Westbound

%% Load the simVehicle data provider
dp=simVehicle_data_provider_Aimsun;
% Settings
Distance=60;
From=7*3600;
Duration=300;
To=From+Duration;
TimePeriod=[From To];

AppNBData=dp.get_statistics_for_section_time(AppNB, TimePeriod, Distance);
AppSBData=dp.get_statistics_for_section_time(AppSB, TimePeriod, Distance);
AppEBData=dp.get_statistics_for_section_time(AppEB, TimePeriod, Distance);
AppWBData=dp.get_statistics_for_section_time(AppWB, TimePeriod, Distance);