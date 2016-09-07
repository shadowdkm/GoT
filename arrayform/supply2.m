function capacity=supply2(barrels)
    if barrels==6
        capacity=[4,3,2,2,2];
    elseif barrels==5
        capacity=[4,3,2,2];
    elseif barrels==4
        capacity=[3,3,2,2];
    elseif barrels==3
        capacity=[3,2,2,2];
    elseif barrels==2
        capacity=[3,2,2];
    elseif barrels==1
        capacity=[3,2];
    else
        capacity=[2,2];
    end
end