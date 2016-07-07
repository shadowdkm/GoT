classdef AREA < handle
    properties (GetAccess=public, SetAccess=private)
      index=0;
      troops=[];
      land_type=0;
      throne_token=0;
      defence=0;
      house_flag=0;
      crowns =  0;
      barrels = 0;
      towers = 0;
      connected_to=[];
      order=0;
      const_areaconns;
    end
    
    
    methods
      
       function obj = AREA(index, type, defence, crowns, barrels, towers)
           load AreaConns
           obj.const_areaconns=areaconns;
               
           
           obj.index=index;
           obj.land_type=type;
           obj.defence=defence;
           obj.crowns=crowns;
           obj.barrels=barrels;
           obj.towers=towers;                      
           obj.connected_to=areaconns(:,index);



           if type==2
               L='port';
           elseif type==0
               L='sea';
           else
               L='land';
           end
           %fprintf('Area %d (%s) is created with %d barrels, %d crowns and %d towers.\n',index, L,barrels, crowns, towers);
           
       end
       
       function reachable=can_march_to(obj, current_map_areas)
           index_of_this_land=obj.index;
           flag=current_map_areas(index_of_this_land).house_flag;
           reachable=obj.const_areaconns(:,index_of_this_land);
           
           if flag==0
               reachable=[];
               return;
           end  
           for looping_index=1:12
              new_connection=0;
              for inner_looping_index=1:12 
                 if reachable(inner_looping_index)>0 && current_map_areas(inner_looping_index).house_flag==current_map_areas(index_of_this_land).house_flag
                     reachable=reachable+current_map_areas(inner_looping_index).connected_to;
                     new_connection=new_connection+1;
                 end
              end
              if new_connection==0
                  break;
              end
           end   
           
           if areatype(obj.index)==0 % sea
               reachable(13:50)=0;
           elseif areatype(obj.index)==1 % land
               reachable(1:12)=0;
               reachable(51:end)=0;
           elseif areatype(obj.index)==2    % port
               reachable(13:end)=0;
           end
       end
       
       function march_choice=march_combinations(obj, current_map_areas)
            targets=find(obj.can_march_to(current_map_areas));            
            n_tar=length(targets);
            tar_occupied=zeros(1,n_tar);
            for i=1:n_tar
                if current_map_areas(targets(i)).house_flag~=0 && current_map_areas(targets(i)).house_flag~=obj.house_flag
                    tar_occupied(i)=1;
                end
            end
            n_troop=length(obj.troops);
            if sum(tar_occupied)==0      
                march_choice=arrange_targets(n_troop,targets);
            else
                march_choice=[];
                for j=1:length(targets)
                    if tar_occupied(j)==1
                        sub_targets=targets;
                        sub_occupied=tar_occupied;
                        sub_occupied(j)=0;
                        sub_targets(sub_occupied>0)=[];
                        march_choice=[march_choice;arrange_targets(n_troop,sub_targets)];
                    end
                end
            end
       end
       
       function type_array=troop_index2type(obj,index1001)
            type_array=[];
            for i=1:length(obj.troops)
                if index1001(i)==1
                    type_array=[type_array,obj.troops(i).type];
                end
            end
       end
       
       function march_orders=march_sequence(obj, current_map_areas)
           march_choices=march_combinations(obj, current_map_areas);
           march_choices(:,end+1:4)=0;
           arrayed_march_orders=[];
           
           for i=1:size(march_choices,1)
