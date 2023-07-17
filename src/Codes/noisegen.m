function [Y,NOISE] = noisegen(X,SNR)
% SNR��λ�Ƿֱ�dB.
% X�Ǵ��ź�,SNR��Ҫ��������,Y�Ǵ����ź�,NOISE�ǵ������ź��ϵ�����
% randn�Ǿ�ֵ��=0����׼�����=1����̬�ֲ���������Xͬά�ȵ����������
NOISE=randn(size(X)); % size����X��ά��
% NOISE�ľ�ֵΪ0ʱ����׼����ҵ�ƽ������NOISE��ƽ������
NOISE=NOISE-mean(NOISE); % ʹ��NOISE����Ԫ�صľ�ֵΪ0
signal_power = 1/length(X)*sum(X.*X); % �ź�X�Ĺ���ǿ��
% dB��Ϊ������֮�ȵĵ�λʱ�����ڹ���ǿ��֮�ȵĳ��ö�����10��
noise_variance = signal_power / ( 10^(SNR/10) ); % ���������ΪSNR 
% noise_variance����������ȵ�NOISE�ķ����ƽ������ 
% ��һ��ʹ��NOISE�ı�׼����ҵ���noise_variance��ʹNOISE�������������
NOISE=sqrt(noise_variance)/std(NOISE)*NOISE; % std����NOISEԪ�صı�׼����
Y=X+NOISE;
end