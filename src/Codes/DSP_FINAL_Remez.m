% Process noise y1. Use IIR & Butterworth & Bilinear
% ָ��
OmegaS = 2*pi*3500; OmegaP = 2*pi*2500;
As = 60; Rp = 1;
ws = OmegaS/Fs; wp = OmegaP/Fs;
% Design
deltaw4_1 = (10^(Rp/20)-1)/(10^(Rp/20)+1);
deltaw4_2 = (1+deltaw4_1)*(10^(-As/20));
f4 = [wp/pi, ws/pi]; a4 = [1, 0];
dev4 = [deltaw4_1, deltaw4_2];
[M4, f4_0, a4_0, weights4] = firpmord(f4, a4, dev4);
h4 = firpm(M4, f4_0, a4_0, weights4);
% Ƶ����Ӧ
[db4, mag4, pha4, grd4, w4] = freqz_m(h4, 1);
figure(10)
plot(w4/pi, db4); xlabel('\omega/\pi'); ylabel('dB');
title('Ƶ�ʳ������ĵ�ͨ�˲�����Ƶ����Ӧ');
% �˲����ط�
y4_filter = fftfilt(h4, y1); sound(y4_filter, Fs);
audiowrite('FINAL_Remez.wav', y4_filter, Fs);
% �˲�ǰ
figure(11)
subplot(2,2,1);plot(y1);xlabel('t/s');ylabel('y1');
title('�˲�ǰʱ����')
Yk1 = fft(y1);
Yk1_shift = fftshift(Yk1);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,2);plot(n,abs(Yk1_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk1_shift)');title('�˲�ǰfft')
% �˲���
subplot(2,2,3);plot(y4_filter);
xlabel('t/s');ylabel('y4_filter');title('�˲���ʱ����')
Yk4_filter = fft(y4_filter);
Yk4_filter_shift = fftshift(Yk4_filter);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,4);plot(n,abs(Yk4_filter_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk4_filter_shift)');title('�˲���fft')