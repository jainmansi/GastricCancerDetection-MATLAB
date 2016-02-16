I = imread('C:\Program Files\MATLAB\Ulcer\ulcer8.jpg');

 gray = rgb2gray(I);                          %convert to gray scale
    figure(1), imshow(gray);                    %displays gray image
    
    D = im2double(I);                            %converts to double
    E = graythresh(D);                           % threshold according to original image
    
    %bin = im2bw(D, 0.6);                        %manually giving threshold + BnW conversion
    
    %figure(3), imshow(bin);                     %displays BnW image
    
    %bin = double(bin);
    filt = medfilt2(gray);              %Median Filter with filter value
    figure(4), imshow(filt);                    %Displays fltered image
    
    %Sharpening image using second order derivative(Laplacian)
    
     I1=filt;
     I=zeros(size(filt));
     I2=zeros(size(filt));
     
      %Filter Masks
      F1=[0 1 0;1 -4 1; 0 1 0];
      F2=[1 1 1;1 -8 1; 1 1 1];

      %Padarray with zeros
      img=padarray(filt,[1,1]);
      img=double(img);

      %Implementation of the equation in Fig.D
      for i=1:size(img,1)-2
            for j=1:size(img,2)-2
       
                I(i,j)=sum(sum(F1.*img(i:i+2,j:j+2)));
       
            end
      end

    I=uint8(I);
    %figure(5),imshow(I);title('Filtered Image');
    
     %Sharpenend Image
     B=I1-I;
     figure(6),imshow(B);title('Sharpened Image');
     
     se = strel('disk', 4);                      %Create structural element
    erd = imerode(B, se);                    %Erode image
    erd = double(erd);
    dilate = imdilate(erd, se);                 %Dilate image
    dilate = double(dilate);
    result = dilate;
    %figure(7), imshow(result);                  %Excess noise removed from image
     
     %[rows, columns, numberOfColorBands] = size(B);
     
     %localBinaryPatternImage = zeros(size(B));
    %for row = 2 : rows - 1   
        %for col = 2 : columns - 1    
            %centerPixel = B(row, col);
            %pixel8= B(row-1, col-1) > centerPixel;  
            %pixel7= B(row-1, col) > centerPixel;   
            %pixel6= B(row-1, col+1) > centerPixel;  
            %pixel5= B(row, col+1) > centerPixel;
            %pixel3= B(row+1, col+1) > centerPixel;    
            %pixel2= B(row+1, col) > centerPixel;      
            %pixel1= B(row+1, col-1) > centerPixel;     
            %pixel0= B(row, col-1) > centerPixel;       
		
            %localBinaryPatternImage(row, col) = uint8(pixel8 * 2^7 + pixel7* 2^6 + pixel6 * 2^5 + pixel5 * 2^4 +  pixel3 * 2^3 + pixel2 * 2^2 + pixel1 * 2 + pixel0);
        %end  
    %end 
            %figure(8), imshow(localBinaryPatternImage, []);

    
    %img = abs(img);                             %absolute value
    
    %img = log(img+1);
    %img = double(img);
   
    

%numberOfPixels = numel(localBinaryPatternImage);
%numberOfTruePixels = sum(localBinaryPatternImage(:));
%percentTrue = (numberOfTruePixels/numberOfPixels)*100;

%disp(percentTrue);

%if (percentTrue >= 15)
    %disp('cancer');
%else 
    %disp('normal');
%end

%disp('Number of pixels ='+numberOfPixels);