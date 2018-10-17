clear variables

%find equilibrium population i.e. unique stationary distribution of 
%the rate matrix K

temp = 310;
pep = 'CSA';
ns =3;

myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\COUNT_MATRIX';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
fin = '310_CSA_Rate_matrix_conv_1.txt';
file = fullfile(myFolder, fin); % Change to whatever pat

K = load(file, '-ascii');

% K^T * p = 0
% sum p = 1
% adding these 2 together and adding a row of ones to the end of K^T
% p = (K^T)^-1 * x , where x is a 3 x 1 vector [0 ; 0 ; 0 ; 1].

x = [zeros(3,1) ; 1 ];
KT = K.'; %transpose of matrix K
KT_mod = [KT ; ones(1,3)]; %add row of ones to bottom of KT

% KT_inv = inv(KT_mod); %inverse of KT_mod , needs to be sqaure matrix

p = KT_mod\x; %inverse of KT_mod multiplied by x
%result is the equilbrium population of K 

fname =  sprintf('%d_%s_PEQ_SD.txt',temp,pep);
dlmwrite(fname, p, 'delimiter', '\t'); %write out to txt file

%%
%symmetrise K using p, 1st need to diagonalize p and then get the square.
% K_sym = p^-1/2 * K * p^ 1/2

pd = diag(p); %diagonlize p making it a 3 x 3 matrix w/ p on diag
ps = sqrtm(pd); %get the principal square root of pd

K_sym = ps\K*ps;

[V, D , W] = eig(K_sym); %get the right & left evectors (V,W) and evals (D)
[V1, D1, W1] = eig(K) ; %get the evec and evals of K, note that D and D1 
                        %are the same
                        
                        
%%
%CONSTRUCT 'Perfect' Rate Matrix from the actual rates such that
% KTC(i,i) = -sumKTC(:,i)

KTC = zeros(ns,ns); %empty n X n matrix where n = number of states

for i = 1:ns
    for j = 1:ns
        if i ~=j
            KTC(i,j) = round(KT(i,j), 4);
                 
        end
    end
end

for i = 1:ns
    KTC(i,i) = -1*sum(KTC(:,i));
end

[VC, DC, WC] = eig(KTC);

