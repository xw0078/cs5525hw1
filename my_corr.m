function r = my_corr(A)
% A is a standardized matrix
digits(50);
A_size = size(A);
A_row_len = A_size(1);
A_col_len = A_size(2);
r = nan(A_col_len,A_col_len);
for i = 1:A_col_len
    for j = 1:A_col_len
        combine = horzcat(A(:,i),A(:,j));
        sum_combine = sum(combine,1);
        sum1 = sum_combine(1);
        sum2 = sum_combine(2);
        sum3 = 0;
        for n = 1:A_row_len
            sum3 = sum3 + combine(n,1)*combine(n,2);
        end
        covariance = sym(sum3 - sum1*sum2 / A_row_len) / (A_row_len-1);
        r(i,j) = covariance / (std(combine(:,1))*std(combine(:,2)));
    end 
end
