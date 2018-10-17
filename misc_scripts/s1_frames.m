% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

f_in=fullfile(myFolder,'R15_310_CSA_CG_S1_frames.txt');
s1f=load(f_in,'-ascii');
s1ff = s1f(:,2);


for k = 1:size(s1ff,1)
       idx{k} = find(s1ff(k,:) == 1);
end
