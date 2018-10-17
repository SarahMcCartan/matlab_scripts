
close all
clear variables

%% CODE SYMMETRISING COUNT MATRIX
%MAKE CIJ = CJI BY (CIJ+CJI)/2

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG\lagt_test';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

f_in=fullfile(myFolder,'310_CSA_CG_COUNT_MATRIX_TBA_10.txt');
CM=load(f_in,'-ascii') ; 



%variables per simulation
ns = 2; %number of states
temp = 310; %temperature of simulation
pep = 'CSA_CG_lagtest'; %csa or dcsa peptide

lag = 10;

POP = sum(CM);
CM_sym=zeros(ns,ns);

%calc averages of C(ij) and (Cji)


for i=1:ns
    for j=1:ns
        if i ~= j
            
            CM_sym(i,j) = (CM(i,j) + CM(j,i))/2 ; 
            
        end
        
    end
    
end



%Diagonal of new matrix to be same as old matrix

for x = 1:ns
    CM_sym(x,x) = CM(x,x);
    
end

POP2 = sum(CM_sym); %sum of each col

%adjust the diagonal count to keep total pop as unsymm matrix

for y = 1:ns
    if POP(y) ~= POP2(y)
        CM_sym(y,y) = CM_sym(y,y) + (POP(y)-POP2(y));
        y;
    end
    
end

POP3 = sum(CM_sym); %check the new sum is as per POP

if POP == POP3
    disp('populations consistent')
    
end

file_name1 = sprintf('%d_%s_CM_SYM_%d.txt',temp,pep,lag);

dlmwrite(file_name1, CM_sym, 'delimiter', '\t'); 


