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


close all
clear all
clc

% load data 
ima = double(imread(file_name));  ima = ima(:,:,1); % put file name here

% Generate random noise
SNR = 22;
randn('seed', 2);
[m, n] = size(ima);
noise = randn(size(ima));  % noise
pima = sum(sum(ima .^2)) / (m * n);
noise_tmp = sum(sum(noise .^2)) / (m * n);
noise = noise / sqrt(noise_tmp) * sqrt(pima * 10^(- SNR / 10));
pnoise = sum(sum(noise .^2)) / (m * n);

SNR_i = 10 * log10(pima / pnoise);
fprintf('\nSNR_in = %2.2f dB \n', SNR_i);
ima_nse = ima + noise;  %noisy image

% Choose parameters
WP=7;              % patch size
hW=10;              % half window size
factor_thr= 2.5;    % thresholding factor
% choose del = 10 for SNR 22
% choose del = 20 for SNR 16
% choose del = 50 for SNR 8
% choose del = 100 for SNR 2
del = 10;           
threshold = factor_thr * del;
delta = hW;         %< 2*hW+WP; % half window size for the searching zone
p = .1;             % proportionality constant
d = 41;             % reduced dimention
fact =2.5;          % Planck constant factor

% Start denoising process
local_time=tic;
% Divide image into small patches
ima_patchs = spatial_patchization(ima_nse, WP); % Divide noisy image

% Denoising process
ima_patchs_fil = DeQuIP_denoising(ima_patchs, hW, delta, p, d, fact, threshold, del);

% Reproject the small patches to construct the denoised image
ima_fil_DeQuIP = reprojection_UWA(ima_patchs_fil);
local_time=toc(local_time);

% Print results
PSNR = psnr(ima, ima_fil_DeQuIP);
SSIM = ssim_index(ima_fil_DeQuIP, ima, [0.01 0.03], fspecial('gaussian', 3, 1.5), max(ima(:)));
fprintf('BM3D:\n PSNR: %.6f dB - SSIM: %.6f\n', PSNR, SSIM);

% Display output
figure('Position',[100 100  500 500])
plotimage(ima_fil_DeQuIP);
