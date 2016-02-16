I = imread('polyp1.jpg');
hsv = rgb2hsv(I);
h = hsv(:, :, 1); % Hue image.
s = hsv(:, :, 2); % Saturation image.
v = hsv(:, :, 3); % Value (intensity) image.

imshow(h);

figure(2), imshow(s);
figure(3), imshow(s);

D = im2double(s);                            %converts to double
    E = graythresh(D);                           % threshold according to original image
    
    bin = im2bw(D, 0.8); 
    
    figure(4), imshow(bin);