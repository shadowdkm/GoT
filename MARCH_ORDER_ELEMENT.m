classdef MARCH_ORDER_ELEMENT < handle
    properties (GetAccess=public, SetAccess=private)
      target=0;
      troop_indexes=[0,0,0,0];
    end
    methods
       function obj = MARCH_ORDER_ELEMENT(target,troop_index)
            obj.target=target;
            obj.troop_indexes=troop_index;           
       end      
    end
end
    
    
 