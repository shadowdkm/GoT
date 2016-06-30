function type=areatype(areaindex)
    if areaindex>0&&areaindex<=13
        type=0;
    elseif areaindex>=14&&areaindex<=50
        type=1;
    elseif areaindex>=51&&areaindex<=58
        type=2;
    else
        type=999;
    end
end