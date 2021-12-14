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


function ima = reprojection_UWA(ima_patchs,xg,yg)

    % find size of image patchs
    [M, N, P] = size(ima_patchs);
    if nargin <= 2
        xg = zeros(M,N);
        yg = zeros(M,N);
    end
    
    p = sqrt(P); % row and column size of each patch
    
    ima = zeros(M+p-1, N+p-1); % creat space for the denoised image
    norm = zeros(M+p-1, N+p-1); % creat space for the normalization
    
    for i = 1:M
        for j = 1:N
            
          % choose a range
          xrange = mod(round((i-1)+(1:p)+xg(i,j))-1,M+p-1)+1;
          yrange = mod(round((j-1)+(1:p)+yg(i,j))-1,N+p-1)+1;
            
          % take the set of patchs
          ima(xrange, yrange) = ima(xrange, yrange) + reshape(ima_patchs(i,j,:), p, p);
          
          % Count the number of repetition of patchs
          norm(xrange, yrange) = norm(xrange, yrange) + 1;
          
        end
    end
    
    % final reconstructed image after normalizing
    ima = ima ./ norm;
    
    clear norm;
    
end
