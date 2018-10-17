close all
clear variables
%% CODE to find Eigenvalues & Eigenvectors of the Transition/Probability
%% Matrix (PM) created from the Symmetric CM which was made with sliding window technique
% aim to estimate the relaxation time

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\Gillespie';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '2_TEST_KM_0*.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

lagfile = fullfile(myFolder, '2_TEST_lagVals.txt'); %read in lag time step file
lagdata = load(lagfile, '-ascii');

%get eigenvalues & populations from the rate matrix

%variables:
temp = 2;  %temperature of simulation
pep = 'TEST'; %csa or dcsa peptide
ns =2; %no. of states

tstep = 500e-12; %time step in s = 500ps / 0.5ns
%tstep = 2*(500e-12); %t step for 2 simulations only (dcsa 310 & 510)


for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    % such as reading it in as an image array with imread()
    
    TM=load(fullFileName,'-ascii') ;
    
    [V, D, W] = eig(TM); %V = right evectors, D = eigenvalues, W = left evectors
    
    %the Prob Matrix/Transistion Matrix is a left stochastic matrix
    %square real matrix with columns summing to 1
    %it is not symmetric and V and W will not nec be the same
    
    lag = lagdata(k); %load the correct lag time for the TM created. 
    time = lag*tstep; %total time

    %sort eigenvalues and vectors in descending order s.t. eval = 1 is first
    [D,idx] = sort(diag(D), 'descend');
    V = V(:, idx);
    W = W(:,idx);
    
    rel_t = time*(1./D); % work out relaxation time
    % 1/lamda = relaxation time, second largest evalue gives slowest rel time
    %one evalue will be 1, rest will be <1 for PM
    % one eval will be 0, rest <1 for KM

    file_name1 = sprintf('%d_%s_KM_EVAL_%04d.txt',temp,pep,k);
    %file_name2 = sprintf('%d_%s_PM_Pop_%d.txt',temp,pep,lag);
    file_name3 = sprintf('%d_%s_KM_REL_T_%04d.txt',temp,pep,k);
    file_name4 = sprintf('%d_%s_KM_R_EVEC_%04d.txt',temp,pep,k);
    file_name5 = sprintf('%d_%s_KM_L_EVEC_%04d.txt',temp,pep,k);
    
    
    dlmwrite(file_name1, D, 'delimiter', '\t');
    %dlmwrite(file_name2, Pop, 'delimiter', '\t');
    dlmwrite(file_name3, rel_t, 'delimiter', '\t');
    dlmwrite(file_name4, V, 'delimiter', '\t');
    dlmwrite(file_name5, W, 'delimiter', '\t');
    
end
