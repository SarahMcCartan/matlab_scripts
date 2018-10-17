

%% FUNCTION TO BUILD A PROBABILITY MATRIX FROM A SYMMETRIC TRANSITION COUNT MATRIX
% CODE ALSO BUILDS A RATE MATRIX BUT POSSIBLY USES INCORRECT METHOD -
% RELOOK
%in = location of input files
%out = location of output files
%temp = Temperature of simulation
%pep = name of peptide
%ns = number of states
%data = input Symmetrised Count Matrix
%lag = file of lag values needed for K1
%OUTPUTS ARE:   PM = prob matrix per lag val
%               K1 = rate matrix by method 1 
%               K2 = rate matrix by methods 2 (summing PM cols to 0)

function pm = probmat(in,out,data,totalT,lag,ns,tstep,temp,pep)

P = pwd; %find current dir

% Specify the folder where the files live.
myFolder =  sprintf('%s\\%s\\', P,in);
foldCheck(myFolder); %check folder exists

%specify output folder
OutFolder =  sprintf('%s\\%s', P,out);
foldCheck(OutFolder);

%Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, data); % Change to whatever pattern you need.
theFiles = dir(filePattern);

lagfile = fullfile(myFolder, lag); %read in lag time step file
lagdata = load(lagfile, '-ascii');

%totalTfile = fullfile(myFolder, data2);
%totalTdata = load(totalTfile, '-ascii');
%totalT = length(totalTdata);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    
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
            disp('PM cols sum to 1')
        else
            disp(l)
            disp('PM Error')
        end
        
    end
    
    fout1 = fullfile(OutFolder,sprintf('%d%s_PM%06d.txt',temp,pep,k));
    dlmwrite(fout1, PM, 'delimiter', '\t');
    
    %% Rate Matrix 1
    %test to make a  Rate Matrix from the Prob Matrix - relook also
    % CM(tau) = exp(K*tau)  where tau is lag time
    % K = 1/tau * ln (PM(tau))
    
    tau = lagdata(k)*tstep;
    K = CMS/totalT;
    
    for x = 1:ns
        for y = 1:ns
            if x == y
                K(x,x) = 0; %remove diagonal values
            else
                K(x,y) = K(x,y);
            end
        end
    end
    
    KSUM2 = sum(K); %get totals for each col in KM
    
    for z = 1:ns
        K(z,z) = 0 - KSUM2(z); % all columns must sum to 0
    end
    
    fout2 = fullfile(OutFolder,sprintf('%d%s_KA%06d.txt',temp,pep,k));
    dlmwrite(fout2, K, 'delimiter', '\t');
    
    
    
    %% Rate matrix 2, possibly wrong technique (see above for possibly more correct)
    
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
            disp('KM cols sum to 1')
        else
            disp(o)
            disp('KM error')
        end
        
    end
    
    fout3 = fullfile(OutFolder, sprintf('%d%s_KB%06d.txt',temp,pep,k));
    dlmwrite(fout3, KM, 'delimiter', '\t');
    
    pm =PM;
    
    
end

end

