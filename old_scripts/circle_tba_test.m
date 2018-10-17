clc;clear

%create data set of distances (r) of each pt (x,y) to 
%the centre of each state cluster

f_in='310_csa_pca_12.txt';
PCA_data=load(f_in,'-ascii') ; 

%[values, centers] = hist3([PCA_data(:,2),PCA_data(:,1)],[100,100]);
%imagesc(centers{:},values)
%colorbar
%axis square
%axis xy
plot(PCA_data(:,1), PCA_data(:,2), 'b.')

C1 = [-0.183,0.621];
C2 = [0.396,-0.154];
C3 = [0.682, 0.157];

R = 0.2;

hold on

t = linspace(0,2*pi);
plot(C1(:,1)+ R*cos(t), C1(:,2)+ R*sin(t),'g-')

axis square
axis xy

r1 = hypot(PCA_data(:,1)-C1(:,1), PCA_data(:,2)-C1(:,2));

plot(PCA_data(r1<=R,1),PCA_data(r1<=R,2),'go')

s1 = [PCA_data(r1<=R,1), PCA_data(r1 <=R,2)];

hold on 

plot(C2(:,1)+ R*cos(t), C2(:,2)+ R*sin(t),'r-')
r2 = hypot(PCA_data(:,1)-C2(:,1), PCA_data(:,2)-C2(:,2));

plot(PCA_data(r2<=R,1),PCA_data(r2<=R,2),'ro')

s2 = [PCA_data(r2<=R,1), PCA_data(r2<=R,2)];

axis square
axis xy

hold on 

plot(C3(:,1)+ R*cos(t), C3(:,2)+ R*sin(t),'k-')
r3 = hypot(PCA_data(:,1)-C3(:,1), PCA_data(:,2)-C3(:,2));

plot(PCA_data(r3<=R,1),PCA_data(r3<=R,2),'ko')

axis square
axis xy

s3 = [PCA_data(r3<=R,1), PCA_data(r3<=R,2)];

r_values = [r1, r2 ,r3];
%plot(datatest(:,1),datatest(:,2),'^')