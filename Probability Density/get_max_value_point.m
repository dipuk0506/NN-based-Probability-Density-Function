% Getting values of the maxium correlation
% Getting their location at the correlation signal

function [max_value,max_point] = get_max_value_point(result_corr,best_match_count,threshold)
for iter=1:best_match_count
    [max_value(iter), max_point(iter)]=max(result_corr);
    result_corr(max_point(iter))=-1;
    if max_value(iter)<threshold
        break;
    end
end
end