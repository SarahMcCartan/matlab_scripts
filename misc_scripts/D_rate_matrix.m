close all

%MASTER MATLAB CODE 2 
%RATE MATRIX GENERATION

f_in='310_CSA_CM_SYM_conv.txt';
f_in2 ='R6_310_CSA_Life_T_Avg.txt';
CMS=load(f_in,'-ascii') ; 
Life_T = load(f_in2, '-ascii');

%variables
temp = 310; %temperature of simulation
pep = 'CSA'; %csa or dcsa peptide
lag = 1; %lag time
%LB method uses lag time, have defined the lagtime here, set to 1 for now.
%define lagtime in n steps which is n*500ps (time between each step)
R = 0.14;
ns = 3;

N=sum(CMS); %total number of transitions from l to i where l goes from l to
%3

%gives transition matrix where PM(i,j)= CM(i,j)/sumC(i,l)
%here sum(C(i,l))==N(i)


PM=zeros(ns,ns);

for i = 1:ns
   for j = 1:ns
       if i == j

        PM(i,j)=CMS(i,j)./(N(i));
       else
        PM(i,j) = CMS(i,j)./N(i);
        
       end
   end
end


fname13 =  sprintf('%d_%s_PM_%d.txt',temp,pep,lag);

dlmwrite(fname13, PM, 'delimiter', '\t'); %write out to txt file


%create rate matrix K
K=zeros(ns,ns);

for k = 1:ns
    for l = 1:ns
        if k ==l
            K(k,l) = -1./(Life_T(k));
        else
            K(k,l) = CMS(k,l)./N(k);
        end
    end
end


%K(i,j) = BP(i,j)/T(i)
%branching probability of going from state i to j
%is N(i,j)sym/(sum of N(l,i)) where N is number of transitions
%the below gives output of a mathematically correct rate matrix or
%infinetismal generator, however I have not divided by the lifetime..need
%to investigate more


fname14 =  sprintf('%d_%s_Rate_Matrix_conv_%d.txt',temp,pep,lag);
dlmwrite(fname14, K, 'delimiter', '\t'); %write out to txt file

%%
%find stationary distribution of K which is the equilibrium pop
%singular value decompositing to get peq that satisifies K*peq=0
%this is not working, need to get non trivial answer here, matlab returning
% all zeros. Can work out by hand but not ideal

%[U S V] = svd(inv(K));
%peq=V(:,end);

%%
%sym rate matrix K as Ksym = Peq^-1/2  * K * Peq^1/2

%f_in3 ='310_CSA_Life_T_Avg.txt';
%CMS=load(f_in,'-ascii') ;

%%
%PM

PM = K;
for z = 1:3
     PM(z,z) = CMS(z,z)/N(z);
end

fname15 =  sprintf('%d_%s_PM_conv_%d.txt',temp,pep,lag);
dlmwrite(fname15, PM, 'delimiter', '\t'); %write out to txt file
 