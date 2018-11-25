% Function for Probability Density
% Returns Values, CDF (0 to 1)

% Inputs are Test signal=long string  
% Prediction point = PI for the point needs to be determined using previous values
% Search length = length over which similarities are searched
% n = length of correlation sample (closest 10 to 30 samples)
% Percent = how much weight we need to cover (95%)


function [Values CDF] = Probability_Density(test_signal, prediction_point,search_length,n, best_match_count)
[result_corr,ratio_factor] = norm_corr_mn(test_signal(1:prediction_point-1), search_length, n);
%corrrelating over length and finding nornalized correlation values and the
%ratio of the signal 

best_match_threshold=0.5;
% If correlation value is smaller than threshold, the point will not be considered 


% "best match count" number of samples will be considered in case of too
% many high correlation values

[max_value,max_point] = get_max_value_point(result_corr,best_match_count,best_match_threshold);
% getting top correlation values and corresponding point number


for iter=1:length(max_value)
    forecast_point(iter)=test_signal(prediction_point-max_point(iter))*ratio_factor(max_point(iter));
% Getting max point and multiplying it with the ratio to receive a
% predictive value
    prediction_weight(iter)=(max_value(iter)^5)*2/(ratio_factor(max_point(iter))+1/ratio_factor(max_point(iter)));
% Weight of the point (How relevent the point is)
% Weight = corr_value* 2/(r+1/r)
end

%-----------------------------------
%-----------------------------------
% Make PDF Here
[out,idx] = sort(forecast_point);
prediction_weight = prediction_weight/sum(prediction_weight); %normalize from 0 to 1.
Values = 2*out(1)-out(end); CDF=0; %leftmost point
temp =0;
for iter=1:length(max_value)
    Values = [Values out(iter)];
    CDF = [CDF temp+prediction_weight(idx(iter))/2]; %CDF value at this point is at the middle of change
    temp = temp+prediction_weight(idx(iter));
end

Values = [Values 2*out(end)-out(1)]; 
CDF = [CDF 1]; %CDF value at last end

%-----------------------------------

end