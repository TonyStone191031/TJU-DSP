% Process noise y1. Use IIR & Butterworth & Bilinear
% 指标
OmegaS = 2*pi*3500; OmegaP = 2*pi*2500;
As = 60; Rp = 1;
ws = OmegaS/Fs; wp = OmegaP/Fs;
% Design
OmegaS1 = 2/Ts*tan(ws/2); OmegaP1 = 2/Ts*tan(wp/2);
[N1, OmegaC1] = buttord(OmegaP1, OmegaS1, Rp, As, 's');
[b1, a1] = butter(N1, OmegaC1, 's');
[bz1, az1] = bilinear(b1, a1, Fs);
% 频率响应
[db1, mag1, pha1, grd1, w1] = freqz_m(bz1, az1);
figure(4)
plot(w1/pi, db1); xlabel('\omega/\pi'); ylabel('dB');
title('IIR频率响应')
% 滤波并回放
y1_filter = filter(bz1, az1, y1); sound(y1_filter, Fs);
audiowrite('FINAL_IIR.wav', y1_filter, Fs);
% 滤波前
figure(5)
subplot(2,2,1);plot(y1);xlabel('t/s');ylabel('y1');
title('滤波前时域波形')
Yk1 = fft(y1);
Yk1_shift = fftshift(Yk1);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,2);plot(n,abs(Yk1_shift));
xlabel('频率/Hz');ylabel('abs(Yk1_shift)');title('滤波前fft')
% 滤波后
subplot(2,2,3);plot(y1_filter);
xlabel('t/s');ylabel('y1_filter');title('滤波后时域波形')
Yk1_filter = fft(y1_filter);
Yk1_filter_shift = fftshift(Yk1_filter);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,4);plot(n,abs(Yk1_filter_shift));
xlabel('频率/Hz');ylabel('abs(Yk1_filter_shift)');title('滤波后fft')