
%get eigenvalues & populations from the symmetrised count matrix
f_in='310_csa_CM_SYM_10.txt';
CM_data=load(f_in,'-ascii') ; 

%variables:
temp = 310; %temperature of simulation
pep = 'csa'; %csa or dcsa peptide
lag = 10; %lag time
t_step = 500e-12; %time step

[V, D, W ] = eig(CM_data);
%V = right eigenvector
%D = eigenvalues
%W = left eigenvector

time = lag*t_step; %total time

rel_t = D.*time; % work out relaxation time 

Pop = sum(CM_data); % gives population of each state


file_name1 = sprintf('%d_%s_CM_eigs_%d.txt',temp,pep,lag);
file_name2 = sprintf('%d_%s_CM_Pop_%d.txt',temp,pep,lag);
file_name3 = sprintf('%d_%s_CM_rel_t_%d.txt',temp,pep,lag);
file_name4 = sprintf('%d_%s_CM_EVEC_right_%d.txt',temp,pep,lag);
file_name5 = sprintf('%d_%s_CM_EVEC_left_%d.txt',temp,pep,lag);

dlmwrite(file_name1, D, 'delimiter', '\t'); 
dlmwrite(file_name2, Pop, 'delimiter', '\t'); 
dlmwrite(file_name3, rel_t, 'delimiter', '\t'); 
dlmwrite(file_name4, V, 'delimiter', '\t'); 
dlmwrite(file_name5, W, 'delimiter', '\t'); 

