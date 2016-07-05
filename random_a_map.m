%make_a_ramdom_map
clc
clear 
load AreaConns
areas=[];
%%
for i=1:size(areaconns,1)
   resources=randi(3)-1;
   barrel_here=0;
   crown_here=0;
   tower_here=0;
   if areatype(i)==1
       for j=1:resources
           see_where_it_goes=randi(3);
           switch see_where_it_goes
               case 1
                   barrel_here=barrel_here+1;
               case 2
                   crown_here=crown_here+1;
               case 3
                   tower_here=tower_here+1;
           end
       end
   end
   
   areas=[areas,AREA(i, areatype(i), 0, crown_here, barrel_here, tower_here)];
end

capitals=[13,23,27,37,41,47];
init_seas=[8,10,5,3,2,12];
for i=1:6
    areas(capitals(i)).set_house_flag(i);
    areas(capitals(i)).add_troop(1);
    areas(capitals(i)).add_troop(2);
    areas(init_seas(i)).set_house_flag(i);
    areas(init_seas(i)).add_troop(0);
end

areas(50).set_house_flag(3);
areas(50).add_troop(1);
areas(42).set_house_flag(3);
areas(42).add_troop(1);
areas(42).add_troop(2);
areas(42).add_troop(3);

orders=areas(42).march_sequence(areas);


areas(42).random_move_troops(areas)
areas(47).random_move_troops(areas)
for rounds=1:3
    for i=1:58
            areas(i).random_move_troops(areas)
    end
    for i=1:6
        areas(capitals(i)).add_troop(1);
        areas(init_seas(i)).add_troop(0);
    end
end