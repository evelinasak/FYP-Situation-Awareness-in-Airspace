%%PART 5: This code extracts turning points (points where aircraft changes its
%%heading)for each trajectory in the specified estimated elliptical states 

%% SECTION 1: TPs are extracted for each state (if statements need to be changed for each state) and extracted into separate max_tp_all_N files where N is the state number (needs to be changed for each state)
%%extracting the biggest change in heading (max TP) for each trajectory in

%%Runway 1 (landing)
h = height(runway_1_mode);
head_0 = ClustTraj1.HEADING(1); %previous heading
row4 = 1; %max_tp_all table rows

%create max_tp_all table
szz = [1 6]; %initial table size
varTypes = ["double", "double", "double", "double", "double", "datetime"]; %variable types
varNames = ["TRAJ_NUM", "ROW", "MAX_HEADING", "P_EAST", "P_NORTH", "TIME"]; %variable names
max_tp_all4 = table('Size', szz, 'VariableTypes', varTypes, 'VariableNames', varNames);

for row = 1:h %going through all the trajectories in runway 1(landing)
    row3 = 1; %counts rows in the TP (trajectory points) table
    TP = double.empty;
    head_1 = 0; %current heading
    count = 0; %count number of trajectory points
    traj_num = runway_1(row);
    if runway_1_mode.MODE(row) == 2
        display('direction correct') %for testing
    for row1 = 1 : 42187 %for loop to count how many entries are in the trajectory
        if ClustTraj1.TRAJECTORY(row1) == traj_num
            count = count+1;
            last_pt = row1; %last trajectory data entry point
        end
    end
    start = (last_pt-count+2); %starting for loop from 2nd trajectory point
        for row2 = start:(last_pt-1) %for loop from i = 2,... n-1 /this loop extracts all the turning points from a trajectory
        head_0 = ClustTraj1.HEADING(row2-1);
        if ClustTraj1.P_EAST(row2)<52.187 && ClustTraj1.P_EAST(row2)>52.136 && ClustTraj1.P_NORTH(row2)<-1.6 &&  ClustTraj1.P_NORTH(row2)>-1.623 %state 4
        %if ClustTraj1.P_EAST(row2)<52.235 && ClustTraj1.P_EAST(row2)>52.19851 && ClustTraj1.P_NORTH(row2)<-1.612 &&  ClustTraj1.P_NORTH(row2)>-1.628 %state 1  
        %if ClustTraj1.P_EAST(row2)<52.196 && ClustTraj1.P_EAST(row2)>52.135 && ClustTraj1.P_NORTH(row2)<-1.622 &&  ClustTraj1.P_NORTH(row2)>-1.648 %state 3
        %if ClustTraj1.P_EAST(row2)<52.234 && ClustTraj1.P_EAST(row2)>52.2&& ClustTraj1.P_NORTH(row2)<-1.628 &&  ClustTraj1.P_NORTH(row2)>-1.652   %state 2         
            row2;
            head_1 = ClustTraj1.HEADING(row2);
            abs_val = abs(head_1 - head_0)
            if abs_val>180 %check if the difference is above 180deg - it means it's in the wrong direction
                abs_val = 360 - abs_val; 
            end
            if (abs_val)>(1) && (abs_val) <(30) %check if the difference is above 1.5deg
                TP(row3,1) = row2 %write which trajectory point corresponds to this
                TP(row3,2) = abs_val %write the angle difference at this point
                row3 = row3+1;
            end 
            head_0 = head_1
         end
        end
        TF = isempty(TP); %check if TP is not empty
        if (TF == 0)
       [M,I] = max(TP(:,2));  %obtaining maximum value of heading (M) and corresponding row (index I)
       max_tp_all4.TRAJ_NUM(row4) = runway_1_mode.TRAJECTORY(row); %writing the number of trajectory
       max_tp_all4.ROW(row4) = TP(I,1); %writing the corresponding row (original from ClustTraj1)
       max_tp_all4.MAX_HEADING(row4) = M; %writing the maximum heading 
       max_tp_all4.P_EAST(row4) = ClustTraj1.P_EAST(TP(I,1));
       max_tp_all4.P_NORTH(row4) = ClustTraj1.P_NORTH(TP(I,1));
       max_tp_all4.TIME(row4) = ClustTraj1.TIME(TP(I,1));
       row4 = row4+1;
       %finding if there's second max heading in that state
       sz = size(TP);
       if (sz(1,1)>=2)
           [B,Ind] = maxk(TP(:,2),2);
           M2 = B(2,1); %second largest heading 
           I2 = Ind(2,1); %index of second largest heading
           if abs(TP(I2,1) - TP(I,1)) > 150
               max_tp_all4.TRAJ_NUM(row4) = runway_1_mode.TRAJECTORY(row); %writing the number of trajectory
               max_tp_all4.ROW(row4) = TP(I2,1); %writing the corresponding row (original from ClustTraj1)
               max_tp_all4.MAX_HEADING(row4) = M2; %writing the maximum heading 
               max_tp_all4.P_EAST(row4) = ClustTraj1.P_EAST(TP(I2,1));
               max_tp_all4.P_NORTH(row4) = ClustTraj1.P_NORTH(TP(I2,1));
               max_tp_all4.TIME(row4) = ClustTraj1.TIME(TP(I2,1));
               row4=row4+1;
           end
       end
       %finding 3rd max heading in that state
       if (sz(1,1)>=3)
            [B3,Ind3] = maxk(TP(:,2),3);
            M3 = B3(3,1); %third largest heading 
            I3 = Ind3(3,1); %index of third largest heading
            if abs(TP(I3,1) - TP(I,1)) > 150 && abs(TP(I3,1) - TP(I2,1)) > 150
               max_tp_all4.TRAJ_NUM(row4) = runway_1_mode.TRAJECTORY(row); %writing the number of trajectory
               max_tp_all4.ROW(row4) = TP(I3,1); %writing the corresponding row (original from ClustTraj1)
               max_tp_all4.MAX_HEADING(row4) = M3; %writing the maximum heading 
               max_tp_all4.P_EAST(row4) = ClustTraj1.P_EAST(TP(I3,1));
               max_tp_all4.P_NORTH(row4) = ClustTraj1.P_NORTH(TP(I3,1));
               max_tp_all4.TIME(row4) = ClustTraj1.TIME(TP(I3,1));
               row4=row4+1;
            end
       end
         %finding 4th max heading in that state
        if (sz(1,1)>=4)
            [B4,Ind4] = maxk(TP(:,2),4);
            M4 = B4(4,1); %third largest heading 
            I4 = Ind4(4,1); %index of third largest heading
            if abs(TP(I4,1) - TP(I,1)) > 150 && abs(TP(I4,1) - TP(I2,1)) > 150 && abs(TP(I4,1) - TP(I3,1)) > 150
               max_tp_all4.TRAJ_NUM(row4) = runway_1_mode.TRAJECTORY(row); %writing the number of trajectory
               max_tp_all4.ROW(row4) = TP(I4,1); %writing the corresponding row (original from ClustTraj1)
               max_tp_all4.MAX_HEADING(row4) = M3; %writing the maximum heading 
               max_tp_all4.P_EAST(row4) = ClustTraj1.P_EAST(TP(I4,1));
               max_tp_all4.P_NORTH(row4) = ClustTraj1.P_NORTH(TP(I4,1));
               max_tp_all4.TIME(row4) = ClustTraj1.TIME(TP(I4,1));
               row4=row4+1;
            end
        end
        end
    end
