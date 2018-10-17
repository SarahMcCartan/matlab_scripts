close all
clear variables

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\450_dCSA';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

f_in=fullfile(myFolder,'R20_450_dCSA_TBA_states.txt');
states=load(f_in,'-ascii') ; 

temp = 450;
lag = 1;
pep = 'dCSA';
ns = 2;

%plot state vs time after TBA applied

%states=State' ;  

%create time vector in microseconds
%convert time based on step size either 0.5ns or 1ns
tconv = 0.0005;
tconv2 = 0.001;
time = linspace(0,length(states)*tconv,length(states));
t = time';

st = [t , states];
fname15 =  sprintf('%d_%s_TBA_traj_%d.txt',temp,pep,lag);
dlmwrite(fname15, st, 'delimiter','\t') ;

figure() 

plot(t(:,1), states(:,1), 'b-')

xlabel('time (\mu s) ')
ylabel('state')

xlim([0 3])
ylim([0 3.5])
xticks([0 1 2 3])
yticks([ 1 2 3 ])