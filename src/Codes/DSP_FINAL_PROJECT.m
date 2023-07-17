% DSP_FINAL_PROJECT
% ��1����������
[y, Fs] = audioread('FINAL_voice_original.wav');
Ts = 1/Fs;
% ��audioinfo��ò�������
info = audioinfo('FINAL_voice_original.wav');
Total_bits = info.TotalSamples;
% �ط�����
sound(y, Fs);
pause(5)

% (2) �����źŵ�Ƶ�׷���
figure(1)
subplot(2,1,1);plot(y); %ʱ����
xlabel('t/s');ylabel('y');title('ԭ����ʱ����')
Yk = fft(y);
% ��Ƶ������(-Fs/2,Fs/2)�ķ�Χ�����ڹ۲�
Yk_shift = fftshift(Yk);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,1,2);plot(n,abs(Yk_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk_shift)');title('ԭ����fft')

% (3) ���뵥Ƶ����
t = 0:Ts:(Total_bits-1)*Ts;
f_cos_noise = 4000;
cos_amp = 0.08; %���
cos_noise = cos_amp*cos(2*pi*f_cos_noise*t);
y1 = y + transpose(cos_noise);
figure(2)
subplot(2,1,1);plot(y1);
xlabel('t/s');ylabel('y');title('�е�Ƶ����������ʱ����')
Yk1 = fft(y1);
Yk1_shift = fftshift(Yk1);
subplot(2,1,2);plot(n,abs(Yk1_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk1_shift)');title('�е�Ƶ����������fft')
sound(y1, Fs);
audiowrite('FINAL_voice_4kHz_noise.wav', y1, Fs);
pause(5)

% (4) �����˹������
SNR = 8;
[y2,Gauss_noise] = noisegen(y,SNR);

% (5) �Ƚϼ���ǰ�������źŵĲ��μ�Ƶ��
figure(3)
% ����ǰ
subplot(2,2,1);plot(y);
xlabel('t/s');ylabel('y');title('����ǰʱ����')
Yk = fft(y);
Yk_shift = fftshift(Yk);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,2);plot(n,abs(Yk_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk_shift)');title('����ǰfft')
% �����
subplot(2,2,3);plot(y2);
xlabel('t/s');ylabel('y2');title('�����ʱ����,SNR=8')
Yk2 = fft(y2);
Yk2_shift = fftshift(Yk2);
n = linspace(-Fs/2,Fs/2,Total_bits);
subplot(2,2,4);plot(n,abs(Yk2_shift));
xlabel('Ƶ��/Hz');ylabel('abs(Yk2_shift)');title('�����fft,SNR=8')
audiowrite('FINAL_voice_Guass_noise.wav', y2, Fs);
sound(y2, Fs)