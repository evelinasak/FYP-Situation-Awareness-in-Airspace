%% PART 8: Training HMM Model

%% SECTION 1: Set up and sequence preparation 
%Variable set up
num_states = 5; %number of hidden states
num_obs = 648; %number of possible observations (36x18)
symbols = linspace(1, 648,648);
pseudoe(1:5,1:648)=0.01;

%States
states_1 = seq1.STATE(6:10);
seq_1 = seq1.GRID_NUM(6:10); 

states_2= seq13.STATE(3:7);
seq_2 = seq13.GRID_NUM(3:7); 

states_3 = seq3.STATE(6:10);
seq_3 = seq3.GRID_NUM(6:10);

states_4 = seq43.STATE(11:15);
seq_4 = seq43.GRID_NUM(11:15);

states_5 = seq41.STATE(1:5);
seq_5 = seq41.GRID_NUM(1:5);

states_6 = seq44.STATE(1:5);
seq_6 = seq44.GRID_NUM(1:5);

states_7 = seq45.STATE(8:12);
seq_7 = seq45.GRID_NUM(8:12);

states_8 = seq47.STATE(1:5);
seq_8 = seq47.GRID_NUM(1:5);

states_9 = seq51.STATE(1:5);
seq_9 = seq51.GRID_NUM(1:5);

states_10 = seq53.STATE(1:5);
seq_10 = seq53.GRID_NUM(1:5);

states_11 = seq65.STATE(1:5);
seq_11 = seq65.GRID_NUM(1:5);

states_12 = seq37.STATE(1:5);
seq_12 = seq37.GRID_NUM(1:5);

states_13 = seq7.STATE(1:5);
seq_13 = seq7.GRID_NUM(1:5);

states_14 = seq70.STATE(1:5);
seq_14 = seq70.GRID_NUM(1:5);

states_15 = seq75.STATE(1:5);
seq_15 = seq75.GRID_NUM(1:5);

states_16 = seq45.STATE(1:5);
seq_16 = seq45.GRID_NUM(1:5);

states_17 = seq43.STATE(1:5);
seq_17 = seq43.GRID_NUM(1:5);

states_18 = seq43.STATE(6:10);
seq_18 = seq43.GRID_NUM(6:10);

states_19 = seq3.STATE(1:5);
seq_19 = seq3.GRID_NUM(1:5);

states_20 = seq1.STATE(1:5);
seq_20 = seq1.GRID_NUM(1:5);

states_21 = seq46.STATE(1:5);
seq_21 = seq46.GRID_NUM(1:5);

states_22 = seq46.STATE(6:10);
seq_22 = seq46.GRID_NUM(6:10);

states_23 = seq49.STATE(1:5);
seq_23 = seq49.GRID_NUM(1:5);

states_24 = seq59.STATE(1:5);
seq_24 = seq59.GRID_NUM(1:5);

states_25 = seq73.STATE(1:5);
seq_25 = seq73.GRID_NUM(1:5);

