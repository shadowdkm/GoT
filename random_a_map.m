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

capitals=[13,23,27,41,37,47];
init_seas=[7,10,5,2,3,1];
for i=1:6
    areas(capitals(i)).set_house_flag(i);
    areas(capitals(i)).add_troop(1);
    areas(capitals(i)).add_troop(2);
    areas(init_seas(i)).set_house_flag(i);
    areas(init_seas(i)).add_troop(0);
end
