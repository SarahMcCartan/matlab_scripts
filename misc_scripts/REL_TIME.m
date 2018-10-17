close all
clear variables
%% CODE to find Eigenvalues & Eigenvectors of the Transition/Probability
%% Matrix (PM) created from the Symmetric CM which was made with sliding window technique
% aim to estimate the relaxation time

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

f_in=fullfile(myFolder,'310_CSA_CG_TM_10.txt');
TM=load(f_in,'-ascii') ;  %load in Prob Matrix 
%get eigenvalues & populations from the symmetrised count matrix

%variables:
temp = 310; %temperature of simulation
pep = 'CSA_CG'; %csa or dcsa peptide
%lag = 10; %lag time
tstep = 500e-12; %time step in ps
%tstep2 = 2*tstep; %t step for 2 simulations only



[V, D, W] = eig(TM); %V = right evectors, D = eigenvalues, W = left evectors
%the Prob Matrix/Transistion Matrix is a left stochastic matrix
%square real matrix with columns summing to 1
%it is not symmetric and V and W will not nec be the same

time = lag*tstep; %total time

%sort eigenvalues and vectors in descending order s.t. eval = 1 is first
[D,idx] = sort(diag(D), 'descend');
V = V(:, idx);
W = W(:,idx);

rel_t = time*(1./D); % work out relaxation time 
% 1/lamda = relaxation time, second largest evalue gives slowest rel time
%one evalue will be 1, rest will be <1

Pop = sum(TM); % gives population of each state, estimate only

file_name1 = sprintf('%d_%s_PM_EVAL_%d.txt',temp,pep,k);
file_name2 = sprintf('%d_%s_PM_Pop_%d.txt',temp,pep,k);
file_name3 = sprintf('%d_%s_PM_REL_T_%d.txt',temp,pep,k);
file_name4 = sprintf('%d_%s_PM_R_EVEC_%d.txt',temp,pep,k);
file_name5 = sprintf('%d_%s_PM_L_EVEC_%d.txt',temp,pep,k);


dlmwrite(file_name1, D, 'delimiter', '\t'); 
dlmwrite(file_name2, Pop, 'delimiter', '\t'); 
dlmwrite(file_name3, rel_t, 'delimiter', '\t'); 
dlmwrite(file_name4, V, 'delimiter', '\t'); 
dlmwrite(file_name5, W, 'delimiter', '\t'); 

