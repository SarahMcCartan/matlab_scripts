close all

%find unique stationary distribution 

f_in ='310_CSA_PM_conv_1.txt';
PM=load(f_in,'-ascii') ;

%find eigenvalues and vectors of prob matrix
[V,D] = eig(PM');

dd = round(diag(D),4);

%find D values = 1
ix = find(dd == 1);
(D(ix,ix));

%Extract the analytical stationary distributions. 
%The eigenvectors are normalized with the 1-norm or sum(abs(X)) prior to display.


for k = ix'
    V(:,k) = V(:,k)/norm(V(:,k));
end
Probability = V(:,ix);

%%
f2 = '310_CSA_Rate_Matrix_conv_1.txt';
%KM = load(f2,'-ascii');
%[V2, D