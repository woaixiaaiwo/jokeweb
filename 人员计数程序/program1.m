%%
%�ó����˼·�Ǽ�ȥ������������Ҫѵ��
clc;clf;clear all;
imaqmem(3000000);               %�����ڴ�ռ�
%ADAPTOR:MATLAB����Ƶ�豸֮��Ľӿڣ���Ҫ��Ŀ���Ǵ�����Ϣ
vid = videoinput('winvideo', 1, 'UYVY_720x576');
h=preview(vid);
start(vid);
% mb0=imread('forground.jpg');
mb0=double(ycbcr2rgb(getsnapshot(vid))) ;
while ishandle(h)     %�ж��Ƿ���Ч��ͼ�������
a=double(ycbcr2rgb(getsnapshot(vid))) ;     % ����ͼ��
flushdata(vid);     %������ݻ�ȡ������������ݡ�������SamplesAvailableΪ0
% err=abs((double(a)-double(mb0)));
% err0=sum(sum(sum(err)))/double(sum(sum(sum(mb0))));
% if err0<0.05
    mb0=mb0*0.98+a*0.02;
% end
forground=a-mb0;
imshow(uint8(forground));                   %��ʾͼ��
drawnow;                     % ʵʱ����ͼ��
end;
delete(vid);