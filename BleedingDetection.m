clc;
close all;
 
% Read standard MATLAB demo image.
rgbImage = imread('blood14.jpg');
 
% Display the original image.
%subplot(3, 4, 1);
figure(1), imshow(rgbImage);
title('Original RGB Image');
 
% Maximize figure.
set(gcf, 'Position', get(0, 'ScreenSize'));
 
% Split the original image into color bands.
redBand = rgbImage(:,:, 1);
greenBand = rgbImage(:,:, 2);
blueBand = rgbImage(:,:, 3);
 
% Display them.
subplot(3, 4, 2);
imshow(redBand);
title('Red band');
subplot(3, 4, 3);
imshow(greenBand);
title('Green band');
subplot(3, 4, 4);
imshow(blueBand);
title('Blue Band');
 
% Threshold each color band.
redthreshold = 68;
greenThreshold = 70;
blueThreshold = 72;
redMask = (redBand > redthreshold);
greenMask = (greenBand < greenThreshold);
blueMask = (blueBand < blueThreshold);
 
% Display them.
subplot(3, 4, 6);
imshow(redMask, []);
title('Red Mask');
subplot(3, 4, 7);
imshow(greenMask, []);
title('Green Mask');
subplot(3, 4, 8);
imshow(blueMask, []);
title('Blue Mask');
 
% Combine the masks to find where all 3 are "true."
redObjectsMask = uint8(redMask & greenMask & blueMask);
subplot(3, 4, 9);
imshow(redObjectsMask, []);
title('Red Objects Mask');
maskedrgbImage = uint8(zeros(size(redObjectsMask))); % Initialize
maskedrgbImage(:,:,1) = rgbImage(:,:,1) .* redObjectsMask;
maskedrgbImage(:,:,2) = rgbImage(:,:,2) .* redObjectsMask;
maskedrgbImage(:,:,3) = rgbImage(:,:,3) .* redObjectsMask;
%subplot(3, 4, 10);
figure(2),imshow(maskedrgbImage);
title('Detected Red Spot');

[Nx,Ny] = size(redObjectsMask);
BlackPixelCount = zeros(Nx,1);
WhitePixelCount = zeros(Nx,1);

for it = 1:Nx
    numberOfWhitePixels = sum(redObjectsMask(:));
    numberOfBlackPixels = numel(redObjectsMask) - numberOfWhitePixels;
end

total = numel(redObjectsMask);

numberOfRedPixels = numberOfWhitePixels;

Percentage = (numberOfRedPixels / total)*100;

disp(Percentage);

nWhite = nnz(redObjectsMask);

disp(nWhite);
