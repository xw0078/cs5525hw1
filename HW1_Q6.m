% part 1
d = csvread('food.csv',1,1);
row_len = size(d,1);
% part 2
d_center = d - repmat(mean(d),row_len,1); % centering
d_scale = d_center./repmat(std(d_center),row_len,1); % scale to unit variance
X = d_scale;
% part 3
% In homework paper

% part 4
A = X;
A_size = size(A); % get col and row length
A_row_len = A_size(1);
A_col_len = A_size(2);
my_corr = nan(A_col_len,A_col_len); % create a empty array for corelation
for i = 1:A_col_len
    for j = 1:A_col_len
        combine = horzcat(A(:,i),A(:,j)); % combine two columns (x, y) to one matrix for later use to go around nested loop
        sum_combine = sum(combine,1); % sum by columns
        sum1 = sum_combine(1); % get x sum
        sum2 = sum_combine(2); % get y sum
        mean1 = sum1/A_row_len; % get x mean
        mean2 = sum2/A_row_len; % get y mean
        covariance = 0;
        for n = 1:A_row_len
            i1 = combine(n,1) - mean1; 
            i2 = combine(n,2) - mean2;
            covariance = covariance+i1*i2/(A_row_len-1);
        end
        my_corr(i,j) = covariance / (std(combine(:,1))*std(combine(:,2))); % calculate correlation
    end 
end
my_corr % show result
corrcoef(X) % compare to native function

% part 5
[V,D,eigenvector] = eig(my_corr); % V: right eigen vector, D: eigen values, W: left eigen vector
eigenvalues = eig(my_corr); % get eigen values in ascending order

% part 6 choose left eigen vector
[eigenvalues_d,index] = sort(eigenvalues,'descend'); % get eigen values in descending order
eigenvector_d = eigenvector(:,index); % sort eigen vector order
row_len = size(eigenvalues_d,1);
sum_e = sum(eigenvalues_d); % sum of all eigen value
e_p = eigenvalues_d./sum_e*100; % percentage of each eigen value

figure(1)

subplot(2,2,2) % plot eigen value percentage
hold on
for i = 1:row_len
    plot(i,e_p(i),'bd');
    if(i ~= row_len)
        plot([i,i+1],[e_p(i),e_p(i+1)],'b-');
    end
end
ylabel('Eigen value percentage (%)')
hold off

% part 7

project = X*eigenvector_d(:,[1 2]); 
X_pca = project*(eigenvector_d(:,[1 2]))'; % eigen value decomposition

% part 8
subplot(2,2,3)
hold on
plot(X_pca(:,1),X_pca(:,2),'bs');
title('pca');
xlabel('pca-1')
ylabel('pca-2')
hold off

% part 10
[U,S,V] = svd(X); % svd function
R_svd = U*S(:,1:2)*(V(:,1:2))'; % singular value decomposition
% part 11
subplot(2,2,4)
hold on
plot(R_svd(:,1),R_svd(:,2),'bs');
title('svd');
hold off