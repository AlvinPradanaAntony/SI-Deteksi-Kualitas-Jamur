clc; clear; close all; warning off all;

%menetapkan nama folder
nama_folder = 'Data_learning';
%membaca file berekstensi .jpg
nama_file = dir(fullfile(nama_folder,'*.jpg'));
%membaca jumlah file berekstensi .jpg
jumlah_file = numel(nama_file);

%melakukan inisialisasi variabel data learning
data_learning = zeros(jumlah_file,2);

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

    %menyusun variabel data learning
    data_learning(n,1) = Correlation;
    data_learning(n,2) = Energy;
end

%menetapkan target learning
target_learning = cell(jumlah_file, 1);
for n = 1:7
    target_learning{n} = 'baik';
end

for n = 8:14
    target_learning{n} = 'buruk';
end

%melakukan pelearningan menggunakan algoritma SVM
Mdl = fitcsvm(data_learning,target_learning); %mdl, model

%membaca kelas keluaran
kelas_keluaran = predict(Mdl,data_learning);

%menghitung akurasi data learning
jumlah_benar = 0;
for n = 1:jumlah_file
    if isequal(kelas_keluaran{n},target_learning{n})
        jumlah_benar = jumlah_benar+1;
    end
end

akurasi_learning = jumlah_benar/jumlah_file*100

%menyimpan variabel Mdl hasil pelearningan
save Mdl Mdl

    