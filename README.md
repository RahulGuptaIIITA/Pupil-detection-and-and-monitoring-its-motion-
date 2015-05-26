# Pupil-detection-and-monitoring-its-motion-
A module in Open CV which detects pupil and tracks its motion

It takes video as input and detect pupil in each frame using 'Viola Jones' algorith for object detection.


Steps Involved :-
1) For Face detection I used standard algo called Viola–Jones. 

2) After detecting face, I used Facial Symmetry to detect eyes. Although we can use Viola-Jones again for ‘eyes detection’ but it would take time so we better make use of symmetry here for eyes.

3) After Eyes Detection, I did some preprocessing like converting RGB to GreyScale.
 
4) For Pupil Detection, I used Cumulative Distribution Function (CDF) Analysis.
 (http://arxiv.org/ftp/arxiv/papers/1202/1202.6517.pdf) 

5) After Detecting Pupil, I again did some Probing to remove unwanted pixels from the image. For this I perform Erosion and Dilation of image, grouped together all the connected pixels and label them.

6) After completing all the morphological operations, it will give image containing Pupil.


