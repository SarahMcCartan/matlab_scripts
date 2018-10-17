myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG\lagt_test';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

%filePattern = fullfile(myFolder, '310_CSA_CG_lagtest_CM_SYM_*.txt'); % Change to whatever pattern you need.
%theFiles = dir(filePattern);

lagfile = fullfile(myFolder, '310_CSA_CG_lag.txt'); %read in lag file
lagdata=load(lagfile,'-ascii') ; 

for k = 1:19
    lagdata(k)
end


