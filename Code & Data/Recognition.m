imageDatabase = imageSet('CancerDatabase', 'recursive');
figure;
montage(imageDatabase(1).ImageLocation);
title('Images of Polyps');
