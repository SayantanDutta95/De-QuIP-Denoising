function plotimage(img)
%plotimages  displays the image img. 

    imagesc(img);
    axis image;
    caxis([0 255])
    colormap(gray(1024));
    axis off;
end
