close all
clear variables

%WANT TO PLOT POP of S1 vs Lag Time to check conv..

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\510_CSA\lagtest';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '510_CSA_KM_R_EVEC_*.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

lagFile = fullfile(myFolder, '510_CSA_CG_lag.txt'); %read in lag file
lagData = load(lagFile, '-ascii');

%global variables
pep = 'CSA';
temp = 510;
ns = 3;

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
    
    V = data(:,1) ; %read in V(lamda1 = 0) = Peq
    
    for a = 1:ns
        pEqconv(k,a) = V(a,1)/sum(V(:,1));
    end
    
    lag = lagData(k); %load the correct lag time for the TM created.
    lagTime = lag*tStep; % lag time in seconds
    
    pEqconv(k,(ns+1)) = lagTime;
    
end

%%

Mean = mean(pEqconv);
file_name = sprintf('%d_%s_KM_Peq_LagT.txt',temp,pep);
dlmwrite(file_name, pEqconv, 'delimiter', '\t');

file_name2 = sprintf('%d_%s_KM_Peq_Mean.txt',temp,pep);
dlmwrite(file_name2, Mean, 'delimiter', '\t');

%%

x = pEqconv(:,1).*100; %state 1
y = pEqconv(:,2).*100; %state 2
%a = pEqconv(:,3).*100; %state 3
z = pEqconv(:,ns+1).*(1e+9); %lag time

plot(z , x)

ylabel('Peq State 1 (%)')
xlabel('lag time (ns)')
 
ylim([0 70])

