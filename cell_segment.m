close all;clear all; clc;
%% ����ͼ��
local_path = './testimg/sizhuang/wbc'; %��·��
local_result_path = './result/sizhuang/wbc';

cellimg = fullfile(local_path,'wbc1.tif') 
labeldata = fullfile(local_path,'wbc1.json') 
resultimg = fullfile(local_result_path,'wbc1.png')
% cellimg = fullfile(local_path,'wbc2.tif') 
% labeldata = fullfile(local_path,'wbc2.json') 
% resultimg = fullfile(local_result_path,'wbc2.png')
cell_img = imread(cellimg);

cell_img_gray = rgb2gray(cell_img); %RGBͼ���Ҷ�ͼ��
% J = watershed(I,8); %��ˮ���㷨

%% otsu�ָ�ͼ��
cell_img_gra = im2double(cell_img_gray); %OTSU�ָ
T = graythresh(cell_img_gray);
cell_label_fenge = imbinarize(cell_img_gray,T);
[x,y] = size(cell_label_fenge);

for i = 1:x %��0/1��ת
    for k = 1:y
        if(cell_label_fenge(i,k)==0)
            cell_label_fenge(i,k)=1;
        else
            cell_label_fenge(i,k)=0;
        end
    end
end

%% ���͸�ʴͼ��ѧ����
se = strel('square',12); %��������
bw2 = imdilate(cell_label_fenge,se);

se = strel('disk',11); %��ʴ����
bw3 = imerode(bw2,se);
%% ���沢��ʾ�ָ�ͼƬ

imwrite(bw3, resultimg)
%% ִ��getpoints.py�ļ�����ȡ��ʵlabel����
true_label = python('getpoints.py',labeldata);
temp = strcat('true_label=',true_label); 
eval(temp); %��label='[a,2,3]'ת��Ϊlabel=[1,2,3] %�ַ���=>����%

% [true_label1,true_label2] = python('getpoints.py',labeldata);
% temp = strcat('true_label=',true_label); 
% eval(temp); %��label='[a,2,3]'ת��Ϊlabel=[1,2,3] %�ַ���=>����%



%% ����ʵ��ǵ�ӵ�ͼƬ����
cell = imread(cellimg);
true_cell = insertShape(cell,'Polygon',true_label,'LineWidth',1);

%% ��ʾͼƬ
figure;
subplot(221),imshow(cell_img);
subplot(222),imshow(bw3);
subplot(223),imshow(true_cell);
subplot(224),imshow(cell_img);

%% ��labelӳ�䵽ԭͼ��  
hold on;
[cell_img,L] = bwboundaries(bw3,'noholes');
for i = 1:length(cell_img)
    boundary = cell_img{i};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1)
end
%%



%points = python('getpoints.py','./testimg/jiejing/white/whitejie.json');
%ת���ָ�json����

