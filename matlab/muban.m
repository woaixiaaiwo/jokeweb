clc;clf;clear all;
imaqmem(30000000);               %�����ڴ�ռ�
%ADAPTOR:MATLAB����Ƶ�豸֮��Ľӿڣ���Ҫ��Ŀ���Ǵ�����Ϣ
vid = videoinput('winvideo', 1, 'UYVY_720x576');
h=preview(vid);
start(vid);
mb0=ycbcr2rgb(getsnapshot(vid));
while ishandle(h)     %�ж��Ƿ���Ч��ͼ�������
a=ycbcr2rgb(getsnapshot(vid)) ;     % ����ͼ��
flushdata(vid);     %������ݻ�ȡ������������ݡ�������SamplesAvailableΪ0
mb0=mb0*0.95+a*0.05;
forground=a-mb0;
imshow(uint8(forground));                   %��ʾͼ��
drawnow;                     % ʵʱ����ͼ��
end;
delete(vid);