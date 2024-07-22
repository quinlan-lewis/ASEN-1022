%% Lab 1 Dogbone 
% Christian Williams
% 109049716

clc; clear; close all
%Read in data
BritData= readmatrix('ASEN1022_Feb21_Brittle_Data.csv');
DuctData = readmatrix('ASEN1022_Jan28_Ductile_Data.csv');

% Sort data into vectors

BritCrosshead = BritData(:,1); %in
DuctCrosshead = DuctData(:,1);

BritLoad = BritData(:,2); % Ibf
DuctLoad = DuctData(:,2);

BritTime = BritData(:,3); %sec
DuctTime = DuctData(:,3); 

BritExtenso = BritData(:,4); %in
DuctExtenso = DuctData(:,4); 

% Remove outliers from data

outliers = isoutlier(BritExtenso);  % Britile outlier deletion
BritExtenso(outliers) = [];

outliersD = isoutlier(DuctExtenso); % Ductile outlier deletion
DuctExtenso(outliersD) = [];
% Calculate Stress Based on Load

A0_Brit= 0.504 * 0.187 ; %in
A0_Duct = 0.5 * 0.191; 

Stress_Brit = BritLoad / A0_Brit ;
Stress_Brit(outliers) = [];
Stress_Duct = DuctLoad / A0_Duct ; 
Stress_Duct(outliersD) = [] ; % deleting outlier indices from Ductile Stress Vector



% Calculate strain

gauge_length_int = 1; % in 

 for i = 1: length(BritExtenso)-1
     Strain_Brit(i,1) =( BritExtenso(i+1) ) / gauge_length_int;
 end
    
for i = 1: length(DuctExtenso)-1
     Strain_Duct(i,1) =( DuctExtenso(i+1) ) / gauge_length_int;
 end
Stress_Duct(end) = [];
% Scatter Plot for Both materials
% Assuming that the cross sectional area remains constant to calculate stress when in reality
% it is changing. 
%% Ductile
subplot(1,2,1)
scatter(Strain_Duct,Stress_Duct)
xlabel('Strain');
ylabel('Stress');
title('Ductile Strain vs Stress')
    hold on;

Stress_Brit(end) = [];
index = 135;
Youngs_D = Strain_Duct(1:index) \ Stress_Duct(1:index) ;
yCalc = Youngs_D*Strain_Duct ;
strain_2 = 0.002+Strain_Duct(1:index);

plot((strain_2),yCalc(1:index),'r','linewidth',3)

% txt = 'Yield Strength';
% text(0.006028,38920,txt,'HorizontalAlignment','right')
% txt = 'Yield Strength';
% text(Strain_Duct(465),42915,txt,'HorizontalAlignment','right')
hold off;
YS_D = 38920; 
UltimateT_D = max(Stress_Duct);
Fracture_D = Stress_Duct(end-1);
%% Brittle
subplot(1,2,2)
scatter(Strain_Brit,Stress_Brit)
xlabel('Strain');
ylabel('Stress');
title('Brittle Strain vs Stress')
UltimateT_B = max(Stress_Brit);
hold on;
index = 100;
Youngs_B = Strain_Brit(1:index) \ Stress_Brit(1:index) ;
yCalcB = Youngs_B*Strain_Duct ;

% plot(Strain_Brit(1:100),yCalcB(1:100),'b--','LineWidth',3)


% Youngs_D = Strain_Duct \ Stress_Duct ;
% yCalc = Youngs_D*Strain_Duct ;
% 
% Youngs_B = Strain_Brit \ Stress_Brit ;
% yCalcB = Youngs_B*Strain_Brit ;



% p=polyfit(Strain_Duct, Stress_Duct,1)
% yfit = polyval(p,Strain_Duct);
% plot(yfit,Strain_Duct)
% hold off;
