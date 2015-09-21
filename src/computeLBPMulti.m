function lbp = computeLBPMulti(im)
img = im2single(rgb2gray(im));
lbp1 = computeLBP(img, 6);
lbp2 = computeLBP(img, 12);
lbp3 = computeLBP(img, 18);
lbp=[lbp1, lbp2, lbp3];