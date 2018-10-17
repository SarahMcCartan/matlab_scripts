close all

f_in='dcsa_510_Len_Vals_check.txt';
state_lifetime =load(f_in,'-ascii') ; 


ind1= state_lifetime(:,1)==1; 
ind2= state_lifetime(:,1)==2;
ind3= state_lifetime(:,1)==3;
%ind4= state_lifetime(:,1)==4;

%pulls out just the lifetimes of each state.
S1= state_lifetime(ind1,:);
S2= state_lifetime(ind2,:);
S3= state_lifetime(ind3,:);
%S4= state_lifetime(ind4,:);

dlmwrite('dcsa_510_lifetimes_s9.txt', S1, 'delimiter','\t') ; %write out to txt file
dlmwrite('dcsa_510_lifetimes_s10.txt', S2, 'delimiter','\t') ; %write out to txt file
dlmwrite('dcsa_510_lifetimes_s11.txt', S3, 'delimiter','\t') ; %write out to txt file
%dlmwrite('csa_450_lifetimes_s4.txt', S4, 'delimiter','\t') ; %write out to txt file



