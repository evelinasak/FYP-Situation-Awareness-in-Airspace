# FYP-Situation-Awareness-in-Airspace
# Final Year Project Code
MATLAB code for Final Year Project: Situation Awareness in Airspace - Inspection of Flight Data, Modelling and Improvements. The presented code extracts and clusters aircraft trajectories and models landing pattern at a selected airfield. 

In the main folder there are 4 main files which are used sequentially in the following order:
1. **DataGrouping_Aircraft_1.m** sorts out raw surveillance data based on the aircraft identification number (ICAO24).
2. **ExtractingTrajectories_2.m:** identifies separate trajectories based on the time difference. It adds 1 or 0 to a column BREAK in the trajectories data file next to each data entry to identify when a new trajectory starts (1). 0 means the data point belongs to the same trajectory 
3. **Filtering_Trajectories_3.m:** file filters the relevant trajectories firstly by checking if it’s not a helicopter and then checking if it passes one of the runways and plots individual trajectories. It also counts how many trajectories have been plotted. The filtered trajectories are extracted into a separate table called “filtered_trajectories” which is further used for trajectory clustering   
4. **Trajectory_Clustering_4.m:** clusters trajectories rom ClustTraj file based on the runway. The file is divided in the following sections:  <br>
    4.1. SECTION 1: First and last coordinates of each trajectory are extracted which will be used as trajectory features.  <br>
    4.2. SECTION 2: It is identified whether first or last coordinate is closer to the runway (will be used as a feature in the further steps).  <br>
    4.3. SECTION 3: Finds to which runway a trajectory corresponds to  <br>
    4.4. SECTION 4: Extracts trajectories which correspond to runways 1 and 2   <br>
    4.5. SECTION 5: Clusters trajectories based on flight mode (i.e., taje-off, landing)
    The file also plots clustered trajectories.   <br>
5. **Turning_Points_5.m** extracts turning points (TPs) for each trajectory based on changes in heading in each defined state and extracts TPs to separate file max_tp_all_N where N is the state number. The file is divided into the following sections: <br>
    5.1. SECTION 1: TPs are extracted for each state and extracted into separate max_tp_all_N files where N is the state number 1-4 (if statement needs to be changed for each state). <br>
    5.2. SECTION 2: Extracting the last trajectory points (state 5) into 'max_tp_all5' file <br>
    5.3. SECTION 3: All 5 TP clusters are plotted <br>
6. **Hyperparameters_6.m** performs grid search to find optimum parameters for each elliptical state. Supportive file ellipse.m is used to plot ellipses. The file is divided into the following sections:  <br>
    6.1. SECTION 1: Finds initial estimate parameters for the elliptical states. <br>
    6.2. SECTION 2: Performs grid search to find optimum ellipse parameters. <br>
    The code needs to be run for each state separately. 
7. **Modelling_Prep_7.m** plots all the elliptical states with corresponding TP clusters, divides the airspace into grid, extracts observation sequences and assigns grid values to each entry in each sequence. Supportive file ellipse.m is used to plot ellipses. The file is divided into the following sections: <br>
    7.1. SECTION 1: All optimized elliptical states are plotted with their corresponding TP clusters. <br>
    7.2. SECTION 2: Extracts sequences. Each sequence needs to be extracted separately (i.e., this part of the code needs to be run for each sequence separately). <br>
    7.3. SECTION 3: Divides the airspace into 36x18 grid. <br>
    7.4. SECTION 4: Assigns a number to each grid cell. <br>
    7.5. SECTION 5: Assigns a grid number to each point in the sequence. This part of the code needs to be run for each sequence separately. After this, it is recommended to sort the sequence in ascending order based on time. <br>
    After extracting all sequences, it is recommended to go through each sequence in this or the next step manually and perform data padding/splitting if needed to ensure that all sequences have the same length. 
8. **HMM_8.m** trains the HMM model and plots results based on the estimated emissions and transition matrices, and a resulting Markov chain. <br>
    8.1. SECTION 1: Sets up HMM parameters, state and observation sequences. <br>
    8.2. SECTION 2: Trains HMM model resulting in transition and emission probabilities matrices. <br>
    8.3. SECTION 3: Plots emissions probability matrix results with the states. <br>
    8.4. SECTION 4: Plots transition probability matrix as a heatmap. <br>
    8.5. SECTION 5: Plots Markov Chain using transition probability matrix results. <br>

The sequence of code files can be represented as a flow diagram:

![code_flow_diagram](https://github.com/evelinasak/Final_Year_Project_MATLAB/assets/126879562/96f99f4b-4a0b-46a5-b452-87fa657af104)


**FOLDER: Data_Files** contains all the data files used in the previous 4 matlab scripts or generated by those scripts

**FOLDER: Supporting Files** contains files which can be used for testing or support data processing 
    1. plot_velocity_envelope.m file plots a velicty profile of a selected trajectory
    2. plot_single_traj.m file plots a selected trajectory 
