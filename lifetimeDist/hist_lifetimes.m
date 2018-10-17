close all

f1='csa_450_lifetimes_s1.txt';
f2='csa_450_lifetimes_s2.txt';
f3='csa_450_lifetimes_s3.txt';
f4='csa_450_lifetimes_s4.txt';

data1 =load(f1,'-ascii') ; 
data2 =load(f2,'-ascii') ; 
data3 =load(f3,'-ascii') ; 
data4 =load(f4,'-ascii') ; 

bins = 30;

%figure()
%h = histfit(data1(:,2), bins,'exponential' );

%counts = frequency value, centres = lifetime value

[counts, centres] = hist(data1(:,2), bins);
[counts2, centres2] = hist(data2(:,2), bins);
[counts3, centres3] = hist(data3(:,2), bins);
[counts4, centres4] = hist(data4(:,2), bins);

x1 = 0.5*centres; %convert to ns
x2 = 0.5*centres2;
x3 = 0.5*centres3;
x4 = 0.5*centres4;

figure()
hist(data1(:,2), bins)

%
figure()
semilogy(x1,(counts), 'LineWidth',3)
xlabel('T (ns)')
ylabel('P(T)')
legend("s1")

%figure()
%semilogy(x2,(counts2), 'LineWidth',3)
%xlabel('T (ns)')
%ylabel('P(T)')
%legend("s2")

%figure()
%semilogy(x3,(counts3), 'LineWidth',3)
%xlabel('T (ns)')
%ylabel('P(T)')
%legend("s3")

figure()

yt = counts;
yt(yt>0) = log10(1+yt(yt>0));
yt(yt<0) = -log10(1-yt(yt<0));

%ax = axes;
plot(x1,yt,'b-o');
%set(ax, 'XTick', [-2 -1 0 1 2], ...
%    'XTickLabel', {'-100', '-10', '0', '10', '100'});
xlabel('T (ns)')
ylabel('P(T)')
legend("s1")

figure()

yt2 = counts2;
yt2(yt2>0) = log10(1+yt2(yt2>0));
yt2(yt2<0) = -log10(1-yt2(yt2<0));


%ax = axes;
plot(x2,yt2, 'r-s');
xlabel('T (ns)')
ylabel('P(T)')
legend("s2")

figure()

yt3 = counts3;
yt3(yt3>0) = log10(1+yt3(yt3>0));
yt3(yt3<0) = -log10(1-yt3(yt3<0));
%ax = axes;
plot(x3,yt3,'g-d');
xlabel('T (ns)')
ylabel('P(T)')
legend("s3")

figure()

yt4 = counts4;
yt4(yt4>0) = log10(1+yt4(yt4>0));
yt4(yt4<0) = -log10(1-yt4(yt4<0));
plot(x4,yt4,'m-*');
xlabel('T (ns)')
ylabel('P(T)')
legend("s4")
