% DSP FINAL ����¼��
FS_original = 10000; Bit = 24; %����¼�������ʵȲ���
voice_original = audiorecorder(FS_original, Bit, 1);
% voice_original����¼�����ݣ���audiorecorder��������Ϊaudiorecorder
disp('Start speaking.')
recordblocking(voice_original, 5); %¼��5��
disp('End of Recording.')
% �ط�¼������voice_original������play��������Ϊaudiorecorder
play(voice_original); 
% ͨ��getaudiodata��ȡvoice_original����ֵdouble������myRecording_original
myRecording_original = getaudiodata(voice_original); 
audiowrite('FINAL_voice_original.wav', myRecording_original, FS_original);