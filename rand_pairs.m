%init_con_pairs
numb_of_l_areas=50;
numb_of_s_areas=13;
pairs=zeros(numb_of_l_areas+numb_of_s_areas,numb_of_l_areas+numb_of_s_areas);
for i=1:size(pairs,1)
    connectl=randi(1)+1;
    if i<numb_of_l_areas
        connects=randi(2)-1;
    else
        connects=randi(2);
    end
    ls=randperm(numb_of_l_areas);
    ls(1:numb_of_l_areas-connectl)=[];
    ss=randperm(numb_of_s_areas)+numb_of_l_areas;
    ss(1:numb_of_s_areas-connects)=[];
    pairs(i,[ls,ss])=1;
    pairs(i,i)=0;
end

pairs=pairs+pairs';
pairs(pairs>1)=1;

figure,imagesc(pairs)