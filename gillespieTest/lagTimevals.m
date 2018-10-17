close all
clear variables

myMat = zeros(87,1);
iter = 0;
for lag = 1:100:8601
    
    iter = iter+1;
    myMat(iter) =lag;
end

file_name = sprintf('2_TEST_lagTime.txt');

dlmwrite(file_name, myMat, 'delimiter', '\t');
