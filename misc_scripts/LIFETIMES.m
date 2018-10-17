
%LIFETIMES

	%%run length encoding/decoding to find the lifetime of each state
	%find avg number of frames per state 

	num= [ find(State(1:end-1) ~= State(2:end)) length(State) ];
	len1=diff([0 num]);
	val1=State(num);

	VLM_state=[val1', len1']; 
	fname10 =  sprintf('R%d_%d_%s_Len_vals_check.txt',n_iter,temp,pep);

	dlmwrite(fname10, VLM_state, 'delimiter', '\t'); %write out to txt file

	%find indices to elements in first column of VLM_state that satisfy:

	ind1= VLM_state(:,1)==1;
	ind2= VLM_state(:,1)==2;
	ind3= VLM_state(:,1)==3;
	%ind4= VLM_state(:,1)==4;

	%use the logical indices to index into VLM_state to return required sub
	%matrices

	S1= VLM_state(ind1,:);
	S2= VLM_state(ind2,:);
	S3= VLM_state(ind3,:);
	%S4= VLM_state(ind4,:);

	%sum frames for each state 

	S1_mean=mean(S1);
	S2_mean=mean(S2);
	S3_mean=mean(S3);
	%S4_mean=mean(S4);

	%call out second column in each mean this is mean num frames each state
	%lived for i.e. mean lifetime

	T1=S1_mean(2);
	T2=S2_mean(2);
	T3=S3_mean(2);
	%T4=S4_mean(2);