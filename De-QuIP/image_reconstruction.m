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


function [output] = image_reconstruction(patch_blocks, ima_patchs_fil_norm,...
                                         ima_normalization, WP, hW, delta, block_dim)


                                     
    % creat space to count the number of measurements
%     ima_patchs_fil_norm = zeros( [size(ima_patchs,1) size(ima_patchs,1)] );
    
    %spatial_patchization computes the collection of patches extracted from an image  
    % find the size of the image patch
    [m,n] = size(ima_normalization);
    ima_patchs_fil=zeros(m-WP+1,n-WP+1,WP^2);
    [M,N,P] = size(ima_patchs_fil);
    
    % divide the image patch into small windows 
    irange = [(1+hW):delta:(M-hW) M-hW];
    jrange = [(1+hW):delta:(N-hW) N-hW];
    
    % creat space for the patch blocks
    denoised_patches = zeros(block_dim, P);
%     patch_blocks = zeros(length(irange)*length(jrange), block_dim, P );  
    
    k = 0; % use as a count of the loop
    for i = irange
        for j = jrange
            
            k = k + 1;
            fprintf(sprintf('Step = %.0f, out of %.0f.\n',k,length(irange)*length(jrange)));

            % Choose a range
            xrange = mod(i + (-hW:hW) - 1, M) + 1;
            yrange = mod(j + (-hW:hW) - 1, N) + 1;
            
            % Reduce the number of patches in a block
            xrange = xrange(1:sqrt(block_dim));
            yrange = yrange(1:sqrt(block_dim));
            
            % denoising process
            denoised_patches(:,:) = patch_blocks(k,:,:);
            
            % find size of the patch block the window
            [a,b] = size(denoised_patches);
            
            % reshape the set of patch
            subima_ppca = reshape(denoised_patches, sqrt(a),sqrt(a), b);
                        
            % Store the denoised patch
            ima_patchs_fil(xrange, yrange,:) = ...
                ima_patchs_fil(xrange, yrange,:) + subima_ppca;
            
            % Count the number of measurements
%             ima_patchs_fil_norm(xrange, yrange) = ...
%                 ima_patchs_fil_norm (xrange, yrange) + 1;
        end
    end
    
    % normalize the image patch
    for k = 1:P
        ima_patchs_fil(:,:,k) = ima_patchs_fil(:,:,k)./ima_patchs_fil_norm;
    end

output = reprojection_UWA(ima_patchs_fil);

end
