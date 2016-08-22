classdef TROOP < handle
    properties (GetAccess=public, SetAccess=public)
      type=0;
      active=1;
      house_flag=0;
      iskilled=0;
    end
    methods
       function obj = TROOP(init_type, init_house)
          if nargin == 2
             obj.type = init_type;
             obj.house_flag=init_house;
             if init_house==6, H='Stk';
             elseif init_house==5, H='Grj';
             elseif init_house==4, H='Lts';
             elseif init_house==3, H='Tyr';
             elseif init_house==2, H='Brt';
             elseif init_house==1, H='Drn';
             else error('house label should be [1,6]');
             end
             
             if init_type==1, T='Ftm';
             elseif init_type==2, T='Knt';
             elseif init_type==3, T='Seg';
             elseif init_type==0, T='Shp';
             else error('type label should be [0,3]');
             end
             
          else
             error('troop type and house it belongs to have to be determined');
          end
       end
       function obj=Disable(obj)
           obj.active=0;
       end
       function obj=Enable(obj)
           obj.active=1;
       end
       function obj=Killed(obj)
           obj.iskilled=1;
           obj.active=0;
       end
    end
end
    
    
 