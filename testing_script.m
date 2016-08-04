clear,
clc,
m=MAP();
m.list_map_as_text;
round=1;
while(~sum(m.castles_occupied>6)&&round<=4)   
    m.random_a_around
    fprintf('\n-- R %d --\n',round)
    round=round+1;
end

