clc
clear all

[test_signal,sampling_frequency]=loading_signal;
load('Speech')

Observe_start= 24001;
Obswerve_end=24050;

Targets= test_signal(Observe_start:Obswerve_end);
tic
%CDF values
y=[];
for CDF_value = .05:.05:.95
    for iter=1:Obswerve_end-Observe_start+1
        temp(iter) = net([test_signal(Observe_start+iter-6:Observe_start+iter-2)' CDF_value]');
    end
    y=[y;temp];
end
    
plot(y')
hold on
plot(Targets,'*')

toc