% Process noise y1. Use IIR & Butterworth & Bilinear
% ָ��
OmegaS = 2*pi*3500; OmegaP = 2*pi*2500;
As = 60; Rp = 1;
ws = OmegaS/Fs; wp = OmegaP/Fs;
% Design
deltaw2 = ws - wp;
N2 = ceil(11*pi/deltaw2); M2 = N2 - 1;
n = 0:M2;
wc2 = (ws+wp)/2; wn2 = wc2/pi;
h2 = fir1(M2, wn2, blackman(N2));
% Ƶ����Ӧ
[db2, mag2, pha2, grd2, w2] = freqz_m(h2, 1);
figure(6)
plot(w2/pi, db2); xlabel('\omega/\pi'); ylabel('dB');
title('���������ĵ�ͨ�˲�����Ƶ����Ӧ');
% �˲����ط�
y2_filter = fftfilt(h2, y1); sound(y2_filter, Fs);
audiowrite('FINAL_fir1_BLACKMAN.wav', y2_filter, Fs);
% �˲�ǰ
figure(7)
subplot(2,2,1);plot(y1);xlabel('t/s');ylabel('y1');
title('�˲�ǰʱ����')
Yk1 = fft(y1);
Yk1_shift = fftshift(Yk1);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,2);plot(n,abs(Yk1_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk1_shift)');title('�˲�ǰfft')
% �˲���
subplot(2,2,3);plot(y2_filter);
xlabel('t/s');ylabel('y2_filter');title('�˲���ʱ����')
Yk2_filter = fft(y2_filter);
Yk2_filter_shift = fftshift(Yk2_filter);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,4);plot(n,abs(Yk2_filter_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk2_filter_shift)');title('�˲���fft')