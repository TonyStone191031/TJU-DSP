function [Y,NOISE] = noisegen(X,SNR)
% SNR单位是分贝dB.
% X是纯信号,SNR是要求的信噪比,Y是带噪信号,NOISE是叠加在信号上的噪声
% randn是均值μ=0、标准方差σ=1的正态分布，产生与X同维度的随机数矩阵
NOISE=randn(size(X)); % size返回X的维度
% NOISE的均值为0时，标准方差σ的平方就是NOISE的平均功率
NOISE=NOISE-mean(NOISE); % 使得NOISE矩阵元素的均值为0
signal_power = 1/length(X)*sum(X.*X); % 信号X的功率强度
% dB作为功率量之比的单位时，等于功率强度之比的常用对数的10倍
noise_variance = signal_power / ( 10^(SNR/10) ); % 设置信噪比为SNR 
% noise_variance是满足信噪比的NOISE的方差，即平均功率 
% 下一句使得NOISE的标准方差σ等于noise_variance，使NOISE功率满足信噪比
NOISE=sqrt(noise_variance)/std(NOISE)*NOISE; % std返回NOISE元素的标准方差
Y=X+NOISE;
end