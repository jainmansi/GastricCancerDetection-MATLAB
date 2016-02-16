 function [v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22] = glcmrun(I)

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
     
         off = [0 1; -1 1; -1 0; -1 -1];
     
         glcms = graycomatrix(B, 'NumLevels', 256, 'offset', off);
        
          stats=GLCM_Features1(glcms, 0);
    
    arr(1) = mean(stats.autoc);
    arr(2) = mean(stats.contr);
    arr(3) = mean(stats.corrm);
    arr(4) = mean(stats.corrp);
    arr(5) = mean(stats.cprom);
    arr(6) = mean(stats.cshad);
    arr(7) = mean(stats.dissi);
    arr(8) = mean(stats.energ);
    arr(9) = mean(stats.entro);
    arr(10) = mean(stats.homom);
    arr(11) = mean(stats.homop);
    arr(12) = mean(stats.maxpr);
    arr(13) = mean(stats.sosvh);
    arr(14) = mean(stats.savgh);
    arr(15) = mean(stats.svarh);
    arr(16) = mean(stats.senth);
    arr(17) = mean(stats.dvarh);
    arr(18) = mean(stats.denth);
    arr(19) = mean(stats.inf1h);
    arr(20) = mean(stats.inf2h);
    arr(21) = mean(stats.indnc);
    arr(22) = mean(stats.idmnc);
   xlswrite('v.xls',arr,1,'S100');