clear all;
close all;
clc;
%   Read in the image 
load('Q2Prob4','blurred')
blurred8 = double(uint8(255*blurred))/255;
figure
image(blurred8);
title('8-bit Quantized Input Image')
%----------------------------------
% Subtract the quantized image from the "true" image
error = blurred-blurred8;
noise_spectrum = fftshift((abs(fft2(error))));
figure
mesh(noise_spectrum(:,:,1))
view([1 0 0])
title('Quantization Error Noise Spectrum')
%-----------------------------------
% Determine the size of the image supplied:
pad = 24;
imsize =  size(blurred8);
xsize = imsize(1) + pad;
ysize = imsize(2) + pad;
% Take fft of image
fftblur8 = fft2(blurred8,xsize,ysize);
%---------------------------------
% Design the inverse filter
%  Use a gaussian kernel from the image processing toolbox
hsize=25;
sigma = 3;
h = fspecial('gaussian', hsize, sigma);
ffth = fft2(h,xsize,ysize);
% Create the inverse filter - this is just the simple form:
fftinvh = 1./ffth;
figure
mesh(fftshift(abs(fftinvh)))
title('Inverse Filter Magnitude')
%----------------------------------
% Filter the image
fftdeblur = zeros(xsize,ysize,3);
for i=1:3
    fftdeblur(:,:,i) = fftinvh.*fftblur8(:,:,i);
end
deblurred = abs(ifft2(fftdeblur));
%  Normalize the pixel intensity for the whole image
%  to set all values in the range 0 -- 1
maxpix = max(max(max(max(deblurred))),1);
deblurred = deblurred/maxpix;
% Show the image
figure
image(deblurred(1:512,1:512,:))
title('Deblurred image')


