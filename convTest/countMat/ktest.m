close all
clear variables

Ktest = [ -0.5 0.1 0.4 ; 0.3 -0.7 0.4 ; 0.2 0.7 -0.9];

[W, D ,V] = eig(Ktest);