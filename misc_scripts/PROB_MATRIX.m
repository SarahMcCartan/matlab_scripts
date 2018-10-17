close all
clear variables

%% CODE FOR PROB MATRIX FROM SYM COUNT MATRIX

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

f_in=fullfile(myFolder,'310_CSA_CG_CM_SYM_10.txt');
CMS=load(f_in,'-ascii') ;  %load in symetrix count matrix
%State = data(:,2); %state data in second col

%%global variables set
temp = 310;
pep = 'CSA_CG';
ns = 2; %number of states
lag =10;

TM = zeros(ns,ns);


%%

for i =1:ns
    for j =1:ns
        if i ~= j
            
            TM(i,j) = CMS(i,j)./sum(CMS(:,j)); %turn counts to probs
            
        end
    end
end



PSUM = sum(TM); %get totals for each col in PM

for k = 1:ns
    TM(k,k) = 1 - PSUM(k); % all columns must sum to 1
end

%check sums of each column equal 1:

for l = 1:ns
    
    if sum(TM(:,l)) == 1
        disp(l)
        disp('TM columns sum to 1')
    else
        disp(l)
        disp('error in TM')
    end
    
end




file_name2 = sprintf('%d_%s_TM_%d.txt',temp,pep,lag);

dlmwrite(file_name2, TM, 'delimiter', '\t'); 
            
%% rate matrix
KM = TM;


for m = 1:ns
    KM(m,m) = 0 - PSUM(m); % all columns must sum to 0
end

%check sums of each column equal 1:

for o = 1:ns
    
    if sum(KM(:,o)) == 0
        disp(o)
        disp('KM columns sum to 1')
    else
        disp(o)
        disp('error in KM')
    end
    
end