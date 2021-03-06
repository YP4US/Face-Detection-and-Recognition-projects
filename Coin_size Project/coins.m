%Yogesh Pawar
close all;
A=imread('ccc.jpg');
figure, imshow(A);
title('original Image');
flg=isrgb(A);             %imgenin renk uzay� test ediliyor. ( Testing the color space)

if flg==1
    A=rgb2gray(A);
end

[h,w]=size(A);
figure;imshow(A);

e1 = edge(A, 'sobel',0.07);  % mcanny kenar alg�lama fonksiyonu (Mcanny edge detection)
figure; imshow(e1);     
 
B=im2bw(A,0.3);
figure,imshow(B);

c=imfill(B,'holes');
figure, imshow(c);

e = strel('square',6);
im_close = imclose(c,e);

%regionporps
f = regionprops(im_close,'BoundingBox');
g = round(reshape([f.BoundingBox], 4, []).');       %Bounding boxex

%Drawing red box around each character
%imshow(d2);
for h = 1:numel(f)
    rectangle('Position',g(h,:),'edgecolor','red');
end

%Extract all characters and place them into cell
chars = cell(1,numel(f));
for h = 1 : numel(f)
    chars{h} = c(g(h,2):g(h,2)+g(h,4)-1,g(h,1):g(h,1)+g(h,3)-1);
    ch = chars{h};
    figure; imshow(ch);
   
end
 %{  
%title('Original image');


C=imfill(B,'holes');
figure, imshow(C);
%}
%{
label=bwlabel(c);
max(max(label))
im1=(label==1);
figure, imshow(im1);
figure, imshow(label==15);
figure, imshow(label==18);
figure, imshow(label==26);

for j=1:max(max(label))
    [row,col]=find(label==j);
    len=max(row)-min(row)+2;
    breadth=max(col)-min(col)+2;
    target=uint8(zeros([len breadth]));
    sy=min(col)-1;
    sx=min(row)-1;
    for i=1:size(row,1)
        x=row(i,1)-sx;
        y=col(i,1)-sy;
        target(x,y)=A(row(i,1),col(i,1));
    end
    mytitle=strcat('object number',num2str(j));
    figure,imshow(target);title(mytitle);
end
%}