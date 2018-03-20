function [scores, maxlabel] = lsy_caffe_classification(im, use_gpu)
% [scores, maxlabel] = classification_demo(im, use_gpu)
%
% Image classification demo using BVLC CaffeNet.
%
% IMPORTANT: before you run this demo, you should download BVLC CaffeNet
% from Model Zoo (http://caffe.berkeleyvision.org/model_zoo.html)
%
% ****************************************************************************
% For detailed documentation and usage on Caffe's Matlab interface, please
% refer to Caffe Interface Tutorial at
% http://caffe.berkeleyvision.org/tutorial/interfaces.html#matlab
% ****************************************************************************
%
% input
%   im       color image as uint8 HxWx3
%   use_gpu  1 to use the GPU, 0 to use the CPU
%
% output
%   scores   1000-dimensional ILSVRC score vector
%   maxlabel the label of the highest score
%
% You may need to do the following before you start matlab:
%  $ export LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64:/usr/local/cuda-5.5/lib64
%  $ export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6
% Or the equivalent based on where things are installed on your system
%
% Usage:
%  im = imread('../../examples/images/cat.jpg');
%  scores = classification_demo(im, 1);
%  [score, class] = max(scores);
% Five things to be aware of:
%   caffe uses row-major order
%   matlab uses column-major order
%   caffe uses BGR color channel order
%   matlab uses RGB color channel order
%   images need to have the data mean subtracted

% Data coming in from matlab needs to be in the order
%   [width, height, channels, images]
% where width is the fastest dimension.
% Here is the rough matlab for putting image data into the correct
% format in W x H x C with BGR channels:
%   % permute channels from RGB to BGR
%   im_data = im(:, :, [3, 2, 1]);
%   % flip width and height to make width the fastest dimension
%   im_data = permute(im_data, [2, 1, 3]);
%   % convert from uint8 to single
%   im_data = single(im_data);
%   % reshape to a fixed size (e.g., 227x227).
%   im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');
%   % subtract mean_data (already in W x H x C with BGR channels)
%   im_data = im_data - mean_data;

% If you have multiple images, cat them with cat(4, ...)

% Add caffe/matlab to you Matlab search PATH to use matcaffe
%�˴�Ϊ���·����ȷ�����ҵ�caffe-master\matlab\+caffe
if exist('../+caffe', 'dir')
  addpath('..');
else
  error('Please run this demo from caffe/matlab/demo');
end

% Set caffe mode
% ����CPU or GPU
if exist('use_gpu', 'var') && use_gpu
  caffe.set_mode_gpu();
  gpu_id = 0;  % we will use the first gpu in this demo
  caffe.set_device(gpu_id);
else
  caffe.set_mode_cpu();
end

% Initialize the network using BVLC CaffeNet for image classification
% Weights (parameter) file needs to be downloaded from Model Zoo.
model_dir = '../../projects_lsy/20170424/';  % ģ�������ļ���·��
net_model = [model_dir 'deploy.prototxt'];   % ģ�������ļ���·��
net_weights = [model_dir '20170424_iter_30000.caffemodel'];  % ģ�͵�·��
phase = 'test'; % run with phase test (so that dropout isn't applied)  % ָ������״̬Ϊtest����ֹʹ��dropout
if ~exist(net_weights, 'file')  % ���ģ���Ƿ���ڣ��������򱨴�����
  error('ģ�Ͳ����ڣ�');
end

% Initialize a network
net = caffe.Net(net_model, net_weights, phase);  % ��ʼ������

%if nargin < 1   %����classification_demo����������������С��1�����������������Ĭ��ʹ�� caffe/examples/images/cat.jpg ����ͼƬ
  % For demo purposes we will use the cat image
 % fprintf('using caffe-master/matlab/demo/1.jpg as input image\n');
 % im = imread('../../matlab/demo/1.jpg');
%end

% prepare oversampled input
% input_data is Height x Width x Channel x Num
%���ص����ˣ�������caffe��������� BGR��˳�򣬶�matlab��RGB��˳�������Ҫ������ͼƬ���б任
%  ������һ��prepare_image������RGBת��BGR�����Ҷ�����ͼƬ������resize������crop�����Լ�����ֵ
%   �ܵ�������ȥ����  prepare_image����
% tic;
input_data = {prepare_image(im)};
% toc;

% do forward pass to get scores
% scores are now Channels x Num, where Channels == 1000
% tic;
% The net forward function. It takes in a cell array of N-D arrays
% (where N == 4 here) containing data of input blob(s) and outputs a cell
% array containing data from output blob(s)
scores = net.forward(input_data);   %�����������뵽���磬����ǰ�򴫲����ó�������scores��һ��ϸ��Ԫ��
% toc;

scores = scores{1};   % scores �� 1000*10 �ľ��� 10�Ƕ�Ӧ��10��cropͼƬ
scores = mean(scores, 2);  % take average scores over 10 crops   %����10��crop������ƽ�� 

[~, maxlabel] = max(scores);   % ���ҳ�������һ�� 

% call caffe.reset_all() to reset caffe
caffe.reset_all(); % ���� caffe

% ------------------------------------------------------------------------
function crops_data = prepare_image(im)
% ------------------------------------------------------------------------
% caffe/matlab/+caffe/imagenet/ilsvrc_2012_mean.mat contains mean_data that
% is already in W x H x C with BGR channels
% d = load('../+caffe/imagenet/ilsvrc_2012_mean.mat');
% mean_data = d.mean_data;
mean_data = caffe.io.read_mean('train_mean.binaryproto');
IMAGE_DIM = 227;
CROPPED_DIM = 227;

% Convert an image returned by Matlab's imread to im_data in caffe's data
% format: W x H x C with BGR channels
im_data = im(:, :, [3, 2, 1]);  % permute channels from RGB to BGR
im_data = permute(im_data, [2, 1, 3]);  % flip width and height
im_data = single(im_data);  % convert from uint8 to single
im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');  % resize im_data
im_data = im_data - mean_data;  % subtract mean_data (already in W x H x C, BGR)

% oversample (4 corners, center, and their x-axis flips)
crops_data = zeros(CROPPED_DIM, CROPPED_DIM, 3, 10, 'single');
indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
n = 1;
for i = indices
  for j = indices
    crops_data(:, :, :, n) = im_data(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :);
    crops_data(:, :, :, n+5) = crops_data(end:-1:1, :, :, n);
    n = n + 1;
  end
end
center = floor(indices(2) / 2) + 1;
crops_data(:,:,:,5) = ...
  im_data(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:);
crops_data(:,:,:,10) = crops_data(end:-1:1, :, :, 5);
