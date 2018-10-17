close all
clear variables

%% CODE FOR PROB MATRIX FROM SYM COUNT MATRIX

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG\lagConvTest';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

%Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '310_CSA_CM_SYM_*.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

%%global variables set
temp = 310;
pep = 'CSA';
ns = 2; %number of states
%lag =10;

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    % such as reading it in as an image array with imread()
    
    CMS=load(fullFileName,'-ascii') ;
    PM = zeros(ns,ns);
    
    for i =1:ns
        for j =1:ns
            if i ~= j   
                %PM(i,j) = CMS(i,j)./sum(CMS(:,j)); %turn counts to probs
                PM(i,j) = rdivide(CMS(i,j),sum(CMS(:,j)));
            end
        end
    end
    
    PSUM = sum(PM); %get totals for each col in PM
    
    for p = 1:ns
        PM(p,p) = 1 - PSUM(p); % all columns must sum to 1
    end
    
    %check sums of each column equal 1:
    
    for l = 1:ns
        
        if sum(PM(:,l)) == 1
            disp(l)
            disp('TM columns sum to 1')
        else
            disp(l)
            disp('error in TM')
        end
        
    end
    
    file_name2 = sprintf('%d_%s_PM_%04d.txt',temp,pep,k);
    
    dlmwrite(file_name2, PM, 'delimiter', '\t');
    
    %% rate matrix
    KM = PM;
    
    for p = 1:ns
        for q = 1:ns
            if p == q
                KM(p,p) = 0; %remove diagonal values
            else
                KM(p,q) = round(KM(p,q),4);
            end
        end
    end
    
    KSUM = sum(KM); %get totals for each col in KM
    
  
    
    for m = 1:ns
        KM(m,m) = 0 - KSUM(m); % all columns must sum to 0
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
    
    file_name3 = sprintf('%d_%s_KM_%04d.txt',temp,pep,k);
    
    dlmwrite(file_name3, KM, 'delimiter', '\t');
    
end
