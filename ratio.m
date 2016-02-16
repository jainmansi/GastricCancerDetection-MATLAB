I = rgb2gray(imread('C:\Program Files\MATLAB\ed.png'));

%bw = im2bw(I,graythresh(I));

%figure;imshow(bw);

[Nx,Ny] = size(I);
BlackPixelCount = zeros(Nx,1);
WhitePixelCount = zeros(Nx,1);

for it = 1:Nx
    numberOfWhitePixels = sum(I(:));
    numberOfBlackPixels = numberOfWhitePixels - numel(I);
end

ratioPixel = numberOfBlackPixels / numberOfWhitePixels;

disp(ratioPixel);

nWhite = nnz(I);

disp(nWhite);
