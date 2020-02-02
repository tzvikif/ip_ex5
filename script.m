%%authors: דפנה קופל 209051036 , צבי פישר 037580644
%%1 sobel
close all;
im = readImage('balls1.tif');
%showImage(im);

Sx = [-1 0 1;-2 0 2;-1 0 1];
Sy = [1 2 1;0 0 0 ;-1 -2 -1];

edgesX = conv2(im,Sx);
edgesY = conv2(im,Sy);
edges = (edgesX.^2 + edgesY.^2).^0.5;
threshold = 150;
idx = edges > threshold;
edges = edges.*idx;
showImage(edges);
%% 2  
close all;
im = readImage('coins1.tif');
showImage(im);
sigma = 2;
%mypause;
l = 0.1;
h = 0.33;
[BW,thresholds] = edge(im,'Canny',[l h],sigma);
showImage(255*BW);
%% 3.1 balls1
im = readImage('balls1.tif');
showImage(im);
sigma = 0.8;
%mypause;
l = 0.055;
h = 0.135;
[BW,thresholds] = edge(im,'Canny',[l h],sigma);
showImage(255*BW);
%% 3.2 balls2
close all;
im = readImage('balls2.tif');
showImage(im);
sigma = 1.0;
%mypause;
l = 0.05;
h = 0.2;
[BW,thresholds] = edge(im,'Canny',[l h],sigma);
showImage(255*BW);
%% 4
close all;clc;
im = imread('coins2.tif');
im(:,:,2:4) = [];
%showImage(im);
figure
imshow(im);
pattern = imread('pattern.tif');
pattern(:,:,2:4) = [];
%showImage(pattern);
c = NGC_pm(im,pattern);
%figure, surf(c), shading flat
factor = 0.5;
[ypeak, xpeak] = find(c>factor*max(c(:)));
yoffSet = ypeak-size(pattern,1);
xoffSet = xpeak-size(pattern,2);

drawRect([xoffSet+1, yoffSet+1, size(pattern,2), size(pattern,1)]);
%% 
close all;clc;
im = imread('coins3.tif');
imshow(im);
sigma = 2;
l = 0.3;
h = 0.6;
e = edge(im,'Canny',[l h],sigma);
imshow(e);
radii = 1:1:min(size(im));   
h = circle_hough(e, radii, 'same', 'normalize');
peaks = circle_houghpeaks(h, radii,'Nhoodr',9,'NHOODXY',9, 'npeaks', 12);
imshow(im);
hold on;
for peak = peaks
    [x, y] = circlepoints(peak(3));
    plot(x+peak(1), y+peak(2), 'g-');
    plot(peak(1),peak(2),'*','color','r');
end
hold off


