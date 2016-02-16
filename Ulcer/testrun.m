for i = 1: 10
    a = int2str(i);    
    I=imread(strcat('ulcer',a,'.jpg'));
    grayI=rgb2gray(I);
    filt = medfilt2(grayI);              %Median Filter with filter value
    
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
    %Sharpenend Image
     B=I1-I;
     
    stats=chip_histogram_features(B);
    %stat=mean(stats);
    xlswrite('v.xls',stats,1,strcat('M', a));
end