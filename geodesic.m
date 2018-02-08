function spm = geodesic(A,dm)    
% Input:
% A: a matrix with 3d points, row as coordinate, column as obervation
% dm: distance matrix for A
my_size = size(A);
col_len = my_size(2);
spm = nan(col_len,col_len); % shortest path matrix

counter = 1; % matrix counter
for i = 1:col_len
    for j = i:col_len
        if(dm(i,j)>0)
            s(counter) = i; % source matrix
            t(counter) = j; % destination matrix
            w(counter) = dm(i,j); % weight matrix
            counter = counter +1; 
        end
    end
end

G = graph(s,t,w); % neibour graph

for i = 1:col_len
    for j = 1:col_len
        [sp,spcost] = shortestpath(G,i,j);
        spm(i,j) = spcost; % calculate 
    end
end
        

