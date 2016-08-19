function arrangements=arrange_targets(troop_number,target_array)
     if troop_number==1
        arrangements=target_array;
    elseif troop_number==2
        [X1 X2]=ndgrid(target_array,target_array);
        arrangements=[X1(:),X2(:)];
    elseif troop_number==3
        [X1 X2 X3]=ndgrid(target_array,target_array,target_array);
        arrangements=[X1(:),X2(:),X3(:)];
    elseif troop_number==4
        [X1 X2 X3 X4]=ndgrid(target_array,target_array,target_array,target_array);
        arrangements=[X1(:),X2(:),X3(:),X4(:)];
    else
         arrangements=[];
    end
end