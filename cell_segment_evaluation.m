close all;clear all;clc;

local_path = './result/sizhuang/wbc/wbc1/'; %ҽ����עͼ��·��
local_result_path = './result/sizhuang/wbc'; %�ָ�Ԥ��ͼ��·��

cellimg = fullfile(local_path,'label.png') %ҽ����עͼ
resultimg = fullfile(local_result_path,'wbc1.png') %�ָ�Ч��ͼ��

I_true = imread(cellimg); %cell��
I_false = imread(resultimg); %cellԤ��

[x,y] = size(I_true);
count_true = 0;

for i = 1:x 
    for k = 1:y
        if(I_true(i,k)==1)
            count_true = count_true+1;
        end
    end
end % ͳ��ҽ����עͼ��ϸ�������������

count_false = 0;
for i = 1:x 
    for k = 1:y
        if(I_false(i,k)==1)
            count_false = count_false+1;
        end
    end
end % ͳ��Ԥ��ָ�ͼ����ϸ��������������

count_bing = 0;
for i = 1:x 
    for k = 1:y
        if(I_true(i,k)==I_false(i,k))
            if(I_true(i,k)==1)
                count_bing = count_bing+1;
            end
        end
    end
end % ͳ������ͼ���в�ͬ������������

evaluation = 2*(count_bing/(count_true+count_false));

