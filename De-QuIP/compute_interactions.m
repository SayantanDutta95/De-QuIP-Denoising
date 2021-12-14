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


function [interactions] = compute_interactions(denoi_patch, x, k, p)
% A function to compute the interactions between the patches
% Use different type of interactions

% find the size
[MN, P] = size(x);

% Compute the interactions between the choosed patch and other patches
interactions = zeros(MN,P); % creat space for the interaction term
    

% Find the position of the choosed patch

% Store the column position
if mod(k, sqrt(MN)) == 0
   column_posi = sqrt(MN);
else    
    column_posi = mod(k, sqrt(MN));
end

% Store the row position
if mod(k, sqrt(MN)) == 0
    row_posi = fix(k/sqrt(MN));    
else    
    row_posi = fix(k/sqrt(MN)) + 1;    
end
    
% Find the position of the other patchs
patches_column_posi = zeros(1,MN); % creat space to store the column positions
patches_row_posi = zeros(1,MN); % creat space to store the row positions
for n = 1:MN
    % Store the column position
    if mod(n, sqrt(MN)) == 0
       patches_column_posi(1,n) = sqrt(MN);
    else
       patches_column_posi(1,n) = mod(n, sqrt(MN));
    end
    % Store the row position
    if mod(n,sqrt(MN)) == 0
       patches_row_posi(1,n) = fix(n/sqrt(MN));
    else
       patches_row_posi(1,n) = fix(n/sqrt(MN)) + 1;
    end
end

% Compute distance between patches
distance2 = zeros(1,MN); % creat space for the distances
for n = 1:MN
    distance2(n) = (column_posi - patches_column_posi(n))^2 ...
            + (row_posi - patches_row_posi(n))^2;
end
    

% inverse square law
    for n = 1:MN
        if n ~= k  % if n == k then interaction is zero
           interactions(n,:) =  p * abs(denoi_patch - x(n,:))/distance2(n);
        end
    end
    
end
