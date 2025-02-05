clc;
clear;
close all;
pkg load image

%--RGB--
pict = imread('imgsayur.jpg');
figure,imshow(pict);

%--Grey--
I = double(rgb2gray(pict));
figure, imshow(I,[]);

%--Roberts--
robertshor = [0 1; -1 0];
robertsver = [1 0; 0 -1];
Ix = conv2(I, robertshor, 'same');
Iy = conv2(I, robertsver, 'same');
J = sqrt((Ix.^2)+(Iy.^2));

figure,imshow(Ix,[]);
figure,imshow(Iy,[]);
figure,imshow(J,[]);

%--Treshold--
K = uint8(J);
L = im2bw(K, 0.08);

figure, imshow(L,[]);

%--Morfologi--
M = imfill(L, 'holes');
N = bwareaopen(M, 1000);

figure, imshow(N,[]);

%--Bounding Box--
[labeled, numObjects] = bwlabel(N, 8);
stats = regionprops(labeled, 'BoundingBox');
bbox = cat(1, stats.BoundingBox);

%--Step Output--
figure, imshow(pict);
hold on;
for idx = 1 : numObjects
    h = rectangle('Position', bbox(idx,:), 'LineWidth', 2);
    set(h, 'EdgeColor', [.75 0 0]);
    hold on;
end

%--Title--
title(['Terdeteksi ada ', num2str(numObjects),...
      ' sayuran dalam gambar']);
hold off;
