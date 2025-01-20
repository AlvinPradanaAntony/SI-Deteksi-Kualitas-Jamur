clc; clear; close all; warning off all;

%memanggil menu "browse file"


%jika ada nama file yang dipilih maka akan mengeksekusi perintah dibawah
%ini[nama_file, nama_folder] = uigetfile('*.jpg');
if ~isequal(nama_file,0)
    %membaca file citra RGB
    Img = imread(fullfile(nama_folder,nama_file));
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
    data_learning(1,1) = Correlation;
    data_learning(1,2) = Energy;

    %memanggil variabel mdl hasil pelatihan
    load Mdl

    %membaca kelas keluaran hasil penglearningan
    kelas_keluaran = predict(Mdl,data_learning);

    %menampilkan citra asli dan kelas keluaran hasil penglearningan
    figure, imshow(Img)
     title({['Nama File: ',nama_file],['Kelas Keluaran : ',kelas_keluaran{1}]})
else 
    %jika tidak ada nama file yg dipilih maka akan kembali
    return
end