

% Specify the folder where the files live.
myFolder = 'C:\Users\Sarah\Documents\MATLAB\CONVERGENCE_POP\COUNT_MATRIX';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*_510__count_matrix.txt'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
ns =3;
temp = 510;
pep = 'dCSA_CHECk';
mymat = zeros(length(theFiles),ns);

for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name,
  % such as reading it in as an image array with imread()
  %f_in='310_csa_pca_12.txt';
  data=load(fullFileName,'-ascii') ;
  
  pop = sum(data);
  total = sum(pop);
  
  pop_percent = pop./total;
  
  mymat(k,:)= pop_percent;
 
  %fname =  sprintf('R%d_310_csa_pop_percent.txt',k);
  %dlmwrite(fname, pop_percent, 'delimiter', '\t');  
  
      
  
  %imageArray = imread(fullFileName);
  %imshow(imageArray);  % Display image.
  %drawnow; % Force display to update immediately.
end

fname =  sprintf('%d_%s_pop_percent.txt', temp,pep);
dlmwrite(fname, mymat, 'delimiter', '\t'); 


    