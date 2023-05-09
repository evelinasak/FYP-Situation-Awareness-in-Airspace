%%plotting the runways
%Origin of the ENU coordinates
lat0 = 52.192222;
lon0 = -1.614444;
%Runway 1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];
runway1 = table(lat1, lon1)
xlim([-1.75122, -1.48]) %sets axis limits based on the selected airspace frame 
ylim([52.10803, 52.27471])

plot(runway1.lon1, runway1.lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
runway2 = table(lat2, lon2)

plot(runway2.lon2, runway2.lat2, "black",'LineWidth',3)
xlim([-1.75122, -1.48]) %sets axis limits based on the selected airspace frame 
ylim([52.10803, 52.27471])
hold on


plot(x1,x1,'o-')
hold on
title('Airfield Runways for Clustering');
xlabel('Longitude');
ylabel('Latitude');
hold on

%Runway 1 points
x0 = -1.614444; %x coordinate lon0
y0 = 52.192222; %y coordinate lat0
x1 = -1.615369;
x2 = -1.614686;
y1 = 52.197463;
y2 = 52.197447;
x3 = -1.614142;
y3 = 52.186519;
x4 = -1.613438;
y4 = 52.186530;
P1 = [x1, y1]; %Runway 1 corner point 1
P2 = [x2, y2]; %Runway 1 corner point 2
P3 = [x3, y3]; %Runway 1 corner point 3
P4 = [x4, y4]; %Runway 1 corner point 4
plot(x0, y0, 'g.', 'MarkerSize', 10) %centre of the runways
plot(x1, y1, 'g.', 'MarkerSize', 10) %left corner point 1 R1_CP1
plot(x2, y2, 'g.', 'MarkerSize', 10) %right corner point 2 R1_CP2
plot(x3, y3, 'g.', 'MarkerSize', 10) %left corner point 3 R1_CP3
plot(x4, y4, 'g.', 'MarkerSize', 10) %right corner point 4 R1_CP4
hold on
R1_P1 = (P1(:) + P2(:)).'/2 %middle point 1
R1_P2 = (P3(:) + P4(:)).'/2 %middle point 2
plot(R1_P1(1,1), R1_P1(1,2), 'r.', 'MarkerSize', 10) %plotting R1_P1
plot(R1_P2(1,1), R1_P2(1,2), 'r.', 'MarkerSize', 10) %plotting R2_P2

% %Runway 1 boxes
% %around R1_P1 BOX 1
% latB1=[52.1978, 52.1978, 52.197, 52.197, 52.1978];
% lonB1=[-1.6155, -1.6145, -1.6145, -1.6155, -1.6155];
% runway1_B1 = table(latB1, lonB1)
% plot(runway1_B1.lonB1, runway1_B1.latB1, "black", 'LineWidth',1)
% 
% %around R1_P2 BOX 2
% latB2 = [52.1875, 52.1875, 52.186, 52.186, 52.1875]
% lonB2 = [-1.615, -1.613, -1.613, -1.615, -1.615]
% runway1_B2 = table(latB2, lonB2)
% plot(runway1_B2.lonB2, runway1_B2.latB2, "black", 'LineWidth',1)
%  
% %Runway 2 boxes
% %around R2_P1 BOX 3
% latB3 = [52.1935, 52.1935, 52.192, 52.192, 52.1935]
% lonB3 = [-1.61, -1.607, -1.607, -1.61, -1.61]
% runway2_B3 = table(latB3, lonB3)
% plot(runway2_B3.lonB3, runway2_B3.latB3, "black", 'LineWidth',1)
% 
% %around R2_P2 BOX 4
% latB4 = [52.1875, 52.1875, 52.1865, 52.1865, 52.1875]
% lonB4 = [-1.619, -1.617, -1.617, -1.619, -1.619]
% runway2_B4 = table(latB4, lonB4)
% plot(runway2_B4.lonB4, runway2_B4.latB4, "black", 'LineWidth',1)

%%Expanded boxes
%Runway 1 boxes
%around R1_P1 BOX 1
latB1=[52.207, 52.207, 52.197, 52.197, 52.207];
lonB1=[-1.618, -1.612, -1.612, -1.618, -1.618];
runway1_B1 = table(latB1, lonB1)
plot(runway1_B1.lonB1, runway1_B1.latB1, "black", 'LineWidth',1)
grid on

%around R1_P2 BOX 2
latB2 = [52.187, 52.187, 52.182, 52.182, 52.187]
lonB2 = [-1.615, -1.612, -1.612, -1.615, -1.615]
runway1_B2 = table(latB2, lonB2)
plot(runway1_B2.lonB2, runway1_B2.latB2, "black", 'LineWidth',1)

%Runway 2 boxes
%around R2_P1 BOX 3
latB3 = [52.195, 52.195, 52.192, 52.192, 52.195]
lonB3 = [-1.612, -1.604, -1.604, -1.612, -1.612]
runway2_B3 = table(latB3, lonB3)
plot(runway2_B3.lonB3, runway2_B3.latB3, "black", 'LineWidth',1)

%around R2_P2 BOX 4
latB4 = [52.188, 52.188, 52.185, 52.185, 52.188]
lonB4 = [-1.622, -1.617, -1.617, -1.622, -1.622]
runway2_B4 = table(latB4, lonB4)
plot(runway2_B4.lonB4, runway2_B4.latB4, "black", 'LineWidth',1)

%Runway 2 points
x5 = -1.608952;
y5 = 52.192900;
x6 = -1.608280;
y6 = 52.192694;
x8 = -1.617580;
y8 = 52.186931;
x7 = -1.618084;
y7 = 52.187281;
P5 = [x5, y5]; %point 1
P6 = [x6, y6]; %point 2
P8 = [x8, y8]; 
P7 = [x7, y7]; 
plot(x5, y5, 'g.', 'MarkerSize', 10) %left corner point 1 R2_CP1
plot(x6, y6, 'g.', 'MarkerSize', 10) %right corner point 1 R2_CP2
plot(x7, y7, 'g.', 'MarkerSize', 10) %left corner point 1 R2_CP3
plot(x8, y8, 'g.', 'MarkerSize', 10) %right corner point 1 R2_CP4

hold on
R2_P1 = (P5(:) + P6(:)).'/2 %middle point 1
R2_P2 = (P7(:) + P8(:)).'/2 %middle point 2
plot(R2_P1(1,1), R2_P1(1,2), 'r.', 'MarkerSize', 10) %plotting R2_P1
plot(R2_P2(1,1), R2_P2(1,2), 'r.', 'MarkerSize', 10) %plotting R2_P2

plot(traj_for_clust.P_NORTH(10), traj_for_clust.P_EAST(10), 'g.', 'MarkerSize', 10);
% plot(traj_for_clust.P_NORTH(155), traj_for_clust.P_EAST(155), 'g.', 'MarkerSize', 10) %first is green
% plot( traj_for_clust.P_NORTH(156), traj_for_clust.P_EAST(156), 'b.', 'MarkerSize', 10) %last is blue
% plot(lon0, lat0, 'r.', 'MarkerSize', 20)
hold on, grid on

%%modelling boxes

