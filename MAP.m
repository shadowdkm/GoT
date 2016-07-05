classdef MAP < handle
    properties (GetAccess=public, SetAccess=private)
      map_areas=[];
      capitals=[13,23,27,37,41,47];
      init_seas=[8,10,5,3,2,12];
      
    end
    methods
        function obj = MAP()
            load map_res
            load AreaConns
            obj.map_areas=[];
            for i=1:size(areaconns,1)
                obj.map_areas=[obj.map_areas,AREA(i, areatype(i), map_resourses(i,5), map_resourses(i,3), map_resourses(i,2), map_resourses(i,4))];
            end
            for i=1:6
                obj.map_areas(obj.capitals(i)).set_house_flag(i);
                obj.map_areas(obj.capitals(i)).add_troop(1);
                obj.map_areas(obj.capitals(i)).add_troop(2);
                obj.map_areas(obj.init_seas(i)).set_house_flag(i);
                obj.map_areas(obj.init_seas(i)).add_troop(0);
            end
            obj.map_areas(14).set_house_flag(1);
            obj.map_areas(14).add_troop(1);
            obj.map_areas(25).set_house_flag(2);
            obj.map_areas(25).add_troop(1);
            obj.map_areas(21).set_house_flag(3);
            obj.map_areas(21).add_troop(1);
            obj.map_areas(32).set_house_flag(4);
            obj.map_areas(32).add_troop(1);
            obj.map_areas(43).set_house_flag(5);
            obj.map_areas(43).add_troop(1);
            obj.map_areas(46).set_house_flag(6);
            obj.map_areas(46).add_troop(1);

            obj.map_areas(10).add_troop(0);
            obj.map_areas(51).set_house_flag(5);
            obj.map_areas(51).add_troop(0);
        end        

        function area_list=areas_of_a_house(obj, house_index)
            area_list=[]; 
            for i=1:58
                if obj.map_areas(i).house_flag==house_index
                    area_list=[area_list,i];
                end
            end
        end
        
        function area_list=areas_of_a_house_with_troops(obj, house_index)
            area_list=[]; 
            for i=1:58
                if obj.map_areas(i).house_flag==house_index && ~isempty(obj.map_areas(i).troops)
                    area_list=[area_list,i];
                end
            end
        end
        
        function random_a_around(obj)
            for i=1:6
                possible_move_sides=obj.areas_of_a_house_with_troops(i);
                if length(possible_move_sides)>3
                    possible_move_sides=possible_move_sides(randperm(length(possible_move_sides)));
                    possible_move_sides(4:end)=[];
                end
                obj.map_areas(possible_move_sides(1)).random_move_troops(obj.map_areas)
                obj.map_areas(possible_move_sides(2)).random_move_troops(obj.map_areas)
                obj.map_areas(possible_move_sides(3)).random_move_troops(obj.map_areas)
            end
            
            for i=1:6
                obj.map_areas(obj.capitals(i)).add_troop(1);
                obj.map_areas(obj.init_seas(i)).add_troop(0);
            end
        end
        
        
        
    end
end
    
    
 