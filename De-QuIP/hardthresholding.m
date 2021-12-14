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


function coefs = hardthresholding(ima_patch, threshold, del)

%hardthresholding        Hard thresholding the PCA coefficients
%   INPUT:
%     ima_patch    : structure of the noisy patch decompositions.
%     threshold   : threshold used for the hardthresholding
%     sigma	  : standard deviation of the noise
%   OUTPUT:
%     coefs    : sturture of of the image patch after hardthresholding
%
%---------------------------------------------------------------------

    coefs = ima_patch;
%     if size(coefs, 3) > 1
%         isimage = 1;
%         [M,N,P] = size(coefs);
%         MN = M*N;
%         coefs = reshape(coefs, MN, P);
%     else
%         isimage = 0;
%         [MN,P] = size(coefs);
%     end

    coefs = coefs .* (threshold < abs(coefs));

%     if isimage
%         ima_ppca.coefs = reshape(coefs, M, N, P);
%     else
%         ima_ppca.coefs = reshape(coefs, MN, P);
%     end
    
end
