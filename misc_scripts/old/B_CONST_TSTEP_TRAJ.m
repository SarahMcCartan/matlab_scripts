clear variables

%%
%Code to create constant time step trajectory from the Gillespie traj
%which contains the length of time each state lived for before
%transitioning to new state

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG\GillTest';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

ns = 2; % number of states
T = 310; %temp in Kelvin
peptide = 'CSA_GILL';

fin1 = fullfile(myFolder, '310_CSA_GILL_States.txt'); %read in traj w/uneven tstep
data = load(fin1, '-ascii');
%s = data(1:100,2);
s = data(:,2);

%t = data(1:100,1).*0.5e-9; %time data converted to seconds
t = data(:,1); %time data converted to seconds

%%
bins = 100;
NN = 10000; %no of transitions (set in Gill_Test m file)

tim=linspace(0,t(end),bins*NN); % We discretize the time
ind=1; %index starting at 1 

for i=1:bins*NN
   while tim(i) > t(ind)
      ind=ind+1;
   end
   state(i)=s(ind);
end

%%
const_t = [tim' state']; %save out time and state
file_name4 = sprintf('%d_%s_TRAJ.txt',T,peptide);
dlmwrite(file_name4, const_t , 'delimiter','\t',  'precision','%.5f');

%%
%time2 = tim';
%file_name5 = sprintf('%d_%s_const_t.txt',T,peptide);
%dlmwrite(file_name5, time2 , 'delimiter', '\t', 'precision','%.5f');


