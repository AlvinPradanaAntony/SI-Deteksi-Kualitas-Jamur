clc; clear; close all; warning off all;

%menetapkan nama folder
nama_folder = 'Data_training';
%membaca file berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
%membaca jumlah file berekstensi .jpg
jumlah_file = numel(nama_file);

%melakukan inisialisasi variabel data training
data_training = zeros(jumlah_file,2);

%melakukan pengolahan citra terhadap seluruh file
for n = 1:jumlah_file
    %membaca file citra RGB
    Img = imread(fullfile(nama_folder,nama_file(n).name));
    %figure, imshow(Img)

    %konversi citra RGB menjadi citra Grayscale
    Img_gray = rgb2gray(Img);
    %figure, imshow(Img_gray)

    %melakukan ekstraksi ciri tekstur menggunakan metode GLCM
    pixel_dist = 1;
    %membentuk matriks kookurensi
    GLCM = graycomatrix(Img_gray,'Offset',[0 pixel_dist; -pixel_dist pixel_dist; pixel_dist 0; -pixel_dist -pixel_dist]);
    stats = graycoprops(GLCM,'Correlation','Energy');
   
    Correlation = mean(stats.Correlation);
    Energy = mean(stats.Energy);

    %menyusun variabel data training
    data_training(n,1) = Correlation;
    data_training(n,2) = Energy;
end

%menetapkan target training
target_training = cell(jumlah_file, 1);
for n = 1:7
    target_training{n} = 'baik';
end

for n = 8:14
    target_training{n} = 'buruk';
end

%memanggil variabel mdl hasil pelatihan
load Mdl

%membaca kelas keluaran hasil pengtrainingan
kelas_keluaran = predict(Mdl,data_training);

%menghitung akurasi pengtrainingan
jumlah_benar = 0;
for n = 1:jumlah_file
    if isequal(kelas_keluaran{n},target_training{n})
        jumlah_benar = jumlah_benar+1;
    end
end

akurasi_training = jumlah_benar/jumlah_file*100

    