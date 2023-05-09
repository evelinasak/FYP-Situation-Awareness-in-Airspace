%PART 7: This part of the code plots all elliptical states with
%corresponding TP clusters and extracts observations sequences for the HMM
%modelling 
%% SECTION 1: All elliptical states are plotted with corresponding TP clusters
% all states are plotted around the runways
row_num1 = height(max_tp_all1);
row_num2 = height(max_tp_all2);
row_num3 = height(max_tp_all3);
row_num4 = height(max_tp_all4);
row_num5 = height(max_tp_all5);

%STATE1
for row = 1:row_num1
    x = max_tp_all1.P_NORTH(row);
    y = max_tp_all1.P_EAST(row); 
    
    plot(x,y,'r.', 'MarkerSize', 5)
    hold on
end
%STATE1 hyperparameters
r1_1 =  0.006677336641054;
r2_1 = 0.017485491595638;
ang_1 = -0.056479360989006;
x0_1 = -1.621997761557327;
y0_1 = 52.211766740021702;

q1 = [r1_1,r2_1,ang_1,x0_1,y0_1]; %state description used for modelling
ellipse(r1_1,r2_1,ang_1,x0_1,y0_1)
hold on

%STATE2
for row = 1:row_num2
    x = max_tp_all2.P_NORTH(row);
    y = max_tp_all2.P_EAST(row); 
    
    plot(x,y,'r.', 'MarkerSize', 5)
    hold on
end
%STATE2 hyperparameters
r1_2 =  0.010203088663312;
r2_2 = 0.018482810705987;
ang_2 =  -0.407267631674971;
x0_2 = -1.637749519354129;
y0_2 = 52.215198720858986;

q2 = [r1_2,r2_2,ang_2,x0_2,y0_2]; %state description used for modelling
ellipse(r1_2,r2_2,ang_2,x0_2,y0_2)
hold on


%STATE3
for row = 1:row_num3
    x = max_tp_all3.P_NORTH(row);
    y = max_tp_all3.P_EAST(row); 
    
    plot(x,y,'r.', 'MarkerSize', 5)
    hold on
end
%STATE3 hyperparameters
r1_3 =  0.013469491984416;
r2_3 = 0.033323724991420;
ang_3 =  -0.074890874283384;
x0_3 = -1.634549874749108;
y0_3 = 52.172532798823568;

q3 = [r1_3,r2_3,ang_3,x0_3,y0_3]; %state description used for modelling
ellipse(r1_3,r2_3,ang_3,x0_3,y0_3)
hold on

%STATE4
for row = 1:row_num4
    x = max_tp_all4.P_NORTH(row);
    y = max_tp_all4.P_EAST(row); 
    
    plot(x,y,'r.', 'MarkerSize', 5)
    hold on
end
%STATE4 hyperparameters
r1_4 = 0.009230483905532;
r2_4 = 0.031872609277625;
ang_4 = 0.056416499431396;
x0_4 = -1.613225998604898;
y0_4 = 52.169718269292851;

q4 = [r1_4,r2_4,ang_4,x0_4,y0_4]; %state description used for modelling
ellipse(r1_4,r2_4,ang_4,x0_4,y0_4)
hold on

%STATE5
for row = 1:row_num5
    x = max_tp_all5.P_NORTH(row);
    y = max_tp_all5.P_EAST(row); 
    plot(x,y,'r.', 'MarkerSize', 5)
    hold on
end
%STATE5 hyperparameters
r1_5 =   7.391457035758395e-04;
r2_5 = 0.006738648820251;
ang_5 =  0.093075913302387;
x0_5 = -1.615749417176270;
y0_5 =  52.203934166550106;

q5 = [r1_5,r2_5,ang_5,x0_5,y0_5]; %state description used for modelling
ellipse(r1_5,r2_5,ang_5,x0_5,y0_5)
hold on

%%plotting runways
%runway1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686  , -1.613438, -1.614142, -1.615369];
plot(lon1, lat1, "black", 'LineWidth',3)
hold on
grid on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)

hold on

title('Runway 1 Landing Pattern States and TP Clusters')
xlabel('Longitude')
ylabel('Latitude')
xlim([-1.7, -1.54])
ylim([52.136, 52.24])

%% SECTION 2: This section extracts sequences of each trajectory. Each sequence is extracted individually: sequence number needs to be changed each iteration

seq_num = 75; %number of data sequences
sz = [1 3];
varTypes = ["double", "double", "datetime"];
varNames = ["P_NORTH", "P_EAST", "TIME"];
seq75 = table('Size', sz, 'VariableTypes', varTypes, 'VariableNames', varNames) %change seq number each time whe creating a sequence

i=1; %trajectory number of which sequence do you want
traj_num = 75; %!!!change traj_num every time sequence number is changed
rows1 = height(max_tp_all1);
rows2 = height(max_tp_all2);
rows3 = height(max_tp_all3);
rows4 = height(max_tp_all4);
rows5 = height(max_tp_all5);

%extracting TPs from the STATE1 for traj_num trajectory
for row = 1:rows1
    if max_tp_all1.TRAJ_NUM(row) == traj_num;
        max_tp_all1.P_NORTH(row)
        max_tp_all1.P_EAST(row)
        seq75.P_NORTH(i) = max_tp_all1.P_NORTH(row);
        seq75.P_EAST(i) = max_tp_all1.P_EAST(row);
        seq75.TIME(i) = max_tp_all1.TIME(row);
        seq75.STATE(i) = max_tp_all1.STATE(row);
        i = i+1;
    end
