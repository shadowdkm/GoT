clear,
clc,
m=MAP();
m.list_map_as_text;
round=1;
while(~sum(m.castles_occupied>6))   
    m.random_a_around
    fprintf('-R %d-',round)
    round=round+1;
end