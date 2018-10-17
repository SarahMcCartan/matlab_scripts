close all
clear variables

%WANT TO PLOT REL T VS LAG T TO CHECK FOR CONVERGENCE OF REL T

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG\lagConvTest';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '310_CSA_KM_REL_T_*.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

lagFile = fullfile(myFolder, '310_CSAt_lagTime.txt'); %read in lag t file
lagData = load(lagFile, '-ascii');

%global variables
pep = 'CSA';
temp = 310;
ns = 2;

%TIME STEP
tStep = 500e-12; %time step is 500 ps
%tstep = 2*(500e-12); %t step for 2 simulations only (dcsa 510 & 310K)

%empty matrix
myMat = zeros(length(theFiles),ns);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    
    data=load(fullFileName,'-ascii') ;
   
    relT = data(2) ; %only need 2nd value
    
    if relT < 0
        relT= (-1)*relT; %for KM
    end
    
    lag = lagData(k); %load the correct lag time for the TM created.
    lagTime = lag*tStep; % lag time in seconds
    
    myMat(k,1) = relT;
    myMat(k,2) = lagTime;
    
end

%%

file_name = sprintf('%d_%s_KM_relTvslagT_TEST.txt',temp,pep);
dlmwrite(file_name, myMat, 'delimiter', '\t');

%%

%fin = '310_CSA_KM_relTvslagT.txt'; %read in lag file
%myMat2 = load(fin, '-ascii');

y = myMat(:,1).*(1e+9);
x = myMat(:,2).*(1e+9);

plot(x , y)

xlabel('Lag time (ns)')
ylabel('Relaxation time (ns)')


%ylim([0 70])
