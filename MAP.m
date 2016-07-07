classdef MAP < handle
    properties (GetAccess=public, SetAccess=private)
      map_areas=[];
      capitals=[13,23,27,37,41,47];
      init_seas=[8,10,5,3,2,12];
      rank1=[1,2,3,4,5,6];
      rank2=[1,2,3,4,5,6];
      rank3=[1,2,3,4,5,6];
      current_crowns=[5,5,5,5,5,5];
      current_barrels=[1,1,1,1,1,1];
    end
    
    methods
        function obj = MAP()
            load map_res
            load AreaConns
            obj.map_areas=[];
%             obj.rank1=randperm(6);
%             obj.rank2=randperm(6);
%             obj.rank3=randperm(6);
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
        
        function b=barrels_on_the_map(obj, house_index)
            b=0;
            for i=1:58
                if obj.map_areas(i).house_flag==house_index
                    b=b+obj.map_areas(i).barrels;
                end
            end
        end
        
        function c=castles_occupied(obj, house_index)
            c=0;
            for i=1:58
                if obj.map_areas(i).house_flag==house_index && obj.map_areas(i).towers>0
                    c=c+1;
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
        
        function list_map_as_text(obj)
%             fprintf('\n*****************************')
            
            fprintf('\n1: '), for i=1:6,    fprintf('%s ',house_index2name(obj.rank1(i))),  end
            fprintf('\n2: '), for i=1:6,    fprintf('%s ',house_index2name(obj.rank2(i))),  end
            fprintf('\n3: '), for i=1:6,    fprintf('%s ',house_index2name(obj.rank3(i))),  end
            fprintf('\n');
            for i=6:-1:1
                fprintf('\n%s: %dB %dT',house_index2name(i),obj.barrels_on_the_map(i),obj.castles_occupied(i))
                area_list2disp=obj.areas_of_a_house(i);
                fprintf('\n');
                for j=1:length(area_list2disp)
                    fprintf('%d[',area_list2disp(j));
                    for k=1:length(obj.map_areas(area_list2disp(j)).troops)
                        fprintf('%d',obj.map_areas(area_list2disp(j)).troops(k).type);
                    end
                    fprintf('] ');
                end
            end
            
            
            
%             fprintf('\n*****************************')
            fprintf('\n')
        end    
        
        function rec_comb=recruit_combinations(obj, index)
            rec_comb=obj.map_areas(index).recruit_combinations(obj.map_areas, obj.current_barrels);
        end
        
        function cut_army(obj,house_flag)
            for i=1:58
                if obj.map_areas(i).house_flag==house_flag
                    [validity,fault_indexs]=obj.map_areas(i).check_population(obj.map_areas, house_flag, obj.current_barrels);
                    break;
                end                
            end
            
            if validity==1, return; end
            while validity==0
                obj.map_areas(fault_indexs(1)).remove_smallest_troop;
                [validity,fault_indexs]=obj.map_areas(i).check_population(obj.map_areas, house_flag, obj.current_barrels);
            end
        end
        
        function random_local_recruit(obj,index)
            if obj.map_areas(index).towers==1
                rec_comb=obj.recruit_combinations(index);
                recruit_command=randi(size(rec_comb,1));
                recruit_command=rec_comb(recruit_command,:);
                obj.map_areas(index).recruit(obj.map_areas,recruit_command);
            elseif obj.map_areas(index).towers==2
                rec_comb=obj.recruit_combinations(index);
                recruit_command=randi(size(rec_comb,1));
                recruit_command=rec_comb(recruit_command,:);
                obj.map_areas(index).recruit(obj.map_areas,recruit_command);
                
                rec_comb=obj.recruit_combinations(index);
                recruit_command=randi(size(rec_comb,1));
                recruit_command=rec_comb(recruit_command,:);
                obj.map_areas(index).recruit(obj.map_areas,recruit_command);
            end
        end
        
        function random_a_around(obj)
            for i=1:6
                possible_move_sides=obj.areas_of_a_house_with_troops(obj.rank1(i));
                if length(possible_move_sides)>3
                    possible_move_sides=possible_move_sides(randperm(length(possible_move_sides)));
                    possible_move_sides(4:end)=[];
                end
                
                for j=1:length(possible_move_sides)
                    obj.map_areas(possible_move_sides(j)).random_move_troops(obj.map_areas,obj.current_barrels)
                end
            end
            
            obj.list_map_as_text;
            
            for i=1:6                
                 obj.map_areas(obj.capitals(i)).set_house_flag(i);
                 obj.current_barrels(i)=barrels_on_the_map(obj, i);
            end
            
            obj.list_map_as_text;
            
            for i=1:6
                 obj.random_local_recruit(obj.capitals(i))
                 obj.cut_army(i)
            end
            
            obj.list_map_as_text;
        end
        
    end
end
    
    
 