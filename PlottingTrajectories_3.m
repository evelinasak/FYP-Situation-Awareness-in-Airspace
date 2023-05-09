%%PART3 This code filters out trajectories which correspond to helicopter and do not pass over the runways.
%Filtered trajectories are extracted into a table "ClustTraj1"
%and plotted

%Variable set up
rows = height(trajectories1);
rows_helicopt = height(Nonhelicopters); %MANUAL: file with nonhelicopter aircraft IDs 
initial_plot_val=1;
break_point = 1; %used to indicate where a new trajectory starts in the main file 
traj_num =0; %counts the number of trajectories plotted
aircrafts = trajectories1.ICAO24(1); %reads first aircraft entry
filt_traj_start = 1; %counter to keep track in which row relevant trajectory data entries are extracted into a separate file

% %Origin of the ENU coordinates if airport-centred plot is preferred
% lat0 = 52.192222;
% lon0 = -1.614444;
% h0 = 0;
% wgs84 = wgs84Ellipsoid; %standard reference spheroid

while break_point < rows
    %loop which counts how many data entries are in a trajectory
    count = 0;
    for row = (break_point):rows
        if trajectories1.BREAK(row) == 0
            count = count+1; %number of data points in a trajectory 
        else 
            break;
        end
    end
        
    if break_point == 1
        initial_plot_val = break_point; %stores row number where a trajectory starts
    else
        initial_plot_val = break_point-1; %stores row number where a trajectory starts
    end
        final_plot_val = break_point+count-1; %stores row number where a trajectory ends
        
     lat = trajectories1.LAT(initial_plot_val+2:final_plot_val); %gets latitude values for a trajectory. Added 1 to initial_plot_val because of the error in the data processing file which is not identified yet
     lon = trajectories1.LON(initial_plot_val+2:final_plot_val); %gets longitude values for a trajectory. Added 1 to initial_plot_val because of the error in the data processing file which is not identified yet
     h = trajectories1.ALTITUDE(initial_plot_val+2:final_plot_val); %gets geoaltitude data for a trajectory from the initial data file. Added 1 to initial_plot_val because of the error in the data processing file which is not identified yet 
     include1 = 0; %a variable to check if the trajectory is relevant (not filtered out)
    
     coordinate_num = length(lat); %number of  coordinates in a trajectory (used for extracting relevant trajectories)
     
    %%trajectory filtering  
    %checking if a trajectory is relevant(goes above the runways)
    for row=initial_plot_val:final_plot_val
        if trajectories1.LAT(row)<52.197596 && trajectories1.LAT(row)>52.186343 && trajectories1.LON(row)>-1.618472 && trajectories1.LON(row)<-1.600744
            include1 = include1+1; %trajectory is relevant
        end
    end
    
    %A loop to check if the trajectory is helicopter 
    include2 = 0; %variable to check if the aircraft is not a helicopter
    aircraft = trajectories1.ICAO24(break_point);
    if ismember(aircraft,Nonhelicopters.ICAO24)==1 %checks if the aircraft is in the nonhelicopter list 
        include2 = include2+1; %trajectory is relevant
    end
        
       %plotting trajectories
       if include1>0 && include2>0 %checks if the trajectory is relevant and if it is, plots it
           %plotting in aircraft-centred plot (ENU coordinates)
%            [pE,pN,pU]=geodetic2enu(lat,lon,h,lat0,lon0,h0,wgs84); %transforming to local ENU coordinates. pi = [pE, pN, pU] where pE - East, pN - North, pU = 
%            plot(pE,pN, 'LineWidth',0.1)
%            xlim([-9360, 9360]) %sets axis limits based on the selected airspace frame 
%            ylim([-9380, 9220])

           plot(lon,lat, 'LineWidth',0.1)
           hold on
           traj_num = traj_num+1;
           
           %for loop to extract filtered trajectories into a separate file 'ClustTraj1'
           filt_traj_end = coordinate_num;
           r = break_point; %variable used to indicate from which row a data point from trajectories1 file is taken
           n = 1; %trajectory points counter
%            for row = filt_traj_start:(filt_traj_start+filt_traj_end-1)
%                 ClustTraj1.TRAJECTORY(row) = traj_num;
%                 ClustTraj1.TRAJ_POINT_N(row) = n;
%                 ClustTraj1.TIME(row) = trajectories1.RTIME(r+2);
%                 ClustTraj1.P_EAST(row) = lat(n);
%                 ClustTraj1.P_NORTH(row) = lon(n);
%                 ClustTraj1.P_UP(row) = h(n);
%                 ClustTraj1.VELOCITY(row) = trajectories1.VELOCITY(r+2); 
%                 ClustTraj1.ICAO24(row) = trajectories1.ICAO24(r+2);
%                 ClustTraj1.HEADING(row) = trajectories1.HEADING(r+2);
%                 
%                 n = n+1; 
%                 r = r+1;
%             end  
            filt_traj_start = filt_traj_start+coordinate_num
        end
        n=1;
        initial_plot_val = final_plot_val+1;
        break_point = break_point + count + 1
end

 %%plotting the runways - ENU coordinates

% %Runway 1
%  lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
%  lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];
%  h1= [0,0,0,0,0];
%  [x1,y1,z1]=geodetic2enu(lat1,lon1,h1,lat0,lon0,h0,wgs84); %transforming to local ENU coordinates
%  plot(x1, y1, "black", 'LineWidth',3)
%  hold on
% 
% %Runway 2
% lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
% lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
% h2= [0,0,0,0,0];
% [x2,y2,z2]=geodetic2enu(lat2,lon2,h2,lat0,lon0,h0,wgs84); %transforming to local ENU coordinates
% plot(x2, y2, "black", 'LineWidth',3)
% 
% title('Air Traffic Pattern at Wellesbourne Mountford Airfield, May 2022')
% xlabel('x-axis, meters')
% ylabel('y-axis, meters')

 %%plotting the runways - lat, lon

%Runway 1
 lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
 lon1=[-1.615369, -1.614686, -1.613438, -1.614142, -1.615369];
 plot(lon1, lat1, "black", 'LineWidth',3)
 hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)

title('Air Traffic Pattern at Wellesbourne Mountford Airfield, October 2022')
xlabel('Longitude')
ylabel('Latitude')
