clear m round
clc,
m=MAP();
m.list_map_as_text;
round=1;
logs=[];
while(~sum(m.castles_occupied>6)&&round<=6)   
    round_log=evalc('m.random_a_around');       logs=strcat(logs,round_log);    
    fprintf('\n-- R %d --\n',round);            logs=strcat(logs,sprintf('\n-- R %d --\n',round));
    round=round+1;
end
% m.list_map_as_html(map_indexs, logs);
