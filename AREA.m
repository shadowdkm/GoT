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
       function reachable=can_march_to(obj,reachables, current_map_areas)
           index_of_this_land=obj.index;
           flag=current_map_areas(index_of_this_land).house_flag;
           if isempty(reachables)
               reachable=obj.const_areaconns(:,index_of_this_land);
           end
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
           
       end
       function set_house_flag(obj,flag)
           obj.house_flag=flag;
       end
       function add_troop(obj,troop_type)
           obj.troops=[obj.troops,TROOP(troop_type,obj.house_flag)];
           fprintf(' @ Area %d\n', obj.index);
       end
    end
end