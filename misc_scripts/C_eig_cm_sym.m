close all
clear variables

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

f_in=fullfile(myFolder,'310_CSA_CG_PM_10.txt');
CMS=load(f_in,'-ascii') ;  %load in symetrix count matrix
%State = data(:,2); %state data in second col
%get eigenvalues & populations from the symmetrised count matrix
f_in='dcsa_510_CM_SYM.txt';
CM_data=load(f_in,'-ascii') ; 

%variables:
temp = 310; %temperature of simulation
pep = 'CSA'; %csa or dcsa peptide
lag = 10; %lag time
tstep = 500e-12; %time step in ps

[V D W] = eig(CM_data); %V = right evectors, D = eigenvalues, W = left evectors
%the Prob Matrix/Transistion Matrix is a left stochastic matrix
%square real matrix with columns summing to 1
%it is not symmetric and V and W will not nec be the same

time = lag*tstep; %total time

rel_t = time*(1./CM_eigs); % work out relaxation time 

Pop = sum(CM_data); % gives population of each state

file_name1 = sprintf('%d_%s_CM_eigs_%d.txt',temp,pep,lag);
file_name2 = sprintf('%d_%s_CM_Pop_%d.txt',temp,pep,lag);
file_name3 = sprintf('%d_%s_CM_rel_t_%d.txt',temp,pep,lag);

dlmwrite(file_name1, CM_eigs, 'delimiter', '\t'); 

dlmwrite(file_name2, Pop, 'delimiter', '\t'); 

dlmwrite(file_name3, rel_t, 'delimiter', '\t'); 
