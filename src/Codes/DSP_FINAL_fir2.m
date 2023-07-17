% Process noise y1. Use IIR & Butterworth & Bilinear
% 指标
OmegaS = 2*pi*3500; OmegaP = 2*pi*2500;
As = 60; Rp = 1;
ws = OmegaS/Fs; wp = OmegaP/Fs;
% Design
m3 = 2;
deltaw3 = ws - wp;
N3 = ceil((m3 + 1)*2*pi/deltaw3)+10; M3 = N3 - 1;
F3 = [0, wp/pi, wp/pi+2/N3, wp/pi+4/N3, 1];
A3 = [1, 1, 0.45, 0, 0];
h3 = fir2(M3, F3, A3, boxcar(N3));
% 频率响应
[db3, mag3, pha3, grd3, w3] = freqz_m(h3, 1);
figure(8)
plot(w3/pi, db3); xlabel('\omega/\pi'); ylabel('dB');
title('频率抽样法的低通滤波器的频率响应');
% 滤波并回放
y3_filter = fftfilt(h3, y1); sound(y3_filter, Fs);
audiowrite('FINAL_fir2.wav', y3_filter, Fs);
% 滤波前
figure(9)
subplot(2,2,1);plot(y1);xlabel('t/s');ylabel('y1');
title('滤波前时域波形')
Yk1 = fft(y1);
Yk1_shift = fftshift(Yk1);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,2);plot(n,abs(Yk1_shift));
xlabel('频率/Hz');ylabel('abs(Yk1_shift)');title('滤波前fft')
% 滤波后
subplot(2,2,3);plot(y3_filter);
xlabel('t/s');ylabel('y3_filter');title('滤波后时域波形')
Yk3_filter = fft(y3_filter);
Yk3_filter_shift = fftshift(Yk3_filter);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,4);plot(n,abs(Yk3_filter_shift));
xlabel('频率/Hz');ylabel('abs(Yk3_filter_shift)');title('滤波后fft')