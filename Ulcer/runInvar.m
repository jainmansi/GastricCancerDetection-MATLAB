 I=imread('ulcer1.jpg');
    grayI=rgb2gray(I);
    stats = feature_vec(I);
    disp(stats);