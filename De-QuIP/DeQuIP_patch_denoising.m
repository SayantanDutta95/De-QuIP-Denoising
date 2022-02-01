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


function [denoi_patchs] = DeQuIP_patch_denoising(x, cst_patchs, p, d, fact, threshold, del)

% find the size of the image patchs
[MN, P] = size(x);

denoi_patchs = zeros(MN,P); % creat space for the denoised patchs


for k = 1:MN
    
    wanted_patch(1,:) = x(k,:); % choose one patch that we want to denoise
        
    % Compute the interactions between the choosed patch and other patches
    [interactions] = compute_interactions(wanted_patch, x, k, p);
    
    % Total interaction on the choosed patch
    total_inte = sum(interactions,1);
    
    % Effective potential of the choosed patch
    effe_poten = wanted_patch + total_inte;
    
%     % Compute smooth potential
%     effe_poten_resh = reshape(wanted_patch, sqrt(P), sqrt(P));
%     sigmaGau = 50; % Gaussian Variance of the blur before calculation
%     % creat Gaussian
%     [x1,x2] = meshgrid((-sqrt(P)/2):(sqrt(P)/2 - 1));
%     z = 1 / (sqrt(2 * pi * sigmaGau))^2 * exp(-(x1 .^2 + x2 .^2) / (2 * sigmaGau)); 
%     % Convolution product
%     gaussF = fft2(ifftshift(z));
%     effe_potenF = fft2(effe_poten_resh);
%     effe_poten_smooth = real(ifft2(gaussF .* effe_potenF)); % smooth image
%     effe_poten_smooth = reshape(effe_poten_smooth, 1, P);

    % Effective potential of the choosed patch after Convolution
%     effe_poten = effe_poten_smooth + total_inte;
    
    
    
    % Solve Schodinger equation
    [psi_cols,E] = f_Hamil2D(effe_poten, fact * (max(effe_poten)));

    latent = (diag(E)); % eigenvalues of the Hamiltonian matrix
    coeff = (psi_cols); % eigenvectors of the Hamiltonian matrix
    
    % compute projection coefficients
    score = wanted_patch * coeff;
        
    % coefficients after thresholding
    score_thre =  hardthresholding(score, threshold, del);
    
    % reduced basis
    reduced_coefs = zeros(1,P); % creat space for the reduced coefficients 
    reduced_coefs(1:d) = score_thre(1:d);
    
    % Compute the denoised patch
    denoi_patchs(k,:) = reduced_coefs * coeff' + ones(1,P) * cst_patchs(k,1);

end

end
