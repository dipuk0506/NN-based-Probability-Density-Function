% This function loads the signal and may perform cropping & downsampling

function [signal,fs] = loading_signal


% load train
% signal=y;
%fs=1;

%[signal,fs]=wavread('kotha.wav');

[signal1,fs]=audioread('kotha.wav');
downsampling=2;
fs=fs/downsampling;
initial=40000;
end_point=90000;
points=initial:downsampling:end_point;
signal=signal1(points);

% A=load('Load_Forecasting_Data');
% signal=transpose(A.Data(:,15));
% fs=1;

length(signal)
end
