# Pupil Detection And Monitoring Its Motion To Control Application.
This was an independent Project aimed to work on 'Assistive Technology' to help the physically challenged fit in the general populace' 

The project is developed in MATLAB. The module will detects pupil and tracks its motion to take the decision. It continously record video, extract alternate frames, process them, and detect pupil using 'Viola Jones' algorithm for 'Object Detection'. 

Project mainly has two component.
a) Detecting Pupil
b) Monitoring its motion


For Pupil Detection, steps involved are as follows:-

1) For face detection, standard algorithm called Viola–Jones was used. 
2) After detecting face, the position of eyes was calculated using facial symmetry and ratios. 
3) After eyes detection, preprocessing was done to convert RGB to GreyScale.
4) For Pupil Detection, used Cumulative Distribution Function (CDF) Analysis which gave me around 93% accuracy on the dataset.(http://arxiv.org/ftp/arxiv/papers/1202/1202.6517.pdf) 
5) After detecting pupil, some probing was done to remove unwanted pixels from the image. For this purpose, I performed 'Erosion' and 'Dilation' of the image, grouped together all the connected pixels and labeled them.
6) After completing all the morphological operations, the end image contains 'Pupil'.


For Monitoring Its Motion, steps involved are as follows:-

1) Used the first frame of the vido as the frame of reference (assuming the person is looking straight, and eyes are in middle), also validated it against the check that position of both the pupil would be almost equidistant from the center of nose.
2) Now, processed each frame, calculated the postion of pupil and distance it has away from the center of nose. If left pupil traversed more, then person is looking in right direction If right pupil has traversed more then in right direction. If the position doesn't change, he is looking straight and if fails to find pupil then eyes are closed. Considering this pattern, rules were made to control a application.

Overall, I was able to achieve the accuracy of 82% on the self made dataset ( created by taking all the batchmates ) 


