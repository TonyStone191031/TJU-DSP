% DSP FINAL 语音录制
FS_original = 10000; Bit = 24; %设置录音采样率等参数
voice_original = audiorecorder(FS_original, Bit, 1);
% voice_original包含录音数据，是audiorecorder对象，类型为audiorecorder
disp('Start speaking.')
recordblocking(voice_original, 5); %录音5秒
disp('End of Recording.')
% 回放录音数据voice_original，函数play输入类型为audiorecorder
play(voice_original); 
% 通过getaudiodata获取voice_original的数值double列向量myRecording_original
myRecording_original = getaudiodata(voice_original); 
audiowrite('FINAL_voice_original.wav', myRecording_original, FS_original);