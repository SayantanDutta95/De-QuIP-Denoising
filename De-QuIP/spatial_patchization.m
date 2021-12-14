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


function [ima_patchs, ima_normalization] = spatial_patchization(im_ini,WP)
%spatial_patchization computes the collection of patches extracted from an image  

% im_ini = input image
% WP = Patch size

% image size
[m,n] = size(im_ini);
ima_patchs=zeros(m-WP+1,n-WP+1,WP^2);
ima_normalization=zeros(m,n);

% creat image patchs
for i=1:(m-WP+1)
    for j=1:(n-WP+1)
        xrange = mod((i:i+WP-1)-1,m)+1;
        yrange = mod((j:j+WP-1)-1,n)+1;
        B = im_ini(xrange, yrange);
        ima_patchs(i,j,:) = B(:);
        ima_normalization(xrange, yrange) = ...
            ima_normalization(xrange, yrange) + ones(WP,WP);
    end
end

end
