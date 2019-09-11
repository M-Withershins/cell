close all;clear all; clc;
%% 载入图像
local_path = './testimg/sizhuang/wbc'; %根路径
local_result_path = './result/sizhuang/wbc';

cellimg = fullfile(local_path,'wbc1.tif') 
labeldata = fullfile(local_path,'wbc1.json') 
resultimg = fullfile(local_result_path,'wbc1.png')
% cellimg = fullfile(local_path,'wbc2.tif') 
% labeldata = fullfile(local_path,'wbc2.json') 
% resultimg = fullfile(local_result_path,'wbc2.png')
cell_img = imread(cellimg);

cell_img_gray = rgb2gray(cell_img); %RGB图像变灰度图像
% J = watershed(I,8); %分水岭算法

%% otsu分割图像
cell_img_gra = im2double(cell_img_gray); %OTSU分割法
T = graythresh(cell_img_gray);
cell_label_fenge = imbinarize(cell_img_gray,T);
[x,y] = size(cell_label_fenge);

for i = 1:x %将0/1翻转
    for k = 1:y
        if(cell_label_fenge(i,k)==0)
            cell_label_fenge(i,k)=1;
        else
            cell_label_fenge(i,k)=0;
        end
    end
end

%% 膨胀腐蚀图形学运算
se = strel('square',12); %膨胀运算
bw2 = imdilate(cell_label_fenge,se);

se = strel('disk',11); %腐蚀运算
bw3 = imerode(bw2,se);
%% 保存并显示分割图片

imwrite(bw3, resultimg)
%% 执行getpoints.py文件，获取真实label数组
true_label = python('getpoints.py',labeldata);
temp = strcat('true_label=',true_label); 
eval(temp); %将label='[a,2,3]'转化为label=[1,2,3] %字符串=>数组%

% [true_label1,true_label2] = python('getpoints.py',labeldata);
% temp = strcat('true_label=',true_label); 
% eval(temp); %将label='[a,2,3]'转化为label=[1,2,3] %字符串=>数组%



%% 将真实标记点加到图片上面
cell = imread(cellimg);
true_cell = insertShape(cell,'Polygon',true_label,'LineWidth',1);

%% 显示图片
figure;
subplot(221),imshow(cell_img);
subplot(222),imshow(bw3);
subplot(223),imshow(true_cell);
subplot(224),imshow(cell_img);

%% 将label映射到原图上  
hold on;
[cell_img,L] = bwboundaries(bw3,'noholes');
for i = 1:length(cell_img)
    boundary = cell_img{i};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1)
end
%%



%points = python('getpoints.py','./testimg/jiejing/white/whitejie.json');
%转换分割json数据

