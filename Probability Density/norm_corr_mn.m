% Correlate n recent samples with the existing string

function [result_corr,ratio] = norm_corr_mn(array_x,search_length, n)
    
    length_x=length(array_x);

    if length_x>n
        compare_length= min(search_length,(length_x-n));
        segment_1=array_x(length_x+1-n:length_x);
        norm_1=sqrt(sum(segment_1.*segment_1));
        if sum(norm_1)==0
            result_corr =-1;
            ratio=-10;
        else
            result_corr=zeros(1,compare_length);
            ratio=zeros(1,compare_length);
            for iter=1:compare_length-n
                segment_2=array_x(length_x+1-n-iter:length_x-iter);
                norm_2= sqrt(sum(segment_2.*segment_2));
                result_corr(iter)=sum(segment_1.*segment_2)/norm_1/norm_2;
                ratio(iter)=norm_1/norm_2; 
            end
        end
    else
        result_corr =-1;
        ratio=-10;
    end
end