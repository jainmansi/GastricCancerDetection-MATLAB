MI = imread('C:\Program Files\MATLAB\Picture1.jpg');
MI=histeq(MI,255);
%figure;imshow(MI,[]); title('original image Abnormal 2');
MI = double(MI);
MI = medfilt2(MI,[5 5]);
%figure;imshow(MI,[]); title('after median filter Abnormal 2');
h = fspecial('gaussian',[15 15],10);
MI=double(MI);
MI=(MI-filter2(h,MI)*.9);
%figure;imshow(MI,[]); title('after Gaussian filter Abnormal 2');
level=graythresh(MI);
MI=im2bw(MI,level);
%figure;imshow(MI,[]); title('after threshold Abnormal 2');
MI=double(MI);
MI=fftshift(fft2(MI));
MI=abs(MI); %CL added 11/24
MI=log(MI+1);
%************************************************
%********new smoothing information
testing=round_smooth(MI);
[temp1,temp2]=size(testing)
temparray=zeros(temp1-1,1);
temphalfmax=max(testing)/2;
for i=1:(temp1-1)
temparray(i)=testing(temp1-i);
if i>1
if (temparray(i-1)<temphalfmax) & (temparray(i)>temphalfmax)
fullwidthhalfmax=(temp1-i)*2
end
end
end
%testing=[temparray;testing];
figure; plot((testing)); title('array after smoothing');
%************************************************
h=fspecial('average',[5 5]);
%figure;imshow(MI,[]); title('after FFT Abnormal 2');
%figure;imshow(MI,[]); title('after log Abnormal 2');
MI=filter2(h,MI);
MI=filter2(h,MI);
%figure;imshow(MI,[]); title('after average filter Abnormal 2');

%Code – circumferential averaging.

function [outarray]=round_smooth(inpict)
[m,n]=size(inpict);
outarray=zeros(round(sqrt((m/2)*(m/2)+(n/2)*(n/2))),1);
fornormal=zeros(round(sqrt((m/2)*(m/2)+(n/2)*(n/2))),1);
for p=1:m
for k=1:n
index=round(sqrt((p-m/2)*(p-m/2)+(k-n/2)*(k-n/2-1)))+1;
outarray(index)=inpict(p,k)+outarray(index);
fornormal(index)=fornormal(index)+1;
end
end
outarray=outarray./fornormal;