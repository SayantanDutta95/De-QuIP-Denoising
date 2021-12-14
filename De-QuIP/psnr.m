function res = psnr(hat, star, L)

    if nargin < 3
        L = 255;
    end

    res = 10 * log10(L^2 / mean2((hat - star).^2));

end
