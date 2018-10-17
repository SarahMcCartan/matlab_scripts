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

f_in=fullfile(myFolder,'450_CSA_CG_3_TBA_peq.txt');
pop=load(f_in,'-ascii') ; 



%r = pop(:,1);
p1 = pop(:,1);
p2 = pop(:,2);
%p3 = pop(:,3);
%p4 = pop(:,4);

r = linspace(1,length(pop),length(pop));

figure() 

plot(r, p1, 'b-')
xlabel('R')
ylabel('Peq')
ylim([0 0.75])


figure()
plot(r, p2, 'g-')
xlabel('R')
ylabel('Peq')
ylim([0 0.75])


%figure()
%plot(r, p3, 'b-')
%xlabel('R')
%ylabel('Peq')
%ylim([0 0.75])
%yticks([1 2 3 ])


%figure()
%plot(r, p4, 'b-')
%xlabel('R')
%ylabel('Peq')
%legend('p1','p2','p3')

%xlim([0 3])
%xticks([0 1 2 3])
%yticks([ 1 2 3 ])
