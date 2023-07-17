function [ db, mag, pha, grd, w ] = freqz_m( b, a )
% freqz子程序的改进版本
%-----------------------
% [ db, mag, pha, grd, w ] = freqz_m( b, a )
%  db = [ 0 到 pi 弧度]区间内的相对振幅(dB)
% mag = [ 0 到 pi 弧度]区间内的绝对振幅
% pha = [ 0 到 pi 弧度]区间内的相位响应
% grd = [ 0 到 pi 弧度]区间内的群迟延
%   w = [ 0 到 pi 弧度]区间内的501个频率样本向量
%   b = H(z)的分子多项式系数(对FIR:b = h)
%   a = H(z)的分母多项式系数(对FIR:a = [1])
%
[H,w] = freqz(b, a, 1000, 'whole');
H = (H(1:1:501))';w = (w(1:1:501))';
mag = abs(H);
db = 20*log10((mag + eps)/max(mag));
pha = angle(H);
% pha = unwrap(angle(H));
grd = grpdelay(b, a, w);
% grd = -diff(pha)

end

