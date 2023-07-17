% DSP_FINAL_PROJECT
% （1）采样量化
[y, Fs] = audioread('FINAL_voice_original.wav');
Ts = 1/Fs;
% 用audioinfo获得采样点数
info = audioinfo('FINAL_voice_original.wav');
Total_bits = info.TotalSamples;
% 回放声音
sound(y, Fs);
pause(5)

% (2) 语音信号的频谱分析
figure(1)
subplot(2,1,1);plot(y); %时域波形
xlabel('t/s');ylabel('y');title('原语音时域波形')
Yk = fft(y);
% 把频谱移至(-Fs/2,Fs/2)的范围，便于观察
Yk_shift = fftshift(Yk);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,1,2);plot(n,abs(Yk_shift));
xlabel('频率/Hz');ylabel('abs(Yk_shift)');title('原语音fft')

% (3) 加入单频噪声
t = 0:Ts:(Total_bits-1)*Ts;
f_cos_noise = 4000;
cos_amp = 0.08; %振幅
cos_noise = cos_amp*cos(2*pi*f_cos_noise*t);
y1 = y + transpose(cos_noise);
figure(2)
subplot(2,1,1);plot(y1);
xlabel('t/s');ylabel('y');title('有单频噪声的语音时域波形')
Yk1 = fft(y1);
Yk1_shift = fftshift(Yk1);
subplot(2,1,2);plot(n,abs(Yk1_shift));
xlabel('频率/Hz');ylabel('abs(Yk1_shift)');title('有单频噪声的语音fft')
sound(y1, Fs);
audiowrite('FINAL_voice_4kHz_noise.wav', y1, Fs);
pause(5)

% (4) 加入高斯白噪声
SNR = 8;
[y2,Gauss_noise] = noisegen(y,SNR);

% (5) 比较加噪前后语音信号的波形及频谱
figure(3)
% 加噪前
subplot(2,2,1);plot(y);
xlabel('t/s');ylabel('y');title('加噪前时域波形')
Yk = fft(y);
Yk_shift = fftshift(Yk);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,2);plot(n,abs(Yk_shift));
xlabel('频率/Hz');ylabel('abs(Yk_shift)');title('加噪前fft')
% 加噪后
subplot(2,2,3);plot(y2);
xlabel('t/s');ylabel('y2');title('加噪后时域波形,SNR=8')
Yk2 = fft(y2);
Yk2_shift = fftshift(Yk2);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,4);plot(n,abs(Yk2_shift));
xlabel('频率/Hz');ylabel('abs(Yk2_shift)');title('加噪后fft,SNR=8')
audiowrite('FINAL_voice_Guass_noise.wav', y2, Fs);
sound(y2, Fs)