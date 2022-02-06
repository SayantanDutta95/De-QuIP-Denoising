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


function [ima_patchs_fil] = DeQuIP_denoising(ima_patchs, ...
                             hW, delta, p, d, fact, threshold, del)
    
    % creat space for the denoised image patchs
    ima_patchs_fil = zeros( size(ima_patchs ));  
    
    % creat space to count the number of measurements
    ima_patchs_fil_norm = zeros( [size(ima_patchs,1) size(ima_patchs,2)] );
    
    % find the size of the image patchs
    [M,N,P] = size(ima_patchs);
    
    % divide the image patchs into small windows 
    irange = [(1+hW):delta:(M-hW) M-hW];
    jrange = [(1+hW):delta:(N-hW) N-hW];
    
    
    k = 0; % use as a count of the loop
    for i = irange
        for j = jrange
            
            k = k + 1;
           % fprintf(sprintf('Step = %.0f, out of %.0f.\n',k,length(irange)*length(jrange)));

            % Choose a range
            xrange = mod(i + (-hW:hW) - 1, M) + 1;
            yrange = mod(j + (-hW:hW) - 1, N) + 1;
            
            % Choose a set of noisy patchs
            subima_patchs = ima_patchs(xrange, yrange, :); 
            
            % find size of the set of patchs
            [a,b,c] = size(subima_patchs);
            
            % reshape the set of patchs
            subima_patchs = reshape(subima_patchs, a*b, c);
            
            % calculate mean of the set of patchs with respect to coulmns
            cst_patchs = mean(subima_patchs,2); % for noisy image
            
            % denoising process
            denoised_patchs = DeQuIP_patch_denoising(subima_patchs - cst_patchs ...
                      * ones(1, c), cst_patchs, p, d, fact, threshold, del);
            
            % reshape the set of patchs
            subima_denoised = reshape(denoised_patchs, a, b, c);
                        
            % Store the denoised patchs
            ima_patchs_fil(xrange, yrange,:) = ...
                ima_patchs_fil(xrange, yrange,:) + subima_denoised;
            
            % Count the number of measurements
            ima_patchs_fil_norm(xrange, yrange) = ...
                ima_patchs_fil_norm (xrange, yrange) + 1;
        end
    end
    
    % normalize the image patchs
    for k = 1:P
        ima_patchs_fil(:,:,k) = ima_patchs_fil(:,:,k)./ima_patchs_fil_norm;
    end
    
end
