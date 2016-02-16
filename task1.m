%A1 = 'C:\Program Files\MATLAB\Picture1.jpg';      %giving path
%A2 = 'C:\Program Files\MATLAB\Picture2.jpg';
%A3 = 'C:\Program Files\MATLAB\Picture3.jpg';
%A4 = 'C:\Program Files\MATLAB\Picture4.jpg';
A5 = 'C:\Program Files\MATLAB\Picture6.jpg';
%A6 = 'C:\Program Files\MATLAB\Picture6.jpg';
%imgarr = {A1, A2, A3, A4, A5, A6};
%n=6;
%for i=1 : n
    %B = imread(imgarr{i}, 'jpg');                %image acquision
    B = imread(A5, 'jpg');
    subplot(3,4,1); imshow(B);  title('original image');                      %displays image

    gray = rgb2gray(B);                          %convert to gray scale
    subplot(3,4,2); imshow(gray);  title('Gray image');                    %displays gray image
    
    D = im2double(B);                            %converts to double
    E = graythresh(D);                           % threshold according to original image
    
    bin = im2bw(D, 0.7);                        %manually giving threshold + BnW conversion
     %subplot(3,4,2); imshow(bin);  title('binary image');                    %displays BnW image
    
    bin = double(bin);
    filt = medfilt2(bin, [10 10]);              %Median Filter with filter value
    subplot(3,4,3); imshow(filt);  title('Noise-free image');                    %Displays fltered image
    
    img = abs(filt);                             %absolute value
    
    img = log(img+1);
    img = double(img);
    nBlack = sum(img(:));
    %display(nBlack);

    se = strel('disk', 4);                      %Create structural element
    erd = imerode(filt, se);                    %Erode image
    erd = double(erd);
    dilate = imdilate(erd, se);                 %Dilate image
    dilate = double(dilate);
    result = dilate;
    subplot(3,4,4); imshow(result);  title('Extracted Region of Ulcers');                  %Excess noise removed from image
    
    canny = edge(result, 'canny', [], 5);       %Canny edge detection
    figure(2); imshow(canny);  title('Malignant Region');
    
%end

[Nx,Ny] = size(result);
BlackPixelCount = zeros(Nx,1);
WhitePixelCount = zeros(Nx,1);

for it = 1:Nx
    numberOfWhitePixels = sum(result(:));
    numberOfBlackPixels = numel(result) - numberOfWhitePixels;
end

total = numel(result);

ratioPixel = numberOfWhitePixels / total;

disp(ratioPixel);

nWhite = nnz(result);

disp(nWhite);
