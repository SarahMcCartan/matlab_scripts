
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA';

filename='R6_310_CSA_TBA_states.txt';
f_in = fullfile(myFolder, filename); 

states=load(f_in,'-ascii') ; 
R = 6;
temp = 310;
pep = 'CSA';

%factor to convert to microseconds
t_conv = 0.0005;
t_conv2 = 0.001;
time = 0:t_conv:((length(states)*t_conv)-t_conv);
t = time';

st = [t , states];
fname15 =  sprintf('R%d_%d_%s_TBA_traj.txt',R,temp,pep);
dlmwrite(fname15, st, 'delimiter','\t') ;

figure() 

plot(t(:,1), states(:,1), 'b-')

xlabel('time (\mu s) ')
ylabel('state')
legend('whole')

xlim([0 3])
ylim([0 3.5])
xticks([0 1 2 3])

figure()

plot(t(1:(length(t))/2,1), states(1:(length(states))/2,1), 'r-')

xlabel('time (\mu s) ')
ylabel('state')
legend('1st half')

xlim([0 1.5])
ylim([0 3.5])
xticks([0 1 2 3])

figure()
plot(t(length(t)/2:length(t),1), states((length(states))/2:length(states),1), 'g-')

xlabel('time (\mu s) ')
ylabel('state')
legend('2nd half')

xlim([1.5 3])
ylim([0 3.5])
xticks([0 1 2 3])
yticks([ 1 2 3 ])



%%
%conv test using histogram



 

data1 = states(:,1);
data2 = states(1:(length(states))/2,1);
data3 = states((length(states))/2:length(states),1);


bins = 30;


figure()
hist(data3)
xlabel('State')
ylabel('Frequency')
legend('2nd half')
figure()
hist(data2)
xlabel('State')
ylabel('Frequency')
legend('1st half')
figure()
hist(data1)

xlabel('State')
ylabel('Frequency')
legend('whole')











