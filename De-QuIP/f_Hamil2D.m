% Sample code of the papers:
% 
% Sayantan Dutta, Adrian Basarab, Bertrand Georgeot, and Denis Kouamé,
% "A Novel Image Denoising Algorithm Using Concepts of Quantum Many-Body Theory,"
% arXiv preprint arXiv(2021).
%
% Sayantan Dutta, Adrian Basarab, Bertrand Georgeot, and Denis Kouamé,
% "Image Denoising Inspired by Quantum Many-Body physics,"
% 2021 IEEE International Conference on Image Processing (ICIP), 2021,
% pp. 1619-1623, doi: 10.1109/ICIP42928.2021.9506794.
%
% Sayantan Dutta, Adrian Basarab, Bertrand Georgeot, and Denis Kouamé,
% "Quantum mechanics-based signal and image representation: Application
% to denoising," IEEE Open Journal of Signal Processing, vol. 2, pp. 190–206, 2021.
% 
% Sayantan Dutta, Adrian Basarab, Bertrand Georgeot, and Denis Kouamé,
% "Despeckling Ultrasound Images Using Quantum Many-Body Physics,"
% 2021 IEEE International Ultrasonics Symposium (IUS), 2021, pp. 1-4,
% doi: 10.1109/IUS52206.2021.9593778.
%
% One should cite all these papers for using the code.
%---------------------------------------------------------------------------------------------------
% MATLAB code prepard by Sayantan Dutta
% E-mail: sayantan.dutta@irit.fr and sayantan.dutta110@gmail.com
% 
% This script shows an example of our image denoising algorithm 
% Denoising by Quantum Interactive Patches (De-QuIP)
%---------------------------------------------------------------------------------------------------


function [psi_cols,E] = f_Hamil2D(image,poids)
%
%the Hamiltonian associates with the signal and the associated eigenvalues
% The function calculates the eigenvectors and eigenvalues of the Hamiltonian of the image.
%A column of psi_cols contains an eigenvector.

%size of image
[M,N] = size(image); % On supposera N = M
dim = N;
N = sqrt(N);
imVect = reshape(image,[1 dim]);

psi_tmp = zeros(dim,dim);
psi_tmp2 = zeros(dim,dim);
E_tmp = zeros(dim,1);
    
% Construction of Hamiltonian matrice H
terme_hsm = ones(1,dim) * poids;
H = diag(imVect,0) + diag(terme_hsm,0)*4 ...
    - diag(terme_hsm(1:dim-1),-1) - diag(terme_hsm(1:dim-1),1) ...
    - diag(terme_hsm(1:dim-N),-N) - diag(terme_hsm(1:dim-N),N);% ...

%effect of the boundary conditions
for bloc = 0:(N-1) % Loop on the lines of the image
    H(1+N*bloc,1+N*bloc) = H(1+N*bloc,1+N*bloc) - poids;
    H(N*(bloc+1),N*(bloc+1)) = H(N*(bloc+1),N*(bloc+1)) - poids;
end

for ligne = 1:N  % Modification of the 1st and last block
    H(ligne,ligne) = H(ligne,ligne) - poids;
    H(dim + 1 - ligne,dim + 1 - ligne) = H(dim + 1 - ligne,dim + 1 - ligne) - poids;
end
    
for inter = 1:(N-1) %Loop the corner of the blocks (which form the lines)
    H(N*inter+1,N*inter) = 0;
    H(N*inter,N*inter+1) = 0;
end

%  Calculation of eigenvalues and eigenvectors
% disp('Calculation of eigenvectors')
% [vectP,valPmat] = eig(H);
 [psi_cols,E] = eig(H);

% disp('Ok for eigenvectors')
% valPmat = diag(valPmat);
% %psi_tmp(:,:) = vectP;
% 
% vpM = max(valPmat);
% 
% for g = 1:dim 
% Each iteration finds the "following" eigenvector
%(sorts the vectors in ascending order of the associated eigenvalues)
    
% [E_min, i_min] = min(valPmat);
% psi_tmp2(:,g) = vectP(:,i_min);
% E(g) = E_min;
% valPmat(i_min) = vpM + 1;
% 
% end
% 
% % psi = reshape(psi_tmp2,N,N,dim);
% psi_cols = psi_tmp2;

end


    