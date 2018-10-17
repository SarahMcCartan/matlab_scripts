clc;clear
xy = rand(100,2);
plot(xy(:,1),xy(:,2),'b.')

hold on

t = linspace(0,2*pi);
plot(.5+.25*cos(t),.5+.25*sin(t),'r-')

axis square

r = hypot(xy(:,1)-.5,xy(:,2)-.5);

plot(xy(r<=.25,1),xy(r<=.25,2),'go')

datatest = [xy(r<=0.25,1), xy(r <=0.25,2)];

plot(datatest(:,1),datatest(:,2),'^')