clc
clear all

% 1.	Loading signal
[test_signal,sampling_frequency]=loading_signal;
collection_start=24001;
collection_end=24050;
search_length=2000;
corr_length=5;
I_length=corr_length+1;
O_position=corr_length+2;
collection_range = collection_start-collection_end;
best_match_count=100; % Can be increased to increase accuracy
% Data Generation for CDF training
index_data=0;

tic %counting time

for prediction_point=collection_start:collection_end
    [Values, CDF] = Probability_Density(test_signal, prediction_point,search_length,corr_length, best_match_count);
    %observing correlation based CDF
    %plot(Values, CDF)
    %hold on
    
    %Now creade Data
    for iter=1:length(CDF) %Creating data, format: [previous_samples CDF Target] in each row
        index_data = index_data+1;
        Data_CDF(index_data,:)= [test_signal(prediction_point-corr_length:prediction_point-1)' CDF(iter) Values(iter)];
    end
    if mod(prediction_point,500)==0
        (prediction_point-collection_start)/(collection_end-collection_start)*100 %to observe the progress in Command Window
        toc
    end
end
clc

toc %counting time

MinMax = [min(Data_CDF(:,1:I_length))' max(Data_CDF(:,1:I_length))'];
L1_size=15; L2_size=10;
net = newff(MinMax,[L1_size L2_size 1]);

net.trainParam.epochs = 500; % May increase or decrease for accuracy and overfitting issues 
%net.trainParam.showWindow = false; net.trainParam.showCommandLine = false; net.trainParam.show = NaN;
net = train(net,Data_CDF(:,1:I_length)',Data_CDF(:,O_position)' );


save('Speech', 'net')

toc %counting time