end
%extracting TPs from the STATE2 for traj_num trajectory
for row = 1:rows2
    if max_tp_all2.TRAJ_NUM(row) == traj_num;
        max_tp_all2.P_NORTH(row)
        max_tp_all2.P_EAST(row)
        seq75.P_NORTH(i) = max_tp_all2.P_NORTH(row);
        seq75.P_EAST(i) = max_tp_all2.P_EAST(row);
        seq75.TIME(i) = max_tp_all2.TIME(row);
        seq75.STATE(i) = max_tp_all2.STATE(row);
        i = i+1;
    end
end
%extracting TPs from the STATE3 for traj_num trajectory
for row = 1:rows3
    if max_tp_all3.TRAJ_NUM(row) == traj_num;
        max_tp_all3.P_NORTH(row)
        max_tp_all3.P_EAST(row)
        seq75.P_NORTH(i) = max_tp_all3.P_NORTH(row);
        seq75.P_EAST(i) = max_tp_all3.P_EAST(row);
        seq75.TIME(i) = max_tp_all3.TIME(row);
        seq75.STATE(i) = max_tp_all3.STATE(row);
        i = i+1;
    end
end
%extracting TPs from the STATE4 for traj_num trajectory
for row = 1:rows4
    if max_tp_all4.TRAJ_NUM(row) == traj_num;
        max_tp_all4.P_NORTH(row)
        max_tp_all4.P_EAST(row)
        seq75.P_NORTH(i) = max_tp_all4.P_NORTH(row);
        seq75.P_EAST(i) = max_tp_all4.P_EAST(row);
        seq75.TIME(i) = max_tp_all4.TIME(row);
        seq75.STATE(i) = max_tp_all4.STATE(row);
        i = i+1;
    end
end
%extracting TPs from the STATE5 for traj_num trajectory
for row = 1:rows5
    if max_tp_all5.TRAJ_NUM(row) == traj_num;
        max_tp_all5.P_NORTH(row)
        max_tp_all5.P_EAST(row)
        seq75.P_NORTH(i) = max_tp_all5.P_NORTH(row);
        seq75.P_EAST(i) = max_tp_all5.P_EAST(row);
        seq75.TIME(i) = max_tp_all5.TIME(row);
        seq75.STATE(i) = max_tp_all5.STATE(row);
        i = i+1;
    end
end

%% SECTION 3: divides the airspace into 36x18 grid 
%grid boundaries
lon_range = [-1.65, -1.61];
lat_range = [52.136, 52.234];
n_rows = 18;
n_columns = 36;

%grid steps
lon_step = (lon_range(2)-lon_range(1))/n_columns;
lat_step = (lat_range(2)-lat_range(1))/n_rows;

%longitude and lattitude vectors (steps)
lon_vec = linspace(lon_range(1),lon_range(2),n_columns+1);
lat_vec = linspace(lat_range(1), lat_range(2),n_rows+1);

%create grid
[lon_grid, lat_grid] = meshgrid(lon_vec,lat_vec)
figure
plot(lon_grid,lat_grid,'k')
hold on
plot(lon_grid', lat_grid', 'k')

% Define the x and y coordinates of the centers of each grid square
x_grid_coord = repmat(lon_vec(1:end-1), n_rows, 1) + lon_step/2; %x coordinate of circle in each grid square
y_grid_coord = repmat(lat_vec(1:end-1)', 1, n_columns) + lat_step/2; %y coordinate of circle in each grid square

plot(x_grid_coord(:), y_grid_coord(:), 'bo') %plotting the circles in the middle of each grid cell
hold on

%plotting a specific dot on the grid 
spec_circle = 463; %define in which grid the specific circle is
row_round = floor(spec_circle/n_columns); %round the number to the closest integer
row_num = row_round+1;
column_num = spec_circle - row_round*36;

x_spec_circle = x_grid_cord(row_num, column_num)
y_spec_circle = y_grid_cord(row_num, column_num)
plot(x_spec_circle, y_spec_circle, 'r*')

%%plotting runways
%runway1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686  , -1.613438, -1.614142, -1.615369];
plot(lon1, lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)
xlim([-1.7, -1.54])
ylim([52.14, 52.24])
hold on
title('Observation grid')
xlabel('Longitude')
ylabel('Latitude')
xlim([-1.65, -1.61])
ylim([52.136, 52.234])

%% SECTION 4: assigning a number to each grid cell
grid = zeros(n_rows, n_columns);

for i = 1:n_rows
    for j = 1:n_columns
        grid(i,j) = (i-1)*n_columns +j; 
    end
end

%% SECTION 5: assigning a grid number to each point (longitude,latitude)
data = [seq75.P_NORTH(:), seq75.P_EAST(:)];
rows = length(data)
seq75.GRID_NUM = zeros(size(data,1),1); %initializing zeros in the new column where a grid number will be assigned
for i = 1:rows
    lon_grid = ceil((data(i,1) - lon_range(1)) / lon_step);
    lat_grid = ceil((data(i,2) - lat_range(1)) / lat_step);
    seq75.GRID_NUM(i) = (lat_grid-1) * n_columns + lon_grid; 
end




