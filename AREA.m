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
           obj.index=index;
           obj.land_type=type;
           obj.defence=defence;
           obj.crowns=crowns;
           obj.barrels=barrels;
           obj.towers=towers;
           
           obj.const_areaconns=areaconns;
           obj.connected_to=areaconns(:,index);
           if type==2
               L='port';
           elseif type==0
               L='sea';
           else
               L='land';
           end
           fprintf('Area %d (%s) is created with %d barrels, %d crowns and %d towers.\n',index, L,barrels, crowns, towers);
       end
       
       function reachable=can_march_to(obj, current_map_areas)
           index_of_this_land=obj.index;
           flag=current_map_areas(index_of_this_land).house_flag;
           reachable=obj.const_areaconns(:,index_of_this_land);
           
           if flag==0
               reachable=[];
               return;
           end  
           for looping_index=1:13
              new_connection=0;
              for inner_looping_index=1:13 
                 if reachable(inner_looping_index)>0 && current_map_areas(reachable(inner_looping_index)).house_flag==current_map_areas(index_of_this_land).house_flag
                     reachable=reachable+current_map_areas(reachable(inner_looping_index)).connected_to;
                     new_connection=new_connection+1;
                 end
              end
              if new_connection==0
                  break;
              end
           end   
           
           if areatype(obj.index)==0 % sea
               reachable(14:end)=0;
           elseif areatype(obj.index)==1 % land
               reachable(1:13)=0;
               reachable(51:end)=0;
           elseif areatype(obj.index)==2    % port
               reachable(14:end)=0;
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
           march_orders=[];
           
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
               march_orders=[march_orders;march_order];   
march_order=MARCH_ORDER(obj.house_flag,obj.index);
troop_array=troop_index2type(obj,march_choices(i,:)==targets_this_time);
march_order.add_element(targets_this_time,troop_array);
           end
           march_orders=[ones(size(march_orders,1),1)*obj.house_flag,ones(size(march_orders,1),1)*obj.index,march_orders];
       end
       
       function set_house_flag(obj,flag)
           obj.house_flag=flag;
       end
       
       function add_troop(obj,troop_type)
           obj.troops=[obj.troops,TROOP(troop_type,obj.house_flag)];
           fprintf(' @ Area %d\n', obj.index);
       end
       
       function remove_troop(obj,troop_index)
           obj.troops(troop_index)=[];
       end
       
       function remove_all_troops(obj)
           obj.troops=[];
       end
       
       function valid_move=move_troop(obj, current_map_areas, one_march_order)
           %march order is a 22x1 vector
            troop_array=[];
            for troop_index=1:length(obj.troops)
                troop_array=[troop_array,obj.troops(troop_index).type];
            end
            current_map_areas(one_march_order(2)).remove_all_troops;
            for i=1:4
               if one_march_order(i*5-2)==0
                   break;
               elseif current_map_areas(one_march_order(i*5-2)).house_flag~=obj.house_flag&&current_map_areas(one_march_order(i*5-2)).house_flag~=0
                    valid_move=0;
                    return;
               end
               for j=1:4
                   if one_march_order(i*5-2+j)==1
                       current_map_areas(one_march_order(i*5-2)).add_troop(troop_array(j));
                   end
               end
            end
            valid_move=1;
       end
    end
end