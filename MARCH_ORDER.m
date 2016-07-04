classdef MARCH_ORDER < handle
    properties (GetAccess=public, SetAccess=private)
        house_flag=0;
        area_index=0;
        done=0;
        element_array=[];
    end
    methods
       function obj = MARCH_ORDER(house_flag,area_index)
            obj.house_flag=house_flag;
            obj.area_index=area_index;
            obj.element_array=[];
            obj.done=0;
       end
       
       function obj=add_element(obj,target,troop_type_array)
           obj.element_array=[obj.element_array,MARCH_ORDER_ELEMENT(target,troop_type_array)];
       end
       
       function obj=remove_first_element(obj)
           if ~isempty(obj.element_array)
                obj.element_array(1)=[];
           else
               obj.done=1;
               
           end
       end
    end
end
    
    
 