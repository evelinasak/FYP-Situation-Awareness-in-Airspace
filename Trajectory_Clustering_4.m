% %%PART 4 This code clusters trajectories into two clusters based on the runway 
% 
% %%Firstly, we need to extract first and last coordinates of each trajectory
% %%from ClustTraj table because they will be used as features (independent of direction)
% rows = height(ClustTraj1);
% N = ClustTraj1.TRAJECTORY(rows); %gets total number of trajectories
% 
% %N=4; %for testing
% n = 1; %n is trajectory number - starting from one 
% i = 1; %row in the traj_for_clust file count 
% count = 0; %count for trajectory points in a trajectory (reset to 0 before every loop)
% length1 = 0; %same as count just without reset to 0
% for row = 1:N
%     if (ClustTraj1.TRAJECTORY(length1+1) == row) && (ClustTraj1.TRAJ_POINT_N(length1+1)==1) %%check where a new trajectory starts 
%         traj_for_clust1.TRAJECTORY(i) = row;
%         traj_for_clust1.TRAJ_POINT_N(i) = 1;
%         traj_for_clust1.P_EAST(i) = ClustTraj1.P_EAST(length1+1);
%         traj_for_clust1.P_NORTH(i) = ClustTraj1.P_NORTH(length1+1);
%         traj_for_clust1.VELOCITY(i) = ClustTraj1.VELOCITY(length1+1);
%         traj_for_clust1.ROW(i) = length1+1;
%     end
%     
%     i = i+1;
%     
%     for row2 = 1:rows
%         if (ClustTraj1.TRAJECTORY(row2) == row) 
%             count = count+1;
%         end
%     end
%     length1 = length1+count;
%     
%     traj_for_clust1.TRAJECTORY(i) = row;
%     traj_for_clust1.TRAJ_POINT_N(i) = ClustTraj1.TRAJ_POINT_N(length1);
%     traj_for_clust1.P_EAST(i) = ClustTraj1.P_EAST(length1);
%     traj_for_clust1.P_NORTH(i) = ClustTraj1.P_NORTH(length1);
%     traj_for_clust1.VELOCITY(i) = ClustTraj1.VELOCITY(length1);
%     traj_for_clust1.ROW(i) = length1;
%     
%     i= i+1;
%     count = 0;
% end
%% 

%%Find which coordinate (first or last one) is closer to the runway
%Origin of the ENU coordinates 
% x1 = -1.614444; %x coordinate lon0 - origin of the airspace
% y1 = 52.192222; %y coordinate lat0 - origin of the airspace 
% 
% x2 = traj_for_clust1.P_NORTH(2);
% y2 = traj_for_clust1.P_EAST(2); 
% 
% distance = sqrt((x0-x1)^2+(y0-y1)^2);
% 
% for row = 1:N
%     x2_1 = traj_for_clust1.P_NORTH(row*2-1); %longitude of the first trajectory point
%     y2_1 = traj_for_clust1.P_EAST(row*2-1); %latitude of the first trajectory point
%     
%     x2_2 = traj_for_clust1.P_NORTH(row*2); %longitude of the last trajectory point
%     y2_2 = traj_for_clust1.P_EAST(row*2); %latitude of the last trajectory point
%     
%     %finding distances from the first and last trajectory points to the
%     %centre of runways
%     distance1 = sqrt((x2_1-x1)^2+(y2_1-y1)^2) 
%     distance2 = sqrt((x2_2-x1)^2+(y2_2-y1)^2)
%     
%     %checking which point is closer to the runway centres 
%     if distance1<distance2
%         traj_for_clust1.USE(row*2-1) = 1; %write 1 if first point is closer
%         traj_for_clust1.USE(row*2) = 0; %write 0 if last is further
%     else
%         traj_for_clust1.USE(row*2) = 1; %write 1 if last point is closer 
%         traj_for_clust1.USE(row*2-1) = 0; %write 0 if first point is further
%     end
%     N
% end
%% 

%%Plot trajectories first/last point which are closer to the runway
% rows = height(traj_for_clust);
% for row = 1:rows
%     if traj_for_clust.USE(row) ==1
%         plot(traj_for_clust.P_NORTH(row), traj_for_clust.P_EAST(row), 'g.', 'MarkerSize', 10);
%         hold on
%     end
% end
%% 

