close all
clear variables

%% CODE FOR PROB MATRIX FROM SYM COUNT MATRIX

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\510_CSA\lagtest';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return; 
end

%Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '510_CSA_CM_SYM_*.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
%State = data(:,2); %state data in second col
%%global variables set
temp = 510;
pep = 'CSA';
ns = 3; %number of states
%lag =10;

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    % such as reading it in as an image array with imread()
    
    CMS=load(fullFileName,'-ascii') ;
    
    %Make Probabilty Matrix
    PM = zeros(ns,ns);
    
    for i =1:ns
        for j =1:ns
            if i ~= j
                
                PM(i,j) = round(CMS(i,j)./sum(CMS(:,j)),4); %turn counts to probs
                
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
    
    %% Make Rate matrix from PM
    KM = PM;
    
    %remove diagonals 
    for p = 1:ns
        for q = 1:ns
            if p == q
                KM(p,p) = 0; %remove diagonal values
            
            end
        end
    end
    
    
    KSUM = (sum(KM)); %get totals for each col in KM
    
    
    for m = 1:ns
        KM(m,m) = (-1)*abs(KSUM(m)); % all columns must sum to 0
    end
    
    %check sums of each column equal 1:
    
    for o = 1:ns
        
        if sum(KM(:,o)) == 0
            disp(o)
            disp('KM column sum to 1')
  
        else
            disp(o)
            disp('error in KM col')
        end
        
    end
    
    file_name3 = sprintf('%d_%s_KM_%04d.txt',temp,pep,k);
    
    dlmwrite(file_name3, KM, 'delimiter', '\t');
    
end
