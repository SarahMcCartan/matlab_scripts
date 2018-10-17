f_in='310_csa_pca_12.txt';
PCA_data=load(f_in,'-ascii') ; 

[values, centers] = hist3([PCA_data(:,2),PCA_data(:,1)],[60,60]);
imagesc(centers{:},values)
colorbar
axis equal
axis xy