end
%%add state number to each data entry
max_tp_all4.STATE(:) = 4; %change state number at each iteration
%% SECTION2: Extracting the last trajectory points (state 5) into 'max_tp_all5' file

h = height(runway_1_mode);
h1 = height(traj_for_clust1);
i = 1; %row count for max_tp_all file

%create max_tp_all table
szz = [1 6]; %initial table size
varTypes = ["double", "double", "double", "double", "double", "datetime"]; %variable types
varNames = ["TRAJ_NUM", "ROW", "MAX_HEADING", "P_EAST", "P_NORTH", "TIME"]; %variable names
max_tp_all5 = table('Size', szz, 'VariableTypes', varTypes, 'VariableNames', varNames);

for row = 1:h
    if runway_1_mode.MODE(row) == 2
        traj_num = runway_1_mode.TRAJECTORY(row);
        for row1 = 1:h1
            if traj_for_clust1.TRAJECTORY(row1) == traj_num && traj_for_clust1.TRAJ_POINT_N(row1) ~= 1
                row_num = traj_for_clust1.ROW(row1); %row to indicate in which row in ClustTraj1 file to search for some parameters
                max_tp_all5.TRAJ_NUM(i) = traj_num; 
                max_tp_all5.ROW(i) = traj_for_clust1.ROW(row1);
                max_tp_all5.MAX_HEADING(i) = ClustTraj1.HEADING(row_num);
                max_tp_all5.P_EAST(i) = traj_for_clust1.P_EAST(row1);
                max_tp_all5.P_NORTH(i) = traj_for_clust1.P_NORTH(row1);
                max_tp_all5.TIME(i) = ClustTraj1.TIME(row_num);
                i = i+1;
            end
        end
    end
        
end
%% SECTION3: Plot TP clusters for all states

%max_tp_all_N number of rows (clusters)
row_num1 = height(max_tp_all1);
row_num2 = height(max_tp_all2);
row_num3 = height(max_tp_all3);
row_num4 = height(max_tp_all4);
row_num5 = height(max_tp_all5);

%CLUSTER 1 (state 1)
for row = 1:row_num1
    x = max_tp_all1.P_NORTH(row);
    y = max_tp_all1.P_EAST(row); 
    plot(x,y,'g.', 'MarkerSize', 7)
    hold on
end

%CLUSTER 2 (state 2)
for row = 1:row_num2
    x = max_tp_all2.P_NORTH(row);
    y = max_tp_all2.P_EAST(row); 
    plot(x,y,'b.', 'MarkerSize', 7)
    hold on
end

%CLUSTER 3 (state 3)
for row = 1:row_num3
    x = max_tp_all3.P_NORTH(row);
    y = max_tp_all3.P_EAST(row); 
    plot(x,y,'m.', 'MarkerSize', 7)
    hold on
end

%CLUSTER 4 (state 4)
for row = 1:row_num4
    x = max_tp_all4.P_NORTH(row);
    y = max_tp_all4.P_EAST(row); 
    plot(x,y,'c.', 'MarkerSize', 7)
    hold on
end

%CLUSTER 5 (state 5)
for row = 1:row_num5
    x = max_tp_all5.P_NORTH(row);
    y = max_tp_all5.P_EAST(row); 
    plot(x,y,'r.', 'MarkerSize', 7)
    hold on
end

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
hold on
grid on
title('Turning Points')
xlim([-1.69, -1.55])
ylim([52.135, 52.24])
xlabel('Longitude')
ylabel('Latitude')



