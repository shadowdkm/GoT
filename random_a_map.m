%make_a_ramdom_map
clc
clear 
load pairs
%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

areas=[];
for i=1:numb_of_land_areas
   resources=randi(3)-1;
   barrel_here=0;
   crown_here=0;
   tower_here=0;
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
  
   areas=[areas,AREA(i, 1, 0, 0, crown_here, barrel_here, tower_here,find(pairs(:,i)))];
end


for i=1:numb_of_sea_areas
   barrel_here=0;
   crown_here=0;
   tower_here=0;
  
  areas=[areas,AREA(i+numb_of_land_areas, 0, 0, 0, crown_here, barrel_here, tower_here, find(pairs(:,i+numb_of_land_areas)))];

end

for i=1:6
    areas(i).set_house_flag(i);
    areas(i).add_troop(1);
    areas(i).add_troop(2);
    if areas(i).connected_to(end)>numb_of_land_areas
        areas(areas(i).connected_to(end)).set_house_flag(i);
        areas(areas(i).connected_to(end)).add_troop(0);
    end
end



