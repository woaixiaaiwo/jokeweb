clc;clf;clear all;
imaqmem(30000000);               %申请内存空间
%ADAPTOR:MATLAB与视频设备之间的接口，主要的目的是传递信息
vid = videoinput('winvideo', 1, 'UYVY_720x576');
h=preview(vid);
start(vid);
mb0=ycbcr2rgb(getsnapshot(vid));
while ishandle(h)     %判断是否有效的图像对象句柄
a=ycbcr2rgb(getsnapshot(vid)) ;     % 捕获图像
flushdata(vid);     %清除数据获取引擎的所有数据、置属性SamplesAvailable为0
mb0=mb0*0.95+a*0.05;
forground=a-mb0;
imshow(uint8(forground));                   %显示图像
drawnow;                     % 实时更新图像
end;
delete(vid);