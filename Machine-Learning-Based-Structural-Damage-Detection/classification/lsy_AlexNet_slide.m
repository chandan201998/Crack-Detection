% �ڵ��Ŵ�ͼƬɨ������еı䲽������
% ��ɨ������������ڵڶ����ͼƬȥ�����������ڵڶ���������ͼƬ�����

clear;close all; clc;
files = dir('*.jpg');
l = length(files);

for i=1:l
    filename=files(i).name;
    im=imread(filename);
    [out_image] = lsy_slide( im, 128, 128, 64, 64);
    imwrite(out_image,['D:\caffe-master\matlab\demo\final\',num2str(i),'.jpg']);
    
end