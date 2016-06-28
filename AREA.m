classdef AREA < handle
    properties (GetAccess=public, SetAccess=private)
      troops=[];
      is_land=0;
      is_port=0;
      throne_token=0;
      defence=0;
      house_flag=0;
      crowns =  0;
      barrels = 0;
      towers = 0;
    end
    methods
       function obj = AREA(is_land, is_port, defence, crowns, barrels, towers)
           obj.is_land=is_land;
           obj.is_port=is_port;
           obj.defence=defence;
           obj.crowns=crowns;
           obj.barrels=barrels;
           obj.towers=towers;
       end
    end
end