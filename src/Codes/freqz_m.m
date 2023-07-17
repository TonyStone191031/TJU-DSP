function [ db, mag, pha, grd, w ] = freqz_m( b, a )
% freqz�ӳ���ĸĽ��汾
%-----------------------
% [ db, mag, pha, grd, w ] = freqz_m( b, a )
%  db = [ 0 �� pi ����]�����ڵ�������(dB)
% mag = [ 0 �� pi ����]�����ڵľ������
% pha = [ 0 �� pi ����]�����ڵ���λ��Ӧ
% grd = [ 0 �� pi ����]�����ڵ�Ⱥ����
%   w = [ 0 �� pi ����]�����ڵ�501��Ƶ����������
%   b = H(z)�ķ��Ӷ���ʽϵ��(��FIR:b = h)
%   a = H(z)�ķ�ĸ����ʽϵ��(��FIR:a = [1])
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

