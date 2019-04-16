%originalImage = rescale(double(rgb2gray(imread('Shakespeare_3.png'))));
load('cfg.mat');
originalImage = cfg;
disp(size(cfg));
filterSize = 15;
filterSigma = 10000;

gaussFilter = create_gaussian(filterSize, filterSigma);
Mf = apply_filter(gaussFilter, originalImage);
disp(size(Mf));
Mf = zero_padding(Mf, floor(filterSize / 2));
disp(size(Mf));
imshow(Mf);