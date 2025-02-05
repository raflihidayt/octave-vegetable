clc;
clear;
close all;
pkg load image

% Citra asli
pict = imread('wkobjek.jpg');
figure, imshow(pict), title('Citra Asli');

% Citra HSV
hsv_image = double(rgb2hsv(pict));
figure, imshow(hsv_image), title('Citra HSV');

% Konversi citra ke grayscale
gray_image = rgb2gray(pict);

% Gunakan metode Otsu untuk mendapatkan nilai ambang
threshold_value = graythresh(gray_image);

% Lakukan segmentasi dengan menggunakan nilai ambang Otsu
binary_image = im2bw(gray_image, threshold_value);

% Invert citra biner agar objek menjadi full putih
binary_image_inverted = 1 - binary_image;

% Tampilkan hasil segmentasi
figure, imshow(binary_image_inverted), title('Hasil Segmentasi dengan Metode Otsu');

% Ekstraksi fitur menggunakan bwconncomp
bw_conn_comp = bwconncomp(binary_image_inverted);
num_objects = bw_conn_comp.NumObjects;

% Ambang minimal luas untuk objek
min_area_threshold = 500; % Sesuaikan sesuai kebutuhan

% Loop untuk menampilkan dan memisahkan objek
for i = 1:num_objects
    % Ekstraksi indeks piksel untuk setiap objek
    obj_pixels = bw_conn_comp.PixelIdxList{i};

    % Hitung luas objek
    obj_area = length(obj_pixels);

    % Tampilkan objek hanya jika luasnya di atas ambang tertentu
    if obj_area > min_area_threshold
        % Buat citra yang hanya berisi objek tersebut
        obj_binary = zeros(size(binary_image_inverted));
        obj_binary(obj_pixels) = 1;

        % Tampilkan citra objek
        figure, imshow(obj_binary), title(['Objek ke-', num2str(i), ' - Luas: ', num2str(obj_area)]);
    end
end

% Menampilkan citra asli
figure, imshow(pict), title('Citra Asli');

% Tunggu pengguna menekan tombol sebelum menutup semua jendela
pause;
close all;

