
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

f_in=fullfile(myFolder,'R15_310_CSA_CG_TBA_states.txt');
data=load(f_in,'-ascii') ; 
State = data(:,1); %state data in second col

%global variables set
temp = 310;
pep = 'CSAt';
ns = 2; %number of states

CM=zeros(ns,ns); %empty matrix
%count for each state
cs1_n=0;
cs2_n=0;


%SLIDING WINDOW APPROACH
%NEED TO COUNT EVERY X STEPS PER FRAME

for lag = 10:5:4000
%lag = 10; %lag time
frame=1; %number of frames to apply sliding window to
%iter_t = 0; %number of iterations, needed for 1st state count
%iter = 0;% iterations needed for the sliding window
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
     

    %for w=start:lag:length(State)
    %disp(w)

		% Test for state 1 = s11
		if State(w) == 1
			s_new = 1;
			cs1_n = cs1_n + 1;
			%iter_t = iter_t + 1;
			
			if iter_t==1 %condition for first state visited
				s_old = s_new;
			else  
				CM(s_old,s_new) = CM(s_old,s_new) + 1;
				s_old = s_new; %update state to count tranisition
			end

		% Test for state 2 = s12   
		elseif State(w) == 2
			s_new = 2;
			cs2_n = cs2_n + 1;
			%iter_t = iter_t + 1;
			
			if iter_t == 1
				s_old = s_new;
			else  
				CM(s_old,s_new) = CM(s_old,s_new) + 1;
				s_old = s_new;
			end
			

				
        end
        
     end 
	   
end


fname1 =  sprintf('%d_%s_Count_Matrix_TBA_%04d.txt',temp,pep,lag);
dlmwrite(fname1, CM, 'delimiter', '\t');

fname2 =  sprintf('%d_%s_Check_Index_%04d.txt',temp,pep,lag);
dlmwrite(fname2, [w1 w2], 'delimiter', '\t');

end
%%%