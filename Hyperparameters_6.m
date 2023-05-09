%%PART 6: This code finds a combination of optimal hyperparameters describing an elliptical state which includes all the TPs within. Sample ranges are defined
%manually by observation from plotting all TP clusters in the previouos file Turning_Points_5.m

%% SECTION 1: Finding estimate parameters 

%read all the TPs into matrix points (change file name for each state): 
clear points
points(:,1) = max_tp_all5.P_NORTH;
points(:,2) = max_tp_all5.P_EAST;


%Finding estimated ellipse centre
h = height(max_tp_all5); 
count_x = 0;
count_y = 0;
for row = 1:h
    count_x = count_x + max_tp_all5.P_NORTH(row);
    count_y = count_y + max_tp_all5.P_EAST(row);
end
x_est = count_x/h; %estimated longitude
y_est = count_y/h;  %estimated latitude

%%find estimated r
x = max_tp_all5(:,5); %reading full longitude column
y = max_tp_all5(:,4); %reading full latitude column
x = table2array(x);
y = table2array(y);
min_x = min(x);
max_x = max(x);
min_y = min(y);
max_y = max(y);

r_est1 = abs(max_x-min_x)/2
r_est2 = abs(max_y-min_y)/2

%pick bigger r as an estimated radius
if r_est1 > r_est2 
    r_est = r_est1;
else 
    r_est = r_est2;
end
r1_max = r_est1*2; % horizontal radius max
r2_max = r_est2*2; % vertical radius max

r1_min = r_est1; % horizontal radius max
r2_min = r_est2; % vertical radius max

ang = deg2rad(0); %angle in radians

ellipse(r1_max-0.0039,r2_max,ang,x_est,y_est) %plot estimated max ellipse to check
hold on
ellipse(r1_min,r2_min,ang,x_est,y_est) %plot estimated max ellipse to check
hold on
grid on

%plotting cluster to check
for row = 1:h
    longitude = max_tp_all5.P_NORTH(row);
    latitude = max_tp_all5.P_EAST(row); 
    plot(longitude,latitude,'g.', 'MarkerSize', 7)
    hold on
end

%estimated centre range: 
x_min = x_est - (r2_min/2)
x_max = x_est + (r2_min/2)

y_min = y_est - (r1_min/2)
y_max = y_est + (r1_min/2)

%% SECTION 2: Performing grid search to find optimum ellipse parameters

%sample ranges for grid search - ranges need to be changed for each state
r1_sample = unifrnd(r1_min, r1_max-0.0003, [1 30]); %30 random values uniformly sampled between 0.004 and 0.007
r2_sample = unifrnd(r2_min, r2_max-0.0063, [1 30]); %30 random values uniformly sampled between 0.005 and 0.02
ang_sample = unifrnd(-pi/2, pi/2, [1 30]); %30 random values uniformly sampled between pi/2 and pi/2
x0_sample = unifrnd(x_min, x_max, [1 30]); %30 random values uniformly sampled between -1.628 and -1.61
y0_sample = unifrnd(y_min, y_max, [1 30]); %30 random values uniformly sampled between 52.205 and 52.235


%Loop through all possible hyperparameter combinationss
min_size = Inf;
best_ellipse = [];
for i = 1:length(r1_sample)
    for j = 1:length(r2_sample)
        for k = 1:length(ang_sample)
            for l = 1:length(x0_sample)
                for m = 1:length(y0_sample)
                    % Calculate the ellipse for the current hyperparameters
                    a = r1_sample(i);
                    b = r2_sample(j);
                    theta = ang_sample(k);
                    x0 = x0_sample(l);
                    y0 = y0_sample(m);
                    t = linspace(0, 2*pi);
                    xt = x0 + a*cos(t)*cos(theta) - b*sin(t)*sin(theta);
                    yt = y0 + a*cos(t)*sin(theta) + b*sin(t)*cos(theta);
                    
                    % Check if all points are inside the ellipse
                    is_inside = true;
                    for n = 1:size(points, 1)
                        dx = points(n,1) - x0;
                        dy = points(n,2) - y0;
                        d = (dx*cos(theta) + dy*sin(theta))^2/a^2 + (dx*sin(theta) - dy*cos(theta))^2/b^2;
                        if d > 1
                            is_inside = false;
                            break;
                        end
                    end
                    
                    % Update the best ellipse if the current one is smaller and holds all points
                    if is_inside && (a*b < min_size)
                        min_size = a*b;
                        best_ellipse = [a, b, theta, x0, y0];
                    end
                end
            end
        end
    end
end
format long
r1_new = best_ellipse(1,1)
r2_new = best_ellipse(1,2)
ang_new = best_ellipse(1,3)
x0_new = best_ellipse(1,4)
y0_new = best_ellipse(1,5) 
ellipse(r1_new,r2_new,ang_new,x0_new,y0_new)
hold on

%%plotting all TPs 
h=length(points)
for row = 1:h
    x = points(row,1);
    y = points(row,2);
    plot(x,y,'.') %plotting turning point
    hold on
end

hold on
grid on
%%plotting runways
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686  , -1.613438, -1.614142, -1.615369];
plot(lon1, lat1, "black", 'LineWidth',3)
hold on

%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
plot(lon2, lat2, "black", 'LineWidth',3)

title('Turning Points, Runway 1, State 5')
xlabel('x-axis, longitude')
ylabel('y-axis, latitude')
xlim([-1.66 -1.58])
ylim([52.16 52.25])