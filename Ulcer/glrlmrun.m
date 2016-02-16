I=imread('g6.jpg');
I=rgb2gray(I);
[GL,S]=grayrlmatrix(I);

stats=grayrlprops(GL);