%%Finding to which runway a trajectory corresponds to (based on shortest
%%distance to all the runway points)
%Runway points
% R1_P1 = [-1.6150, 52.1975]; %distance 1
% R1_P2 = [-1.6138, 52.1865]; %distance 2
% R2_P1 = [-1.6086, 52.1928]; %distance 3
% R2_P2 = [-1.6178, 52.1871]; %distance 4
% N = height(traj_for_clust)
% for row = 1:N
%     
% count_R1 = 0;
% count_R2 = 0; 
% 
%     if traj_for_clust1.USE(row) == 1 %indicates that a point closer to the runway is used 
%         dist(1,1) = sqrt((R1_P1(1,1)-traj_for_clust1.P_NORTH(row))^2+(R1_P1(1,2)-traj_for_clust1.P_EAST(row))^2); %distance corresponding to R1_P1
%         dist(1,2) = sqrt((R1_P2(1,1)-traj_for_clust1.P_NORTH(row))^2+(R1_P2(1,2)-traj_for_clust1.P_EAST(row))^2); %distance corresponding to R1_P2
%         dist(1,3) = sqrt((R2_P1(1,1)-traj_for_clust1.P_NORTH(row))^2+(R2_P1(1,2)-traj_for_clust1.P_EAST(row))^2); %distance corresponding to R2_P1
%         dist(1,4) = sqrt((R2_P2(1,1)-traj_for_clust1.P_NORTH(row))^2+(R2_P2(1,2)-traj_for_clust1.P_EAST(row))^2); %distance corresponding to R2_P2
%         [M, I] = min(dist) %returns the minimum distance (M) and index of min value (I)
%         traj_for_clust1.P_EAST(row)
%         traj_for_clust1.P_NORTH(row)
%         if I == 1 || I == 2 %%Index 1 and 2 stands for R1 points P1 and P2
%             display('Runway 1')
%                 if (traj_for_clust1.P_EAST(row)>52.197) && (traj_for_clust1.P_EAST(row)< 52.207) && (traj_for_clust1.P_NORTH(row)>-1.618) && (traj_for_clust1.P_NORTH(row)<-1.612) %%check if trajectory starts/finishes at runway1(BOX1)
%                 count_R1 = count_R1+1
%                  else if (traj_for_clust1.P_EAST(row)>52.181) && (traj_for_clust1.P_EAST(row)< 52.188) && (traj_for_clust1.P_NORTH(row)>-1.615) && (traj_for_clust1.P_NORTH(row)<-1.612)  %%check if trajectory starts/finishes at runway1(BOX2)
%                 count_R1 = count_R1+1
%                      else continue
%                      end
%                 end
%                 if count_R1>0 %means the trajectory starts/finishes at R1
%                  traj_for_clust1.RUNWAYfilt(row) = 1;
%                 end
%         else  %else it is index 3 or 4 which stand for R2 points P3 and P4
%             display('Runway 2')
%              if (traj_for_clust1.P_EAST(row)>52.192) && (traj_for_clust1.P_EAST(row)< 52.195) && (traj_for_clust1.P_NORTH(row)>-1.612) && (traj_for_clust1.P_NORTH(row)<-1.604) %%check if trajectory starts/finishes at runway2(BOX3)
%                 count_R2 = count_R2+1
%              else if (traj_for_clust1.P_EAST(row)>52.185) && (traj_for_clust1.P_EAST(row)< 52.188) && (traj_for_clust1.P_NORTH(row)>-1.622) && (traj_for_clust1.P_NORTH(row)<-1.617) %%check if trajectory starts/finishes at runway2(BOX4)
%                 count_R2 = count_R2+1
%                  else continue
%                  end
%              end
%              if count_R2>0 %means the trajectory starts/finishes at R1 
%                 traj_for_clust1.RUNWAYfilt(row) = 2;
%              end
%         end    
%    end
% end


%% 

%%Extracting trajectories which correspond to runway 1 
% runway_1 = zeros(1, numel(row)); %an array to hold trajectory numbers which correspond to runway 1
% i = 1; 
% rows = height(traj_for_clust1);
% for row = 1:rows
%     if traj_for_clust1.RUNWAYfilt(row) == 1
%         runway_1(i,1) = traj_for_clust1.TRAJECTORY(row);
%         i = i+1;
%     end
% end
% 
% %Extracting trajectories which correspond to runway 2
% runway_2 = zeros(1, numel(row)); %an array to hold trajectory numbers which correspond to runway 2
% i = 1; 
% for row = 1:rows
%     if traj_for_clust1.RUNWAYfilt(row) == 2
%         runway_2(i,1) = traj_for_clust1.TRAJECTORY(row);
%         i = i+1;
%     end
% end

%% 

%Plotting trajectories which correspond to runway 1
rows1 = length(runway_1);
rows2 = height(ClustTraj1);
count = 0;
figure(1)
for row1 = 1:rows1
    number  = runway_1(row1); %reading trajectory number 
    for row2 = 1:rows2
        if ClustTraj1.TRAJECTORY(row2) == number %find the right trajectory in ClustTraj
            count = count+1; %counting points in a trajectory
            row_num = row2;  %to find the last trajectory entry
        end
    end 
     x1 = ClustTraj1.P_NORTH(row_num-count+1:row_num);
     y1 = ClustTraj1.P_EAST(row_num-count+1:row_num);
     %plot(x,y,'b.', 'MarkerSize', 2)
     plot(x1,y1,'LineWidth',0.1)
     hold on 
     count = 0;
