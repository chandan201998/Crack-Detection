   
        clear;clc    
      
    im = imread('../../matlab/demo/3.jpg');%��ȡͼƬ 
    figure;imshow(im);%��ʾͼƬ 
  %  [scores, maxlabel] = classification_demo(im,1)
    [scores, maxlabel] = lsy_caffe_classification(im,1); 
    %index = importdata('synset_words.txt');  
   %  name = index(maxlabel);  
      
   
    figure;imshow(im);  
    switch maxlabel
        case 1
            str=strcat('��������������,   �÷֣�',num2str(max(scores)));  
            title(str);  
        case 2
            str=strcat('��������������,   �÷֣�',num2str(max(scores)));  
            title(str);  
    end
    