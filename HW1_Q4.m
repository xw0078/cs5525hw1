load('data.mat')
ed_matrix = nan(200,200); % euclidean distance matrix
% problem 1
for i = 1:200
    for j = 1:200
       ed_matrix(i,j)  = norm(X_data(:,i) - X_data(:,j));
    end
end
ed_8 = ed_matrix(1:8,1:8);
x_8 = X_data(:,1:8);
disp('Distance matrix for 8 points')
ed_8

fn_idx = nan(200,5);
for i = 1:200
    [num, val] = sort(ed_matrix(i,:));
    idx = val(2:6);
    for j = 1:5
        fn_idx(i,j) = idx(j);
    end
end


% (a) for whole dataset
kn_dm = inf(200,200); % 5 nearest distance graph
for i = 1:200
    for j = 1:5
        kn_dm(i,fn_idx(i,j)) = ed_matrix(i,fn_idx(i,j));
    end
end
disp('5 nearest neighbor graph for all points')
kn_dm;

% (b) for whole data set
l6_dm = inf(200,200);  % <6 distance neighbor graph
for i = 1:200
    for j = 1:200
        if (ed_matrix(i,j)<6)
            l6_dm(i,j) = ed_matrix(i,j);
        end
    end
end
disp('<6 distance neighbor graph for all points')
l6_dm;

% problem 2
% get 5 nearest distance neighbor matrix for 8 points

fn_8idx = nan(8,5);
for i = 1:8
    [num, val] = sort(ed_8(i,:));
    idx = val(2:6);
    for j = 1:5
        fn_8idx(i,j) = idx(j);
    end
end
fn_8idx
kn_8dm = inf(8,8); % 5 nearest distance matrix
for i = 1:8
    for j = 1:5
        kn_8dm(i,fn_8idx(i,j)) = ed_8(i,fn_8idx(i,j));
    end
end
disp('5 nearest neighbor graph for 8 points')
kn_8dm
disp('geodesic matrix for 5 nearest neighbor graph for 8 points')
geodesic(x_8,kn_8dm)

% get <6 distance neighbor matrix
l6_8dm = inf(8,8);  % <6 distance neighbor matrix
for i = 1:8
    for j = 1:8
        if (ed_8(i,j)<6)
            l6_8dm(i,j) = ed_8(i,j);
        end
    end
end
disp('<6 distance neighbor graph for 8 points')
l6_8dm
disp('geodesic matrix for <6 distance neighbor graph for 8 points')
geodesic(x_8,l6_8dm)
