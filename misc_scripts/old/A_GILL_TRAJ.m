
%%GILLESPIE ALGORITHM TO GENERATE LONGER TIME SERIES DATA FOR CSA & DCSA
% AIM CHECK IF REL T IS CONVERGED FOR HIGH LAG T

%%
%Section 1: read in data

% % Specify the folder where the files live.
 myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG\lagTest2';
% % Check to make sure that folder actually exists.  Warn user if it doesn't.
foldCheck(myFolder);

ns = 2; % number of states
T = 310; %temp in Kelvin
peptide = 'CSA_GILL';

fin1 = fullfile(myFolder, '310_CSA_CG_KM_0000112.txt'); %read in rate matrix
K = load(fin1, '-ascii');

N= ns;
%%
%'Section 1: Generating random rate matrix')

% N = number of states
% K(i,j) rate constant for the i --> j process
% rand is a subroutine that generates a uniformly
% distributed random number between (0,1)
%N=ns;
%for i=1:N-1
%	K(i,i+1)=10*rand;
%	K(i+1,i)=10*rand;
%end
% Add a stochastic "bottle neck" between states 1 and 2, by setting smaller rates here
%K(2,1)=rand;
%K(1,2)=rand;
%for i=1:N
%	K(i,i)=-sum(K(:,i));
%end

%display(K)

%%
%'Section 2: Spectral decomposition (getting eigenvalues/vectors) and 
%finding equilibrium probability vector')
%calculate equilibrium from spectral decomposition

[eigvec,eigval]=eig(K); % diagonalize K, eigvec stores the eigenvectors, eigval the eigenvalues
display(eigval)

[dsorted,index]=sort(diag(eigval),'descend'); 
% sort the eigenvalues. dsorted stores the eigenvalues, index the corresponding indices

% Plot of sorted eigenvalues
figure
hold on
x=linspace(1,N,N);
plot(x,dsorted,'o')
ylabel('Eigenvalue','FontSize',18)
% sorted eigenvalues:
ind=index(1); %index corresponding to 0 eigenvalue

Peq=eigvec(:,ind)/sum(eigvec(:,ind)); % equilibrium probability corresponds to 0 eigenvalue. Based on the equilibrium probability we can also obtain the energy.
%display(Peq)


%%
%'Section 4: Finding second right eigenvector'

% splitting and eigvec
[eigvec,eigval]=eig(K'); % diagonalize K, eigvec stores the right eigenvectors
[dsorted,index]=sort(diag(eigval),'descend'); % sort the eigenvalues. 

display(dsorted)

slowest_relrate=-dsorted(2);
slow_vec=eigvec(:,index(2));


%% Run Gillespie to obtain trajectories ..................................
for i=1:ns
  for j=1:ns
    if ( i ~= j ) % i =\= j 
       p(j,i)=K(j,i)/(-K(i,i));
    end
  end
end

for j=1:ns
pp(1,j)=0;
for i=1:ns
  pp(i+1,j)=sum(p(1:i,j)); % The pp matrix stores cumulative transition probabilities
end
end

s=1; %starting state
time=0; 
tcum=zeros(ns,1); % creates a vector of N elements

NN=10000; % Number of transitions
for k=1:NN
        tadd=(1/K(s,s))*log(rand); % tadd is the survival time the system stays in state s. 
        %It is calculated based on a single exponential decay for the survival time.
        time=time+tadd; %time=total time
        t_traj(k)=time; %t_traj matrix saves information about the survival times
        s_traj(k)=s;    %s_traj matrix saves information about the current state
        
        ss=find(histc(rand,pp(:,s))); % finds the new state
        tcum(s)=tcum(s)+tadd; % total time that the system spends in state s
        s=ss; %the new state is ss
end

states_time = [ t_traj' s_traj'];
file_name1 = sprintf('%d_%s_States.txt',T,peptide);
dlmwrite(file_name1, states_time, 'delimiter', '\t');

%file_name2 = sprintf('%d_%s_Time_TRAJ.txt',T,peptide);
%dlmwrite(file_name2, t_traj, 'delimiter', '\t');
%%
%average time spent in each state / total time = measured euqilibrium probability (p_eq)
fprintf('Comparing the true eigenvector to the trajectories estimate')
measured_Peq=tcum/sum(tcum); 
display(Peq)
display(measured_Peq)
%%

