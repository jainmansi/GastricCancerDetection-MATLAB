%imagefiles = dir('*.jpg');
%nfiles = length(image); 

D = dir('*.jpg');
imcell = cell(1,numel(D));
for i = 1:numel(D)
  imcell{i} = imread(D(i).name);
  imcell{i} = im2double(imcell{i});
  imcell{i} = rgb2gray(imcell{i});
  imcell{i} = imresize(imcell{i},[200 200]);
  imcell{i} = medfilt2(imcell{i});              %Median Filter with filter value    
      
     figure(i),imshow(imcell{i});
end

%for i = 1:nfiles
    %currentfilename = imagefiles(i).name;
    %currentimage = imread(currentfilename);
    %images{i} = currentimage;
    %images{i} = im2double(images{i});
    %images{i} = rgb2gray(images{i});
    %images{i} = imresize(images{i},[200 200]);
    %images{i} = reshape(images{i}', 1, size(images{i},1)*size(images{i},2));
%end

trainData = zeros(numel(D), 40000);
a = 1;
for ii=1:2
    trainData{ii} = imcell{a};
    a = a+1;
end

class = [1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1];
SVMStruct = svmtrain (trainData, class);

inputImg = imread('Picture7.jpg');
inputImg = im2double(inputImg);
inputImg = rgb2gray(inputImg);
inputImg = imresize(inputImg, [200 200]);
%inputImg = reshape (inputImg', 1, size(inputImg,1)*size(inputImg,2));
result = svmclassify(SVMStruct, inputImg);

display(result);