end
xlabel('Longitude')
ylabel('Latitude')
title('Runway 1 trajectories')
hold on 
grid on
%Runway 1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];
plot(lon1, lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)
%% 

% 
%%Plotting runways which correspond to runway 2
rows11 = length(runway_2);
rows22 = height(ClustTraj1);
count = 0;
figure(2)
for row1 = 1:rows11
    number  = runway_2(row1); %reading trajectory number 
    for row2 = 1:rows22
        if ClustTraj1.TRAJECTORY(row2) == number %find the right trajectory in ClustTraj
            count = count+1; %counting points in a trajectory
            row_num = row2;  %to find the last trajectory entry
        end
    end 
     x2 = ClustTraj1.P_NORTH(row_num-count+1:row_num);
     y2 = ClustTraj1.P_EAST(row_num-count+1:row_num);
     %plot(x,y,'b.', 'MarkerSize', 2)
     plot(x2,y2,'LineWidth',0.1)
     hold on 
     count = 0;
end

xlabel('Longitude')
ylabel('Latitude')
title('Runway 2 trajectories')
hold on 
grid on
%Runway 1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];

plot(lon1, lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)
%% 

%%Clustering trajectories based on the landing direction - whether they
%%take off or land
%add 1 to traj_for_clust1 column direction if taking off, and 2 if landing
h1 = height(traj_for_clust1);
n = traj_for_clust1.TRAJECTORY(h1)
for row = 1:n

    for row2 = 1:h1
        if (traj_for_clust1.TRAJECTORY(row2) == row) && (traj_for_clust1.USE(row2) == 1)
           number = row2; 
        end
    end
    row
    number
    iseven = rem(number,2)
    if iseven == 0

        traj_for_clust1.DIRECTION(number) = 2; %even rows are finish coordinate- landing
    else 

        traj_for_clust1.DIRECTION(number) = 1; %odd rows are start coordinate - taking off
    end
end
%% 

%%Extracting trajectory number and corresonding direction (runway1)
h = length(runway_1); 
for row = 1:h
    traj_num = runway_1(row); %reading the trajectory number
    for row1 = 1:h1
        if (traj_for_clust1.TRAJECTORY(row1) == traj_num) && (traj_for_clust1.DIRECTION(row1) ~=0)
            runway_1_direct.TRAJECTORY(row) = traj_num;
            runway_1_direct.DIRECTION(row) = traj_for_clust1.DIRECTION(row1);
        end   
    end
end   
%% Plotting the trajectories in direction 1 and 2 (runway 1)
%Direction 1 - taking off
%Direction 2 - landing
rows1 = height(runway_1_direct);
rows2 = height(ClustTraj1);
count = 0;
%plotting taking off
figure(1)
for row1 = 1:rows1
    number  = runway_1_direct.TRAJECTORY(row1) %reading trajectory number 
    runway_1_direct.DIRECTION(row1)
    if runway_1_direct.DIRECTION(row1) == 1 %1 corresponds to taking off
        for row2 = 1:rows2
            if ClustTraj1.TRAJECTORY(row2) == number %find the right trajectory in ClustTraj
                count = count+1; %counting points in a trajectory
                row_num = row2;  %to find the last trajectory entry
            end
        end 
        count
         x1 = ClustTraj1.P_NORTH(row_num-count+1:row_num);
         y1 = ClustTraj1.P_EAST(row_num-count+1:row_num);
         %plot(x,y,'b.', 'MarkerSize', 2)
         plot(x1,y1,'LineWidth',0.1)
         hold on 
         count = 0;
    end
    x1 = 0;
    y1 = 0;
end
xlabel('Longitude')
ylabel('Latitude')
title('Runway 1 trajectories - Taking off')
hold on 
grid on

%Runway 1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];
plot(lon1, lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)

%plotting landing
figure(2)
for row1 = 1:rows1
    number  = runway_1_direct.TRAJECTORY(row1) %reading trajectory number 
    runway_1_direct.DIRECTION(row1)
    if runway_1_direct.DIRECTION(row1) == 2 %2 corresponds to landing
        for row2 = 1:rows2
            if ClustTraj1.TRAJECTORY(row2) == number %find the right trajectory in ClustTraj
                count = count+1; %counting points in a trajectory
                row_num = row2;  %to find the last trajectory entry
            end
        end 
        count
         x1 = ClustTraj1.P_NORTH(row_num-count+1:row_num);
         y1 = ClustTraj1.P_EAST(row_num-count+1:row_num);
         %plot(x,y,'b.', 'MarkerSize', 2)
         plot(x1,y1,'LineWidth',0.1)
         hold on 
         count = 0;
    end
end
xlabel('Longitude')
ylabel('Latitude')
title('Runway 1 trajectories - Landing')
hold on 
grid on

%Runway 1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];
plot(lon1, lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)