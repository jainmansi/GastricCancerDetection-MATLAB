I = rgb2gray(imread('C:\Program Files\MATLAB\Picture5.jpg'));

bw = im2bw(I,graythresh(I));

figure;imshow(bw);

[Nx,Ny] = size(bw);
BlackPixelCount = zeros(Nx,1);
WhitePixelCount = zeros(Nx,1);

for it = 1:Nx
   blackPixel = find(bw(it,:) == 0);
   BlackPixelCount(it) = size(blackPixel,1);
   WhitePixelCount(it) = Ny -  BlackPixelCount(it);
end

blackPixelPercent = (BlackPixelCount/Ny)*100;
whitePixelPercent = (WhitePixelCount/Ny)*100;

if (blackPixelPercent > whitePixelPercent)
    disp('Does not have Cancer');
else
    disp('have Cancer');
end

disp(whitePixelPercent);



