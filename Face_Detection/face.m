%Yogesh Pawar
A = imread('10.jpg');
FaceDetector = vision.CascadeObjectDetector();
BBox =step(FaceDetector,A);
B=insertObjectAnnotation(A, 'rectangle', BBOX ,'Face');
imshow(B), title('Detected Faces');
n=size(BBOX,1);
str_n=num2str(n);
str=strcat('Number of detected faces are',str_n);
disp(str);