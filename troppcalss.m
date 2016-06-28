classdef TROOP
    properties (GetAccess=Public, SetAccess=Private)
      kind=0;
      active=1;
      house_flag=0;
      iskilled=0;
    end
    methods
       function obj = TROOP(kindval)
          obj.kind=kindval;           
       end
       function Disable()
           active=0;
       end
       function Enable()
           active=1;
       end
       function Killed()
           iskilled=1;
           active=0;
       end
    end
end
    
    
 