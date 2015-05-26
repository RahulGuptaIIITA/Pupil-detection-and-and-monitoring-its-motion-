clear all;
clc

%------------READING VIDEO -----------------------------------------------
obj = VideoReader('C:\Users\RAHUL\Documents\MATLAB\Webcam for Tracking eye movement\vid9.mp4','Tag','My reader object');
%------------No of frames in video-------------------
nFrames = obj.NumberOfFrames;
nFrames                                            
%------------No of frames per second-----------------
rate = obj.FrameRate;                               
rate





%-----------PROCESSING THE EVERY 5th FRAME OF VIDEO-----------------------
for t = 1:5:obj.NumberOfFrames - 1;
    t
    %---------Face Detection Using Voila Jones algo-------
    image = read(obj, t);
    FDetect = vision.CascadeObjectDetector;
    BB = step(FDetect,image);
    face = imcrop(image,BB);
    %figure,imshow(face2);
    
    %---------Eyes Detection Using Face Symmetry ---------
    size1 = size(face,1);
    size2 = size(face,2);
    %size(face2)
    j = int64(.35*size1);
    l = int64(.15*size2);
    length = int64(.68*size2);
    height = int64(.15*size1);
    Eyes = imcrop(face,[l,j,length,height]);
    %figure,imshow(Eyes);

    %---------Different Color Space Conversion ----------
    t_eyes = rgb2gray(Eyes);

    
    %---------Calculating Frequency of pixels------------
    m = size(Eyes,1);
    n = size(Eyes,2);
    array1 = zeros(256,1);
    array2 = zeros(256,1);

    for i = 1:m
        for j = 1:n
            value = t_eyes(i,j);
            array1(value+1) = array1(value+1)+ 1;
        end
    end
    
    
    %---------Probability of particular pixel in image --
    array1(1) = array1(1)/(m*n);
    array2(1) = array1(1); 
    for i = 2:256
        array1(i) = array1(i)/(m*n);
        array2(i) = array1(i) + array2(i-1);
    end
    %array1

    
    %----------Pupil Extraction from image---------------
    for i = 1:m
        for j = 1:n
            value = t_eyes(i,j);
            if array2(value+1) < .06
                new(i,j) = 0;
            else
                new(i,j) = 255;
            end
        end
    end
    
    %----------Removing all the components from image having pixels less then 50 using 26 connectivity 
    bw1 = bwareaopen(new,50, 26);
    %figure, imshow(bw);
    
    %----------Probing the Image (erosion and dilation)------
    se = strel('disk',4);
    %bw1 = imopen(bw1,se);
    bw1 = imclose(bw1,se);
    %figure, imshow(bw1);
    
    %----------Taking the complement of image----------------
    cmp = imcomplement(bw1);
    %figure, imshow(cmp);
    
    %----------Filling holes in the binary image-------------
    cmpfill = imfill(cmp,'holes');
    %figure, imshhow(cmpfill);
    
    %----------Probing the image again for better result-----
    se = strel('disk',5);
    %mask = imclose(cmpfill,se);
    mask = imopen(cmpfill,se);
    %figure, imshow(mask);
    
    %---------Returns no of connected object in image---------
    [lb num]=bwlabel(mask);
    ss=regionprops(lb,'all');
    figure; imshow(Eyes);
    hold on;
    for i=1:num
         Aloha=rectangle('Position',[ss(i,1).BoundingBox(1,1) ss(i,1).BoundingBox(1,2) ss(i,1).BoundingBox(1,3) ss(i,1).BoundingBox(1,3)]);
        set(Aloha,'EdgeColor',[.75,0,0]);
        hold on;
    end

end
   