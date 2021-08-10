%% gaussian blur
clear;
Img=rgb2gray(imread('building.jfif'));              %% for colured imgs
% Img=imread('3.png');                              %% for grayscale imgs

% % % Img=imread('collage BW 1.jpg');               %% for coloured
% % % r=Img(:,:,1);                                 %% analysis of coloured imgs
% % % g=Img(:,:,2);                               %% have to change some
% % % b=Img(:,:,3);                               %% more code though for it


mean_g=0.04;
var_g=.003;

figure(1);
subplot(3,2,1);
imshow(Img);
title('original');

A=imnoise(Img,'gaussian',mean_g,var_g);

figure(1);
subplot(3,2,2);
imshow(A);
title('noised image');

I=double(A);
I1=I;
%generating the gaussian kernel

%standard deviation
sigma=1.76; 
%size of the window
sz=4;
[x1,y1]=meshgrid(-sz:sz,-sz:sz);
M = size(x1,1)-1;
N = size(y1,1)-1;

power= -(x1.^2+y1.^2)/(2*sigma*sigma);
kernel= exp(power)/(2*pi*sigma*sigma);

%Initialize
output1=zeros(size(I1)); 
I1=padarray(I1,[sz sz]);



%Convolution
for i = 1:size(I1,1)-M
    for j =1:size(I1,2)-N
        temp = I1(i:i+M,j:j+M).*kernel;
        output1(i,j)=sum(temp(:));
    end
end

output1=uint8(output1);

figure(1);
subplot(3,2,3);
imshow(output1);
title('gaussian blur');

% whiten
I2=I;

[x,y]=size(I2);
mean=sum(sum(I2))/(x*y);
var=sum(sum((I2-mean).^2))/(x*y);

I2=(I2-sum(sum(I2))/(x*y))./sqrt(sum(sum((I2-sum(sum(I2))/(x*y)).^2))/(x*y));
figure(1);
subplot(3,2,4);
imshow(I2);
title('whitened image');

% [x,y]=size(r);
% Ir2=(r-sum(sum(r))/(x*y))./sqrt(sum(sum((r-sum(sum(r))/(x*y)).^2))/(x*y));
% Ig2=(g-sum(sum(g))/(x*y))./sqrt(sum(sum((g-sum(sum(g))/(x*y)).^2))/(x*y));
% Ib2=(b-sum(sum(b))/(x*y))./sqrt(sum(sum((b-sum(sum(b))/(x*y)).^2))/(x*y));
% I2=zeros(size(Img));
% I2(:,:,1)=Ir2;
% I2(:,:,2)=Ig2;
% I2(:,:,3)=Ib2;
% figure(122);
% imshow(I2);
%% histogram equalization
arr=zeros(1,256);
for i=1:M+1
    for j=1:N+1
        arr(Img(i,j)+1)=arr(Img(i,j)+1)+1;
    end
end
for i=2:256
    arr(i)=arr(i)+arr(i-1);
end
arr=arr./x/y;
K=nnz(Img);

I3=K*arr(Img+1);

figure(1);
subplot(3,2,5);
imshow(I3);
title('Histogram equalized');

% edge detection
edg1=edge(I2,'sobel');
figure(1);
subplot(3,2,6);
imshow(edg1);
title('edge detection');

% edg1=edge(Img(:,:,1),'sobel');
% edg2=edge(Img(:,:,2),'sobel');
% edg3=edge(Img(:,:,3),'sobel');
% 
% edg=zeros(size(Img));
% edg(:,:,1)=edg1;
% edg(:,:,2)=edg2;
% edg(:,:,3)=edg3;
% figure(9);imshow(edg);
% 
