%%PART1 This code groups data based on the aircraft in a separate table (T1) called trajectories

%Variable set up
rows = height(T1); %T1 is input data file (raw surveillance data)
%a = []; %array for storing all the aircraft 
%a = T1.icao24(1); %reads first aircraft ID into the array 
c=2; %row number for array a 
d = 1; %row number in trajectories1 file (used to extract sorted data)
break_point=1;
duration = seconds(3); %to check the time gap between two consecutive data records

%Creating trajectories table 
ICAO24=[]; %aircraft ID
TIME=[]; %timestamp (UNIX)
RTIME=[];  %converted time from UNIX to normal
LAT=[]; %latitude
LON=[]; %longitude
BREAK=[]; %break to indicate where a new trajectory starts 
%trajectories1 = table(TIME, RTIME, ICAO24, LAT, LON, BREAK); 
%trajectories1 = convertvars(trajectories, 'RTIME', 'string');
%trajectories1 = convertvars(trajectories,'ICAO24', 'string');


%Extracting all aircraft IDs to a list a 
% for row= 1:rows
%     icao24 = T1.icao24(row);
%     if ismember(icao24, a) == 1 %%checking if the aircrft was already found
%     else 
%         a(c)=icao24;
%         c=c+1; %row number for array a 
%     end
% end   

a = transpose(a); %list of all the aircraft observed
size = length(a); %number of aircraft IDs (rows in the array)

%Sorting out all data by plane ID and extracting data into a new file trajectories 1
for row=1:size
    icao24 = a(row);
    icao24 = string(icao24)
    for row2= 1:rows %rows
        row2;
        ac = string(T1.icao24(row2)); %%reads aircraft 
        if icao24 == ac %%checks all the aircraft entries and writes into table current aircraft stuff
            trajectories1.TIME(d)=T1.time(row2);
            trajectories1.RTIME(d)=string(T1.rtime(row2));
            trajectories1.ICAO24(d)=icao24;
            trajectories1.LAT(d)=T1.lat(row2);
            trajectories1.LON(d)=T1.lon(row2);
            trajectories1.VELOCITY(d)=T1.velocity(row2);
            trajectories1.ALTITUDE(d)=T1.geoaltitude(row2);
           % trajectories1.HEADING(d) = T1.heading(row2);
            d=d+1; %row number in trajectories1 file
        end
    end 
    row
end

% %% Sorting out trajectories based on aircraft and time difference  
% while break_point<rows
%     initial_plot_val = break_point; %initial value used for plotting 
%     b = 0; %counter - how many entries in the table are for a specific aircraft
%     %finding all rows with the same aircraft number
%     a = trajectories.ICAO24(break_point); %%reading aircraft number
%     
%     for row = break_point:rows
%         if trajectories.ICAO24(row) == a
%             b=b+1;
%         end
%     end
% 
%     %%converts the time from unix to normal from recent trajectory 
%     unix_time = trajectories.TIME(break_point:(break_point+b-1));
%     normal_time = datetime(unix_time,'ConvertFrom', 'posixtime');
%     time_height = length(normal_time) %length of the normal time array
%      
%     %separating trajectories which correspond to the same aircraft based on
%     %time difference (assumption: if two consecutive entries are more than
%     %3 seconds apart, it is considered to be a separate trajectory
%     t1 = normal_time(1);
%     break_point2=1;
%     d=1; %row counter for t2
%     initial_plot_val = break_point2; %initial value used for plotting 
%     while break_point2<time_height
%            traj_length=0;
%            for row=d:time_height
%            t2 = normal_time(row);
%            dt = t2-t1; %checking the time difference
%            if dt<duration
%                 traj_length=traj_length+1;
%            end   
%            if dt>duration
%                 break_point2=row+break_point2-1 %breaks the trajectory
%                 t1=t2;
%                 trajectories.BREAK(row)=1;
%                 break;
%            end 
%            t1=t2;
%            d=d+1;
%            end
%            break_point2=time_height %point where the next trajectory of the same aircraft starts
%            trajectories.BREAK(time_height) = 1;
% 
%           %plotting recently extracted trajectory
%             final_plot_val = initial_plot_val+break_point2;
%             lat = trajectories.LAT(initial_plot_val:final_plot_val);
%             lon = trajectories.LON(initial_plot_val:final_plot_val);
%     
%             plot(lon, lat)
%             xlim([-1.75122, -1.48]) %MANUAL: sets axis x limits based on the selected airspace frame 
%             ylim([52.10803, 52.27471]) %MANUAL: sets axis y limits based on the selected airspace frame 
%             hold on
%         
%     end
% end
% %     
% %     
% % %     %plotting recently extracted trajectory
% % %     final_plot_val = initial_plot_val+b-1;
% % %     lat = trajectories.LAT(initial_plot_val:final_plot_val);
% % %     lon = trajectories.LON(initial_plot_val:final_plot_val);
% % % 
% % %     plot(lon, lat)
% % %     xlim([-1.75122, -1.48]) %sets axis limits based on the selected airspace frame 
% % %     ylim([52.10803, 52.27471])
% % %     hold on
% %     break_point = break_point + b
% % end