%                march_order=zeros(1,20);
               targets_this_time=unique(march_choices(i,march_choices(i,:)>0));
               if length(targets_this_time)==1
                    march_order=zeros(1,20);                    
                    march_order(1)=targets_this_time(1);
                    march_order(2:5)=(march_choices(i,:)==targets_this_time(1));
               elseif length(targets_this_time)==2
                    march_order=zeros(2,20);
                    
                    march_order(1,1)=targets_this_time(1);
                    march_order(1,2:5)=(march_choices(i,:)==targets_this_time(1));
                    march_order(1,6)=targets_this_time(2);
                    march_order(1,7:10)=(march_choices(i,:)==targets_this_time(2));
                    
                    march_order(2,1)=targets_this_time(2);
                    march_order(2,2:5)=(march_choices(i,:)==targets_this_time(2));
                    march_order(2,6)=targets_this_time(1);
                    march_order(2,7:10)=(march_choices(i,:)==targets_this_time(1));
               else
                    sort_tars=perms(targets_this_time);
                    march_order=zeros(size(sort_tars,1),20);
                    for j=1:size(sort_tars,1)
                        for k=1:length(targets_this_time)
                            march_order(j,k*5+[-4])=targets_this_time(k);
                            march_order(j,k*5+[-3:0])=(march_choices(i,:)==targets_this_time(k));
                        end
                    end
               end
               arrayed_march_orders=[arrayed_march_orders;march_order];   
               

           end
           
           march_orders=[];
           
            for i=1:size(arrayed_march_orders)
                 one_march_order=MARCH_ORDER(obj.house_flag,obj.index);
                 for j=1:4
                     if arrayed_march_orders(i,j*5-4)~=0
                         troop_array=obj.troop_index2type(arrayed_march_orders(i,j*5+[-3:0]));
                         one_march_order.add_element(arrayed_march_orders(i,j*5-4),troop_array);
                     end
                 end
                 march_orders=[march_orders,one_march_order];
            end
        end
       
       function set_house_flag(obj,flag)
           obj.house_flag=flag;
       end
       
       function add_troop(obj,troop_type)
           if length(obj.troops)>=4
               fprintf('Already 4 Troops @ Area %d\n', obj.index);
               return;
           end
               
           obj.troops=[obj.troops,TROOP(troop_type,obj.house_flag)];
           fprintf(' @ Area %d\n', obj.index);
       end
       
       function remove_troop(obj,troop_index)
           obj.troops(troop_index)=[];
       end
       
       function remove_all_troops(obj)
           obj.troops=[];
       end
       
       function put_a_throne_token(obj)
           obj.throne_token=1;
           fprintf('A throne token put in Area %d\n',obj.index)
       end
       
       function remove_throne_token(obj)
           obj.throne_token=0;
           fprintf('A throne token in Area %d in removed\n',obj.index)
       end
       
       function pop_array=sort_army(obj,current_map_areas,house_flag)
           pop_array=[];
           for i=1:58
               if current_map_areas(i).house_flag==house_flag && length(current_map_areas(i).troops)>1
                    pop_array=[pop_array,length(current_map_areas(i).troops)];
               end
           end
           pop_array=sort(pop_array,'descend');
       end
       
       function validity=check_population(obj, current_map_areas, house_flag, barrels)
           
           capacity=supply(barrels);
           pop_array=sort_army(obj,current_map_areas,house_flag);
           if isempty(pop_array)
               validity=1;
               return;
           end
           capacity(length(pop_array)+1:end)=[];
           fault_indexs=find(capacity-pop_array<0);
%           fault_indexs=find(capacity(1:length(pop_array))-pop_array<0);
           if isempty(fault_indexs)
               validity=1;
           else
               validity=0;
           end
       end
       
       function recruit_combinations=recruit(obj, current_map_areas, barrels)
           recruit_combinations=[];
           if obj.towers==0
               return;
           end
           possible_seas=find(obj.connected_to(1:12));
           possible_port=find(obj.connected_to(51:58));
           possible_upgrade=[];
           for i=1:length(obj.troops)
               if obj.troops(i).type==1
                   possible_upgrade=[possible_upgrade,i];
               end
           end
           
       end
       
       function move_troop(obj, current_map_areas, one_march_order)
          current_map_areas(one_march_order.area_index).remove_all_troops;
          while(~isempty(one_march_order.element_array))
              current_map_areas(one_march_order.element_array(1).target).set_house_flag(one_march_order.house_flag);
              for j=1:length(one_march_order.element_array(1).troop_type_array)
                  fprintf('From Area %d ',one_march_order.area_index)
                  current_map_areas(one_march_order.element_array(1).target).add_troop(one_march_order.element_array(1).troop_type_array(j));
              end
              
              one_march_order.remove_first_element;
          end

          if isempty(current_map_areas(one_march_order.area_index).troops)&&current_map_areas(one_march_order.area_index).land_type==0
                current_map_areas(one_march_order.area_index).set_house_flag(0);
          end
          
          %
          if isempty(current_map_areas(one_march_order.area_index).troops)&&current_map_areas(one_march_order.area_index).land_type==1
                current_map_areas(one_march_order.area_index).set_house_flag(0);
          end
       end
       
       function valid_move=test_move(obj, current_map_areas, current_barrels,one_march_order)
          test_map=copy_map(current_map_areas);
          test_order=copy_order(one_march_order);
           %target valid
           for i=1:length(test_order.element_array)%check move validity
             if test_map(test_order.area_index).house_flag~=test_map(test_order.element_array(i).target).house_flag&&test_map(test_order.element_array(i).target).house_flag~=0
                valid_move=0;
                return;
             end
          end
          
          fprintf('Testing Move:');
          obj.move_troop(test_map, test_order);
          
          %pop valid
          pop_validity=obj.check_population( test_map, test_order.house_flag, current_barrels);
          if pop_validity==0
              valid_move=0;
              return;
          end
          
          
          
          
          
          valid_move=1;
       end
       
       
       function random_move_troops(obj,current_map_areas, barrel_list)
           if obj.house_flag==0||isempty(obj.troops)
               return
           end
           house_barrels=barrel_list(obj.house_flag);
           possible_orders=obj.march_sequence(current_map_areas);
           k=randi(size(possible_orders,2));
           fprintf('[%d]:',size(possible_orders,2))
           while(~obj.test_move(current_map_areas, house_barrels, possible_orders(k)))
               possible_orders(k)=[];
               fprintf('[%d]',k)
               if isempty(possible_orders)
                   return;
%                    break;
               end
               k=randi(size(possible_orders,2));               
           end
%            if ~isempty(possible_orders)
                obj.move_troop(current_map_areas, possible_orders(k))
%            end
       end
    end
end