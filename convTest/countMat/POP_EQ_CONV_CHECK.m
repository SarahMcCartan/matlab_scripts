
close all
%load in count matrix for whole and half trajs
f1='510_dCSA_count_matrix_TBA.txt';
f2='510_dCSA_1half_count_matrix_TBA.txt';
f3='510_dCSA_2half_count_matrix_TBA.txt';

data1 =load(f1,'-ascii') ; 
data2 =load(f2,'-ascii') ; 
data3 =load(f3,'-ascii') ; 

temp = 510;
pep = 'dCSA';

%whole traj
pop1 = sum(data1);
total1 = sum(pop1);
pop_percent1 = pop1./total1;

%1half
pop2 = sum(data2);
total2 = sum(pop2);
pop_percent2 = pop2./total2;

%2half
pop3 = sum(data3);
total3 = sum(pop3);
pop_percent3 = pop3./total3;

pop = [pop1 ; pop2 ; pop3];
pop_percent = [pop_percent1 ; pop_percent2 ; pop_percent3];
  

fname1 =  sprintf('%d_%s_pop_percent_conv.txt', temp,pep);
fname2 = sprintf('%d_%s_pop_conv.txt', temp,pep);
fname3 = sprintf('%d_%s_PEQ1.txt', temp,pep);

dlmwrite(fname1, pop_percent, 'delimiter', '\t'); 
dlmwrite(fname2, pop, 'delimiter', '\t'); 
dlmwrite(fname3, pop1, 'delimiter', '\t'); 

 





    