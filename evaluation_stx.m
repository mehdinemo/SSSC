function rand_x = evaluation_stx(Labels, per)

N = length(Labels);
rand_x = zeros(N,1);
for i=1:N
    rand_x(i)=i-(N+1)/2;
end

N_rand = round(per*N);
ind = randperm(N,N_rand);
ch_rx = zeros(size(ind));
del_ind = zeros(size(ind));
for i=1:N_rand
    if Labels(ind(i))==1
        if ind(i)>N/2
            ch_rx(i)=-rand_x(ind(i));
            del_ind(i)=find(rand_x==-rand_x(ind(i)));
        else
            ch_rx(i)=rand_x(ind(i));
            del_ind(i)=ind(i);
        end
    else
        if ind(i)>N/2
            ch_rx(i)=rand_x(ind(i));
            del_ind(i)=ind(i);
        else
            ch_rx(i)=-rand_x(ind(i));
            del_ind(i)=find(rand_x==-rand_x(ind(i)));
        end
    end
end

del_ind = sort(del_ind,'descend');
for i=1:N_rand
    rand_x(del_ind(i))=[];
end

ind_P = ind;
ind=sort(ind);
for i=1:N_rand
    rand_x = [rand_x(1:ind(i)-1);ch_rx(find(ind_P==ind(i)));rand_x(ind(i):end)];
end

end