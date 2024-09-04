clc;
clearvars;
close all;
flag = 0;
flagw = 1;
fold = 'C:\Users\new\Desktop\数据集3\';      
imgDir = dir([fold  '*.png']);
tic; 
for kk = 1:len(imgDir)
    try
        img = imread([fold, num2str(kk), '.bmp']);
    catch
        img = imread([fold,num2str(kk), '.png']);
    end
    if(size(img,3)>1)
        img = rgb2gray(img);
    end
    img_big = img;
    original_size = size(img);
    rows = original_size(1);
    cols = original_size(2);
    % 计算行和列的填充尺寸
    row_flag= 0 ;
    % cols_flag= 0 ;
    % 在行和列上进行填充
    row_mod = mod( size(img, 1),2);
    row_flag(row_mod==1) = 1;
    col_mod = mod( size(img, 2),2);
    col_flag(row_mod==1) = 1;
    odd_rows = 1:2:size(img, 1)-row_flag;
    odd_cols = 1:2:size(img, 2)-odd_rows;
    odd_image = img(odd_rows, odd_cols, :);
    even_rows = 2:2:size(img, 1);
    even_cols = 2:2:size(img, 2);
    even_image = img(even_rows, even_cols, :);
    img = odd_image;
    img1 = even_image;

    img_big1 = dlcmfunc(double(img_big),3) ;
    re1 = dlcmfunc(double(img),1);
    re2 = dlcmfunc(double(img1),3);
    img_big2 = img_big1;
    img_big2(odd_rows, odd_cols, :) =  re1;
    img_big2(even_rows, even_cols, :) = re2;
    re = img_big2;

    bw = bwfunc(re);

    if flag
        figure; imshow(uint8(img)); title('original image');
        figure; imshow(re, []); title('result image');
        figure; imshow(bw) ; title('binary image');
    end
    if flagw
        refold1 = 'F:\小目标\数据集3\result\';

        if exist(refold1,'dir') == 0
            mkdir(refold1);
        end
        imwrite(uint8(img_big), [refold1, num2str(kk), '1.png']);
        imwrite(uint8( mat2gray(re) * 255), [refold1, num2str(kk), '2.png']);
        imwrite(bw, [refold1, num2str(kk), '3.png']);
    end
end
b=toc;
disp([method,'运行时间：', num2str(b), ' s'])

