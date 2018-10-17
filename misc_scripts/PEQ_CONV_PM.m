close all
clear variables

%WANT TO PLOT POP of S1 vs Lag Time to check conv..

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\450_CSA_CG\lagtest';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '450_CSA_KM_R_EVEC_*.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

lagFile = fullfile(myFolder, '450_CSA_CG_lag.txt'); %read in lag file
lagData = load(lagFile, '-ascii');

%global variables
pep = 'CSA';
temp = 450;
ns = 2;

%TIME STEP
tStep = 500e-12; %time step is 500 ps
%tstep = 2*(500e-12); %t step for 2 simulations only

%empty matrix
pEqconv = zeros(length(theFiles),ns+1);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    
    data=load(fullFileName,'-ascii') ;
    
    V = data(:,1) ; %read in V the right evector
    
    for a = 1:ns
        pEqconv(k,a) = V(a,1)/sum(V(:,1));
    end
    
    lag = lagData(k); %load the correct lag time for the TM created.
    lagTime = lag*tStep; % lag time in seconds
    
    pEqconv(k,3) = lagTime;
    
end

%%

file_name = sprintf('%d_%s_KM_Peq_LagT.txt',temp,pep);
dlmwrite(file_name, pEqconv, 'delimiter', '\t');

%%

x = pEqconv(:,1).*100;
y = pEqconv(:,2).*100;
z = pEqconv(:,3).*(1e+9);

plot(z , x)

ylabel('Peq State 1 (%)')
xlabel('lag time (ns)')

ylim([0 70])

