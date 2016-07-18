function comb=split4(n)
    comb=randi(n+1,[1,4]);
    comb=sort(comb);
    comb=diff(comb);
end