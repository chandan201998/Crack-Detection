<div align=center>
 
# Deep Learning based Structural Damage Detection

[**Franklin Zhao**](http://franklinzhao.top) (me, email: qingan_zhao@berkeley.edu)

[**Xuefeng Zhao**](http://www.cloudshm.com/intros/zhaoxuefeng_en.pdf) (my undergraduate advisor who supported this project) 

**Peng Zhao** (provided the data-set for this project)

June 2017

<div align=left>

## Project Summary

1. Proposed a damage identification and localization technique for masonry structures using convolutional neural networks (based on AlexNet-8 and GoogLeNet-22 using Caffe).

2. Applied region-based convolutional neural networks (Faster-RCNN) to damage detection for masonry structures.

## Abstract

Manual inspection (i.e., visual inspection and/or with professional equipment) is the most dominant approach to identifying and assessing superficial damage to masonry historic structures at present. However, such method is inefficient, heavily relying on professionals and their experience. To overcome those limits, in this project, two deep learning-based damage detection techniques for masonry historic structures are proposed. One is using a sliding window-based deep learning method to identify and localize 3 damage categories (crack, efflorescence and spall) with the accuracy of 90.9%, the other is using a region proposal-based deep learning method to detect damaged brick units in quasi real-time (0.047 seconds per image). The advantage of deep learning method is that with sufficient training samples, machines are able to learn how to detect the damage automatically via training without using manual feature extraction techniques. Once the model training is complete, it can be used to detect damage directly. The detection requires hardly any professional abilities or experience, and is hardly affected by the environment. Hence, high efficiency and accuracy can be realized.

## Introduction

State-of-the-art structural health monitoring (SHM) techniques have been studied and applied to historic structures on account of their complexity, heterogeneity and long tradition of existence (1,2,3,4). Masonry has always been one of the key materials of historic structures, mainly in the form of walls which carry loads and provide security. The safety of masonry structures is of vital importance in the maintenance of historic architecture (5,6). As structures gradually deteriorate, they are likely to be subjected to various forms of damage, mainly resulting in the reduction of strength, stiffness and integrity. Such damage always reflects on the surface of structures, such as crack, efflorescence, spall, and so forth. Hence, it is of great significance to identify and localize the superficial damage quickly and efficiently. The work can be regarded as guidance for structural repair, maintenance and management afterwards (7).

The most dominant superficial damage detection method in actual practice is in-situ visual inspection supplemented by professional equipment (8,9,10,11). Such method seems easy to operate, but requires extremely high professional inspection and experience. For instance, in terms of crack detection, the operators must be capable of fully understanding the properties of the inspected cracks, and determine whether repairs are needed. Large-scale inspection using this method is a time and labor-intensive process (12), so it can only be implemented via sampling detection and periodic inspection. Although manual visual inspection can achieve reasonable performance in most scenarios, sometimes it is unreliable as serious damage is not detected (13). Hence, such method may not provide necessary guidance for maintenance in historic structures, resulting in a substantial increase in maintenance costs.

One solution to those problems is using sensors-based SHM systems. However, collecting data by various sensors and monitoring every historic structures in real-time require a huge expense. Moreover, SHM systems that integrated and installed into the historic structures also require professionals to operate and the distributed devices are difficult to implement on large-scale structures (14). Therefore, it may not be a cost-effective choice. In recent years, plenty of research on vision-based SHM techniques has been carried out, aiming to replace the conventional manual inspection (15,16,17,18,19,20). Since professionals are able to draw conclusions via only visual inspection, it is possible to use computers to detect the damage automatically based on digital image processing. However, such method requires manual feature extraction. The images of the structures are sensitive to noise such as stains, shadows and non-uniform lighting condition. Hence, the robustness and adaptability of digital image processing is not sufficient.

A number of studies have introduced machine learning techniques to improve the accuracy. Kabir (21) proposed a SHM technique using grey level co-occurrence matrix (GLCM) and neural network classifier to detect alkali-aggregate reaction (AAR) damage. Moon and Kim (22) detected cracks with reasonable accuracy based on image processing and backpropagation (BP) neural networks. O’Byrne et al. (23) proposed an enhanced texture segmentation technique for structural damage detection and classification based on GLCM and support vector machines (SVMs). Plevris and Asteris (24) approximated the failure surface of masonry structures under biaxial stress using neural networks. Wu et al. (25) proposed a crack-defragmentation technique based on dilation transform and thinning transform, and used neural network classifier to identify cracks afterwards. However, these methods based on shallow neural networks and SVMs still use image processing techniques such as edge detection. Hence, the robustness and adaptability are not significantly improved.

Is there any vision-based detection approaches require no image processing technique? The answer is deep learning (26). Compared with fully connected BP neural networks-based shallow learning, convolutional neural networks (CNNs)-based deep learning requires no manual feature extraction. The classifier is trained via automatic machine learning instead. The reason deep learning can be “deep” is that the convolution and pooling techniques in CNNs are able to significantly reduce parameters, making very deep networks possible. CNNs are derived from “receptive field” proposed by Hubel and Wiesel (27) who are inspired by cat’s visual cortex. With the development of BP techniques, LeCun (28) first proposed a CNN for document recognition, which is the famous LeNet. However, CNNs were not more efficient and popular than normal BP neural networks owing to the low-performance hardware and insufficient training data. CNNs owe much of their performance to the realization of big data and parallel computing on graphics processing units (GPUs) (29). In the Large Scale Visual Recognition Challenge 2012 (LSVRC2012) (30), Krizhevsky et al. (31) first used a CNN model and got the champion. The model is called AlexNet which achieved the top-5 test error rate of 15.3% (Top-5 error rate of the best model in LSVRC2011 is 25.8%). From 2012, all champion models of LSVRC are CNNs, such as ZFNet (32) in 2013, GoogLeNet (33) in 2014, and ResNet (34) in 2015. CNN models are going deeper and deeper to improve the performance, achieving very high accuracy, robustness and adaptability in image classification. 

Due to the high performance of deep learning in image classification, it is really promising to apply them to structural damage detection. However, not much research on deep learning-based structural damage detection has been proposed. Ouellette et al. (35) used a genetic algorithm-based CNN to detect cracks with not very high accuracy. Makantasis et al. (36) used a CNN with only two convolution layers and a fully connected layer in tunnel crack inspection. Protopapadakis et al. (37) combined CNNs with 3D modeling techniques and applied them to detect concrete defects. Cha et al. (38) proposed a complete strategy for crack detection using a CNN and a sliding window technique with high accuracy. All these studies above only use CNNs to classify two categories (i.e., intact and crack), and the CNN models are not deep (no deeper than AlexNet). The state-of-the-art region proposal-based deep learning methods have never been used for damage detection either. 

Hence, two contributions are aimed to be made in this project. First, more than one type of damage detection is first realized, and CNN models in this project are going deeper (the deepest CNN in this project is based on GoogLeNet with 22 layers). Second, a region proposal-based deep learning method for damage detection is also first utilized.

## Figures

<div align=center><img width="450" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig1.png>
 
**Fig. 1:** Schematic diagram of image classification for a brick unit

<br /> 
 
<img width="450" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig2.png>

**Fig. 2:** Schematic diagram of CNN-based damage identification and classification for a brick unit
 
<br />
 
<img width="450" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig3.png>

**Fig. 3:** Comparison of fully connected mode and locally connected mode: (a) fully connected mode, and (b) locally connected mode
 
<br /> 
 
<img width="350" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig4a.png>  <img width="350" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig4b.png>  <img width="350" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig4c.png>  <img width="350" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig4d.png>

**Fig. 4:** Training samples of the 4 categories: (a) intact, (b) spall, (c) crack, and (d) efflorescence for CNN

<br /> 

<img width="250" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig5.png>

**Fig. 5:** Training sample for Faster-RCNN

<br /> 

<img width="600" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig6a.png>  <img width="600" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig6b.png>

**Fig. 6:** Results of training using AlexNet-8: (a) train loss, and (b) validation accuracy

<br /> 

<img width="600" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig7a.png>  <img width="600" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig7b.png>

**Fig. 7:** Results of training using GoogLeNet-22: (a) train loss, and (b) validation accuracy

<br /> 

<img width="500" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig8.png>

**Fig. 8:** Sliding window strategy

<br /> 

<img width="400" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig9a.png>  <img width="400" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig9b.png>  <img width="400" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig9c.png>

**Fig. 9:** Test results based on GoogLeNet-22 together with sliding window algorithm

<br /> 

<img height="300" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig10a.png>  <img height="300" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig10b.png>  <img height="300" src=https://github.com/QinganZhao/Deep-Learning-based-Structural-Damage-Detection/blob/master/markdown_figures/fig10c.png>

**Fig. 10:** Test results based on Faster-RCNN

<br /> 

<div align=left>
 
## References

 1. Riveiro, B., Lourenço, P. B., Oliveira, D. V., González‐Jorge, H., & Arias, P. (2016). Automatic morphologic analysis of quasi‐periodic masonry walls from lidar. Computer-Aided Civil and Infrastructure Engineering, 31(4), 305-319.
 2. Boscato, G., Russo, S., Ceravolo, R., & Fragonara, L. Z. (2015). Global Sensitivity-Based Model Updating for Heritage Structures. Computer-Aided Civil and Infrastructure Engineering.
 3. Boscato, G., Cin, A. D., Ientile, S., & Russo, S. (2016). Optimized procedures and strategies for the dynamic monitoring of historical structures. Journal of Civil Structural Health Monitoring, 6(2), 265-289.
 4. Ubertini, F., Comanducci, G., & Cavalagli, N. (2016). Vibration-based structural health monitoring of a historic bell-tower using output-only measurements and multivariate statistical analysis. Structural Health Monitoring, 15(4).
 5. Fang, D. P., Iwasaki, S., Yu, M. H., Shen, Q. P., Miyamoto, Y., & Hikosaka, H. (2001). Ancient chinese timber architecture. i: experimental study. Journal of Structural Engineering, 127(11), 1348-1357.
 6. Zhang, S., & Lu, R. (2012). Ica 3 d – intelligent computer-aided ancient chinese architecture design. Advanced Engineering Informatics, 26(4), 705-715.
 7. Balageas, D. (2006). Introduction - Structural Health Monitoring of Civil Infrastructure Systems. Structural Health Monitoring. ISTE.
 8. Qin, J., & Faber, M. H. (2012). Risk management of large rc structures within spatial information system. Computer‐aided Civil & Infrastructure Engineering, 27(6), 385-405.
 9. Gattulli, V., & Chiaramonte, L. (2010). Condition assessment by visual inspection for a bridge management system. Computer-Aided Civil and Infrastructure Engineering, 20(2), 95-107.
 10. O’Byrne, M., Schoefs, F., Ghosh, B., & Pakrashi, V. (2013). Texture analysis based damage detection of ageing infrastructural elements. Computer‐aided Civil & Infrastructure Engineering, 28(3), 162-177.
 11. Miyamoto, A., & Isoda, S. (2012). Sensitivity analysis of mechanical behaviors for bridge damage assessment. Structural Engineering & Mechanics(41), 539-558.
 12. Elmasry, M. I. S., & Johnson, E. A. (2004). Health monitoring of structures under ambient vibrations using semiactive devices. American Control Conference, 2004. Proceedings of the (Vol.4, pp.3526-3531 vol.4). IEEE.
 13. Dammika, A. J., Kawarai, K., Yamaguchi, H., Matsumoto, Y., & Yoshioka, T. (2014). Analytical damping evaluation complementary to experimental structural health monitoring of bridges. Journal of Bridge Engineering, 20(7), 04014095.
 14. Zhao, X., Zhao, Q., Yu, Y., Chen, Y., Liu, H., & Li, M., et al. (2017). Distributed displacement response investigation technique for bridge structures using smartphones. Journal of Performance of Constructed Facilities, 31(4), 04017029.
 15. Nishikawa, T., Yoshida, J., Sugiyama, T., & Fujino, Y. (2012). Concrete crack detection by multiple sequential image filtering. Computer‐aided Civil & Infrastructure Engineering, 27(1), 29-47.
 16. Yeum, C. M., & Dyke, S. J. (2015). Vision-Based Automated Crack Detection for Bridge Inspection. Computer-Aided Civil and Infrastructure Engineering, 30(10), 759-770.
 17. Ghiassi, B., Xavier, J., Oliveira, D. V., & Lourenço, P. B. (2013). Application of digital image correlation in investigating the bond between frp and masonry. Composite Structures, 106(12), 340-349.
 18. Nejad, M., Motekhases, Z., & Zakeri, H., et al. (2015). An Image Processing Approach to Asphalt Concrete Feature Extraction. Journal of Industrial and Intelligent Information, 3(1).
 19. Mahal, M., Blanksvärd, T., Täljsten, B., & Sas, G. (2015). Using digital image correlation to evaluate fatigue behavior of strengthened reinforced concrete beams. Engineering Structures, 105, 277-288.
 20. Hamrat, M., Boulekbache, B., Chemrouk, M., & Amziane, S. (2016). Flexural cracking behavior of normal strength, high strength and high strength fiber concrete beams, using digital image correlation technique. Construction & Building Materials, 106(4), 678-692.
 21. Kabir, S. (2010). Imaging-based detection of aar induced map-crack damage in concrete structure. Ndt & E International, 43(6), 461-469.
 22. Moon, H. G., & Kim, J. H. (2011). Inteligent crack detecting algorithm on the concrete crack image using neural network. Proceedings of Isarc.
 23. O’Byrne, M., Schoefs, F., Ghosh, B., & Pakrashi, V. (2013). Texture analysis based damage detection of ageing infrastructural elements. Computer‐aided Civil & Infrastructure Engineering, 28(3), 162-177.
 24. Plevris, V., & Asteris, P. G. (2014). Modeling of masonry failure surface under biaxial compressive stress using neural networks. Construction & Building Materials, 55(55), 447-461.
 25. Wu, L., Mokhtari, S., & Nazef, A., et al. (2014). Improvement of crack-detection accuracy using a novel crack defragmentation technique in image-based road assessment. Journal of Computing in Civil Engineering, 30(1): 04014118.
 26. Hinton, E., Osindero, S., & Teh, W. (2006). A fast learning algorithm for deep belief nets. Neural Computation, 18(7):1527-1554.
 27. Hubel, D. H., & Wiesel, T. N. (1962). Receptive fields, binocular interaction and functional architecture in the cat's visual cortex. Journal of Physiology, 160(1), 106.
 28. Lecun, Y., Bottou, L., & Bengio, Y., et al. (1998). Gradient-based learning applied to document recognition. Proceedings of the IEEE, 86(11):2278-2324.
 29. Lindholm, E., Nickolls, J., Oberman, S., & Montrym, J. (2008). Nvidia tesla: a unified graphics and computing architecture. IEEE Micro, 28(2), 39-55.
 30. Stanford Vision Lab. Large Scale Visual Recognition Challenge (ILSVRC). http://www.image-net.org/challenges/LSVRC/
 31. Krizhevsky, A., Sutskever, I., & Hinton, G. E. (2012). ImageNet classification with deep convolutional neural networks. International Conference on Neural Information Processing Systems (Vol.25, pp.1097-1105). Curran Associates Inc.
 32. Zeiler, M. D., & Fergus, R. (2014). Visualizing and Understanding Convolutional Networks. European Conference on Computer Vision (Vol.8689, pp.818-833). Springer, Cham.
 33. Szegedy, C., Liu, W., Jia, Y., Sermanet, P., Reed, S., & Anguelov, D., et al. (2015). Going deeper with convolutions. Computer Vision and Pattern Recognition (pp.1-9). IEEE.
 34. He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep Residual Learning for Image Recognition. Computer Vision and Pattern Recognition (pp.770-778). IEEE.
 35. Oullette, R., Browne, M., & Hirasawa, K. (2004). Genetic algorithm optimization of a convolutional neural network for autonomous crack detection. Evolutionary Computation, 2004. CEC2004. Congress on (Vol.1, pp.516-521 Vol.1). IEEE.
 36. Makantasis, K., Protopapadakis, E., Doulamis, A., Doulamis, N., & Loupos, C. (2015). Deep Convolutional Neural Networks for efficient vision based tunnel inspection. IEEE International Conference on Intelligent Computer Communication and Processing (pp.335-342). IEEE.
 37. Protopapadakis, E., Makantasis, K., & Kopsiaftis, G., et al. (2016). Crack identification via user feedback, convolutional neural networks and laser scanners for tunnel infrastructures. The 11th Joint Conference on Computer Vision, Imaging and Computer Graphics Theory and Applications, 2016: 725-734.
 38. Cha, Y. J., Choi, W., & Büyüköztürk, O. (2017). Deep learning‐based crack damage detection using convolutional neural networks. Computer‐aided Civil & Infrastructure Engineering, 32(5), 361-378.

For more details please see my undergraduate thesis uploaded in the "thesis based on this project (in Chinese)" folder. Unfortunately I do not have a English version for the time being.

### Please cite this project in your publications if it helps your research
