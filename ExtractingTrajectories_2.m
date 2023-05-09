%%PART2 This code sorts the data in terms of trajectories. A new trajectory is identified when
%%a new aircraft entry number is found and if there is more than 3 second difference between
%%between two consecutive data entries. At the start of each new trajectory 1 is written in 
%%the BREAK column (in the 'trajectories' table)

%Variable set up
rows = height(trajectories1); 
duration = seconds(3); %to check the time gap between two consecutive data records
a = trajectories1.ICAO24(1); %reads the first aircraft number
t1 = datetime(trajectories1.TIME(1),'ConvertFrom', 'posixtime'); %converting first time entry from unix time to normal 
break_point = 1; %point where new trajectory is identified

%this loop adds value 1 to the break column to indicate a new trajectory
%rows=10000; %this is only used when testing the code so smaller number of rows are tested
while break_point<rows
    b = 0; %counter - how many entries in total in the table are for a specific aircraft. Resetting at each loop
    
    %%FINDING ALL ROWS WITH THE SAME AIRCRAFT NUMBER
    a = trajectories1.ICAO24(break_point); %%reading aircraft number at break point 
    for row = break_point:rows
        if trajectories1.ICAO24(row) == a
            b=b+1; %counts how many entries of a specific aircraft there are 
        end
    end

    break_point_b = break_point+b %identifies where the next aircraft number entry starts after the last time the current aircraft was found 
    trajectories1.BREAK(break_point_b) = 1; %adds 1 where new aircraft entry starts. Works correctly 

    %%converts the time from unix to normal for the part of the table where the current aircraft was found
    unix_time = trajectories1.TIME(break_point:(break_point_b-1));
    normal_time = datetime(unix_time,'ConvertFrom', 'posixtime'); %stores normal time
    time_height = length(normal_time); %length of the normal time array
     
    %separating trajectories which correspond to the same aircraft based on
    %time difference (assumption: if two consecutive entries are more than
    %3 seconds apart, it is considered to b e a separate trajectory
    t1 = normal_time(1); %reads first entry of the normal time 
    break_point2=1; %break point which identifies the new trajectory based on time difference
    d=1; %row counter for t2
    traj_length=0; %counts length of the recent trajectory 
           for row=d:time_height
           t2 = normal_time(row);
           dt = t2-t1; %checking the time difference
           if dt<duration
                traj_length=traj_length+1;
           end   
           if dt>duration
                break_point2=break_point+traj_length %indicates where the trajectory is broken and a new one starts
                trajectories1.BREAK(break_point2)=1; %old brackets: break_point+traj_length+1
                traj_length=traj_length+1;
           end 
           t1=t2;
           end
        
    break_point = break_point + b
end
