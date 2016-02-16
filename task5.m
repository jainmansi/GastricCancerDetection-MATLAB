polypImage = imread('sample.jpg');
figure;
imshow(polypImage);
title('Image of a Polyp');

patientImage = imread('polyp.jpg');
figure;
imshow(patientImage);
title('Image of a Patient');

polypImage = rgb2gray(polypImage);
patientImage = rgb2gray(patientImage);

polypImage = medfilt2(polypImage);

polypPoints = detectSURFFeatures(polypImage);
patientPoints = detectSURFFeatures(patientImage);

figure;
imshow(polypImage);
title('20 Strongest Feature Points from Polyp Image');
hold on;
plot(selectStrongest(polypPoints, 100));

figure;
imshow(patientImage);
title('30 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(patientPoints, 300));

[polypFeatures, polypPoints] = extractFeatures(polypImage, polypPoints);
[patientFeatures, patientPoints] = extractFeatures(patientImage, patientPoints);

polypPairs = matchFeatures(polypFeatures, patientFeatures);

matchedPolypPoints = polypPoints(polypPairs(:, 1), :);
matchedPatientPoints = patientPoints(polypPairs(:, 2), :);
figure;
showMatchedFeatures(polypImage, patientImage, matchedPolypPoints, matchedPatientPoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

[tform, inlierPolypPoints, inlierPatientPoints] = estimateGeometricTransform(matchedPolypPoints, matchedPatientPoints, 'affine');

figure;
showMatchedFeatures(polypImage, patientImage, inlierPolypPoints, inlierPatientPoints, 'montage');
title('Matched Points (Inliers Only)');

polypPolygon = [1, 1;...                           % top-left
        size(polypImage, 2), 1;...                 % top-right
        size(polypImage, 2), size(polypImage, 1);... % bottom-right
        1, size(polypImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to cl

newpolypPolygon = transformPointsForward(tform, polypPolygon);

figure;
imshow(patientImage);
hold on;
line(newPolypPolygon(:, 1), newPolypPolygon(:, 2), 'Color', 'y');
title('Detected Polyp');