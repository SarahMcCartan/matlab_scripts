close all
clear variables
%%G

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\Gillespie';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end
ns = 2; % number of states
T = 310; %temp in Kelvin
peptide = 'CSA';

fin1 = fullfile(myFolder, '310_CSA_G_TRAJ.txt'); %read in rate matrix
s = load(fin1, '-ascii');

fin2 = fullfile(myFolder, '310_CSA_Time_TRAJ.txt'); %read in Right Evector
t = load(fin2, '-ascii');

combined = [t'  s'];

file_name2 = sprintf('%d_%s_G_comb.txt',T,peptide);
dlmwrite(file_name2, combined, 'delimiter', '\t');