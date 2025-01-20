88% Baca gambar dan ubah ke skala abu-abu
I = imread('Data_training\A1_12.4442 cm.jpg');
I = rgb2gray(I);

% Hilangkan noise dengan median filter dan tingkatkan kontras dengan imadjust
I = medfilt2(I);
I = imadjust(I);

% Terapkan thresholding dengan graythresh
level = graythresh(I);
BW = imbinarize(I,level);

% Label setiap regio dengan bwlabel
[L, num] = bwlabel(BW);

% Ekstrak fitur diameter dengan regionprops
stats = regionprops(L, 'EquivDiameter', 'Centroid');

% Nilai resolusi gambar dalam pixel per centimeter
resolution = 4.00;

% Loop through each region and display diameter value
for idx = 1:1
    diameter = stats(idx).EquivDiameter;
    centroid = stats(idx).Centroid;
    diameter_cm = diameter * resolution;
    fprintf('Region %d: Diameter = %.2f cm, Centroid = (%.2f, %.2f)\n', idx, diameter_cm, centroid(1), centroid(2));
end

% Tampilkan gambar hasil segmentasi
figure, imshow(I);
hold on;
for idx = 1:1
    % Tampilkan centroid dari setiap regio
    plot(stats(idx).Centroid(1), stats(idx).Centroid(2), 'r*');
end
hold off;