%%
%该程序的思路是减去背景，背景需要训练
clc;clf;clear all;
imaqmem(3000000);               %申请内存空间
%ADAPTOR:MATLAB与视频设备之间的接口，主要的目的是传递信息
vid = videoinput('winvideo', 1, 'UYVY_720x576');
h=preview(vid);
start(vid);
% mb0=imread('forground.jpg');
mb0=double(ycbcr2rgb(getsnapshot(vid))) ;
while ishandle(h)     %判断是否有效的图像对象句柄
a=double(ycbcr2rgb(getsnapshot(vid))) ;     % 捕获图像
flushdata(vid);     %清除数据获取引擎的所有数据、置属性SamplesAvailable为0
% err=abs((double(a)-double(mb0)));
% err0=sum(sum(sum(err)))/double(sum(sum(sum(mb0))));
% if err0<0.05
    mb0=mb0*0.98+a*0.02;
% end
forground=a-mb0;
imshow(uint8(forground));                   %显示图像
drawnow;                     % 实时更新图像
end;
delete(vid);