classdef AREA < handle
    properties (GetAccess=public, SetAccess=private)
      index=0;
      troops=[];
      is_land=0;
      is_port=0;
      throne_token=0;
      defence=0;
      house_flag=0;
      crowns =  0;
      barrels = 0;
      towers = 0;
      connected_to=[];
      order=0;
    end
    
    
    methods
       function obj = AREA(index, is_land, is_port, defence, crowns, barrels, towers, connections)
           obj.index=index;
           obj.is_land=is_land;
           obj.is_port=is_port;
           obj.defence=defence;
           obj.crowns=crowns;
           obj.barrels=barrels;
           obj.towers=towers;
           obj.connected_to=connections;
           if is_port==1
               L='port';
           elseif is_land==0
               L='sea';
           else
               L='land';
           end
           fprintf('Area %d (%s) is created with %d barrels, %d crowns and %d towers.\n',index, L,barrels, crowns, towers);
       end
       function reachable_area_indexs=can_march_to(index_of_this_land, current_reachables)
           flag=areas(index_of_this_land).house_flag;
           if flag==0
               reachable_area_indexs=[];
               return;
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