seqs = [seq_1'; seq_2'; seq_3';seq_4'; seq_5'; seq_6'; seq_7'; seq_8';seq_9';seq_10';seq_11';seq_12';seq_13'; seq_14';seq_15';seq_16'; seq_17';seq_18';seq_19';seq_20'; seq_21'; seq_22'; seq_23'; seq_24'; seq_25'];
states = [states_1'; states_2'; states_3';states_4'; states_5'; states_6'; states_7'; states_8';states_9';states_10';states_11';states_12';states_13'; states_14';states_15';states_16'; states_17';states_18';states_19';states_20'; states_21'; states_22'; states_23'; states_24'; states_25'];
%% SECTION 2: Training HMM Model

%initialize the transition and emission matrices randomly
% guess_TR1 = rand(num_states,num_states)
% guess_TR1 = guess_TR1 ./ repmat(sum(guess_TR1,2),1,num_states); %converting random matrix into probabilities matrix so all rows sum to 1
% guess_E1 = rand(num_states, num_obs)
% guess_E1 = guess_E1 ./ repmat(sum(guess_E1,2),1,num_obs); %converting random matrix into probabilities matrix so all rows sum to  
guess_TR1 = TR1;
guess_E1 = EM1;
[TR1, EM1] = hmmtrain(seqs, guess_TR1, guess_E1,'Symbols',symbols) %training the model


%% SECTION 3: Plotting emissions matrix on the grid
i = 1; %count rows of the V array which holds x and y locations and value of the emissions matrix points
for row1 = 1:5 %looping through the states 
    for row2 = 1:648 %looping through the columns
        if EM1(row1, row2) ~=0
            
            value = EM1(row1,row2); %getting the value
            spec_circle = row2; %define in which grid the specific circle is
            row_round = floor(row2/n_columns); %round the number to the closest integer
            if (row2/n_columns==row_round)
                row_num = row_round;
            else
                row_num = row_round+1;
            end
            column_num = spec_circle - row_round*36;
            if column_num ==0
                column_num=36;
            end
            x_spec_circle = x_grid_cord(row_num, column_num);
            y_spec_circle = y_grid_cord(row_num, column_num);  
            
            %adding values to V array which holds grid middle circle
            %coordinates x and y and the value of that specific point from
            %the emissions matrix
            V(i,1) = x_spec_circle;
            V(i,2) = y_spec_circle;
            V(i,3) = value; %storing the probability value
            V(i,4) = row1; %stores in which state the point is
            i = i+1;
        end
    end
end

% Plotting emission probabilities
%preprocessing
l = length(V);
v1 = V(1,1);
v2 = V(1,2);
v3 = V(1,3);

for i = 1:l
   lon1 = V(i,1);
   lat1 = V(i,2);
   match = true;
   while match %while loop continues until the match is false
       match = false;
       for j = 1:l
            if i  ~= j
                lon2 = V(j,1);
                lat2 = V(j,2); 
                if (lon1==lon2) && (lat1 ==lat2)
                    shift = (2 +(5-2) *rand)/10000; %creating a random shift between 0.0002 and 0.0005
                    V(i,1) = V(i,1) +shift; 
                    match = true;
                    break;
                end
            end
     
       end
       lon1 = V(i,1);
       lat1 = V(i,2);
   end
end

V(any(V==0,2),:)=[]; %removes rows of zeros from the array
scatter(V(:,1), V(:,2),[], V(:,3), 'filled', 'SizeData',60) %plots probabilities of an observation at a specific state 
s.SizeData = 200;
hold on
colorbar
hold on

% Plotting state ellipses

%STATE1 hyperparameters
r1_1 =  0.006677336641054;
r2_1 = 0.017485491595638;
ang_1 = -0.056479360989006;
x0_1 = -1.621997761557327;
y0_1 = 52.211766740021702;

q1 = [r1_1,r2_1,ang_1,x0_1,y0_1]; %state description used for modelling
ellipse(r1_1,r2_1,ang_1,x0_1,y0_1)
hold on

%STATE2 hyperparameters
r1_2 =  0.010203088663312;
r2_2 = 0.018482810705987;
ang_2 =  -0.407267631674971;
x0_2 = -1.637749519354129;
y0_2 = 52.215198720858986;

q2 = [r1_2,r2_2,ang_2,x0_2,y0_2]; %state description used for modelling
ellipse(r1_2,r2_2,ang_2,x0_2,y0_2)
hold on

%STATE3 hyperparameters
r1_3 =  0.013469491984416;
r2_3 = 0.033323724991420;
ang_3 =  -0.074890874283384;
x0_3 = -1.634549874749108;
y0_3 = 52.172532798823568;

q3 = [r1_3,r2_3,ang_3,x0_3,y0_3]; %state description used for modelling
ellipse(r1_3,r2_3,ang_3,x0_3,y0_3)
hold on

%STATE4 hyperparameters
r1_4 = 0.009230483905532;
r2_4 = 0.031872609277625;
ang_4 = 0.056416499431396;
x0_4 = -1.613225998604898;
y0_4 = 52.169718269292851;

q4 = [r1_4,r2_4,ang_4,x0_4,y0_4]; %state description used for modelling
ellipse(r1_4,r2_4,ang_4,x0_4,y0_4)
hold on

%STATE5 hyperparameters
r1_5 =   7.391457035758395e-04;
r2_5 = 0.006738648820251;
ang_5 =  0.093075913302387;
x0_5 = -1.615749417176270;
y0_5 =  52.203934166550106;

q5 = [r1_5,r2_5,ang_5,x0_5,y0_5]; %state description used for modelling
ellipse(r1_5,r2_5,ang_5,x0_5,y0_5)
hold on


%plotting runways
%runway1
lat1=[52.197463, 52.197447, 52.186530, 52.186519,52.197463 ];
lon1=[-1.615369, -1.614686  , -1.613438, -1.614142, -1.615369];
h1= [0,0,0,0,0];
%[x1,y1,z1]=geodetic2enu(lat1,lon1,h1,lat0,lon0,h0,wgs84); %transforming to local ENU coordinates
plot(lon1, lat1, "black", 'LineWidth',3)
hold on
%Runway 2
lat2=[52.192900, 52.192694, 52.186931, 52.187281,52.192900];
lon2=[-1.608952, -1.608280, -1.617580, -1.618084, -1.608952];
h2= [0,0,0,0,0];
%[x2,y2,z2]=geodetic2enu(lat2,lon2,h2,lat0,lon0,h0,wgs84); %transforming to local ENU coordinates
plot(lon2, lat2, "black", 'LineWidth',3)
xlim([-1.7, -1.54])
ylim([52.14, 52.24])
hold on
title('Emissions Probabilities in the State-Space')
xlabel('Longitude')
ylabel('Latitude')
xlim([-1.65, -1.61])
ylim([52.136, 52.234])
%% SECTION 4: Plotting transition matrix 

figure;
imagesc(TR1);
colorbar;
axis square
h=gca;
h.XTick = 1:5;
h.YTick = 1:5;
title 'Transition Matrix Heatmap';

%% SECTION 5: Plotting Markov Chain
stateNames = ["State 1", "State 2", "State 3", "State 4", "State 5"];
mc = dtmc(TR1,'StateNames', stateNames);
figure;
graphplot(mc,'ColorEdges',true)
title('Markov Chain')