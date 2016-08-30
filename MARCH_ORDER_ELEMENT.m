classdef MARCH_ORDER_ELEMENT < handle
    properties (GetAccess=public, SetAccess=private)
      target=0;
      troop_type_array=[];
    end
    methods
       function obj = MARCH_ORDER_ELEMENT(target,troop_type_array)
            obj.target=target;
            obj.troop_type_array=troop_type_array; 
       end     
       
       function attack_val=attack(obj)
           attack_val=0;
           for i=1:length(obj.troop_type_array)
               if obj.troop_type_array(i)==0||obj.troop_type_array(i)==1
                   attack_val=attack_val+1;
               elseif obj.troop_type_array(i)==2
                   attack_val=attack_val+2;
               elseif obj.troop_type_array(i)==3
                   attack_val=attack_val+4;
               end
           end
       end
    end
end
    
    
 