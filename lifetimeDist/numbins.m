f_in = 'dcsa_510_lifetimes_s11.txt';
state = load(f_in, '-ascii');

n = size(state,1); %number of observations
m1 = max(state(:,2)); %max
m2 = min(state(:,2)); %min
r = iqr(state); %interquartile range (IQR)
rr = r(:,2); %pull out relevant column of IQR

h = 2.*rr.*(n.^(-1/3)); %optimal bin width

nbins = (m1-m2)./h; %optimal number of bins

dlmwrite('dcsa510_numbins_s11.txt', nbins , '\t');
