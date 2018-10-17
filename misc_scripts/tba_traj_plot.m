
%factor to convert to microseconds
t_conv = 0.0005;
t_conv2 = 0.001;
time = linspace(0,length(states)*t_conv,length(states));
t = time';

f_in='R4_450_CSA_12_TBA_states.txt';
states=load(f_in,'-ascii') ; 
n_iter = 4;
temp = 450;
pep = 'CSA_12';

st = [t , states];
fname15 =  sprintf('R%d_%d_%s_TBA_traj.txt',n_iter,temp,pep);
dlmwrite(fname15, st, 'delimiter','\t') ;

figure() 

plot(t(:,1), states(:,1), 'b-')

xlabel('time (\mu s) ')
ylabel('state')

xlim([0 3])
ylim([0 4.5])
xticks([0 1 2 3])
yticks([ 1 2 3 4])