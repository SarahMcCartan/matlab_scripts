close all

f1='450_dCSA_pop_percent.txt';
%f2='csa_450_lifetimes_s2.txt';
%f3='csa_450_lifetimes_s3.txt';
%f4='csa_450_lifetimes_s4.txt';

data =load(f1,'-ascii') ; 
%data2 =load(f2,'-ascii') ; 
%data3 =load(f3,'-ascii') ; 
%data4 =load(f4,'-ascii') ; 

data1 = data(:,1);
data2 = data(:,2);
%data3 = data(:,3);
%data4 = data(:,4);

bins = 30;

%figure()
%h = histfit(data1(:,2), bins,'exponential' );

%counts = frequency value, centres = lifetime value

%[counts, centres] = hist(data1(:,1), bins);
%[counts2, centres2] = hist(data2(:,1), bins);
%[counts3, centres3] = hist(data3(:,1), bins);
%[counts4, centres4] = hist(data4(:,1), bins);

figure()
hist(data1(:,1))


xlabel(' Population Percentage')
ylabel('Frequency')
legend("s1")

figure()
hist(data2(:,1))
xlabel(' Population Percentage')
ylabel('Frequency')
legend("s2")

%figure()

%hist(data3(:,1))
%xlabel(' Population Percentage')
%ylabel('Frequency')
%legend("s3")

%%figure()
%hist(data4(:,1))
%xlabel(' Population Percentage')
%ylabel('Frequency')
%legend("s4")

