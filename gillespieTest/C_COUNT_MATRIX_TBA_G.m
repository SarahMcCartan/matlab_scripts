
close all
clear variables

%% CODE FOR SLIDING WINDOW APPROACH TO COUNTING TRANSITIONS
%GOAL to make count matrix for each discrete TBA trajectory

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\310_CSA_CG';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

f_in=fullfile(myFolder,'310_CSA_CG_TRAJ.txt');
data=load(f_in,'-ascii') ;
State = data(:,1); %state data in second col

%global variables set
temp = 310;
pep = 'CSA_CG';
ns = 2; %number of states

CM=zeros(ns,ns); %empty matrix
cs = zeros(1,ns); % count for states

%Lag Values:
a = 10; %start lag time
b = 100; %intervals of lag time
c = 100000; %end lag time
iter = 0; %needed to save the lagVals
lagVals = zeros(floor(a/b)+1 , 1); %matrix to save lag values to.

%%
%SLIDING WINDOW APPROACH
%NEED TO COUNT EVERY X STEPS PER FRAME
for lag = a:b:c
 
    iter = iter+1;
    lagVals(iter) =lag; %save out lag values
    frame=1; %number of frames to apply sliding window to
   
    %sliding window
    % TBA(1) -> TBA(lag), TBA(2) -> TBA(2+lag)
    % generally: TBA((n+1)frame)) -> TBA((n+1)*frame + lag))
    
    w1 = zeros((length(State)-lag-frame+1),1);
    w2 = zeros((length(State)-lag-frame+1),1);
    
    for n = 0:(length(State)-lag-frame)
        
        for j=1:2
            
            if(j==1)
                w=n+1;
                iter_t = 1;
                w1(n+1)=w;
            else
                w=n+lag;
                iter_t = 2;
                w2(n+1)=w;
            end
            
            for st = 1:ns
                % Test for state 1 = s11
                if State(w) == st
                    s_new = st;
                    cs(1,st) = cs(1,st) + 1;
                    %iter_t = iter_t + 1;
                    
                    if iter_t==1 %condition for first state visited
                        s_old = s_new;
                    else
                        CM(s_old,s_new) = CM(s_old,s_new) + 1;
                        s_old = s_new; %update state to count tranisition
                    end
  
                end
              
            end

   
        end
    end
    
    fname1 =  sprintf('%d_%s_Count_Matrix_TBA_%07d.txt',temp,pep,lag);
    dlmwrite(fname1, CM, 'delimiter', '\t', 'precision','%.5f');
    
    
   % fname2 =  sprintf('%d_%s_Check_Index_%07d.txt',temp,pep,lag);
   % dlmwrite(fname2, [w1 w2], 'delimiter', '\t', 'precision','%.5f');
    CM=zeros(ns,ns); %empty matrix

end

file_name = sprintf('%d_%s_lagVals.txt',temp,pep);
dlmwrite(file_name, lagVals, 'delimiter', '\t');

%%%