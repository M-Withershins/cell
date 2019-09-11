close all;clear all;clc;

local_path = './result/sizhuang/wbc/wbc1/'; %医生标注图根路径
local_result_path = './result/sizhuang/wbc'; %分割预测图根路径

cellimg = fullfile(local_path,'label.png') %医生标注图
resultimg = fullfile(local_result_path,'wbc1.png') %分割效果图像

I_true = imread(cellimg); %cell真
I_false = imread(resultimg); %cell预测

[x,y] = size(I_true);
count_true = 0;

for i = 1:x 
    for k = 1:y
        if(I_true(i,k)==1)
            count_true = count_true+1;
        end
    end
end % 统计医生标注图中细胞区域的像素数

count_false = 0;
for i = 1:x 
    for k = 1:y
        if(I_false(i,k)==1)
            count_false = count_false+1;
        end
    end
end % 统计预测分割图像中细胞的区域像素数

count_bing = 0;
for i = 1:x 
    for k = 1:y
        if(I_true(i,k)==I_false(i,k))
            if(I_true(i,k)==1)
                count_bing = count_bing+1;
            end
        end
    end
end % 统计两个图像中不同的区域像素数

evaluation = 2*(count_bing/(count_true+count_false));

