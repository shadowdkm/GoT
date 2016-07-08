classdef ORDER < handle
    properties (GetAccess=public, SetAccess=private)
        house_flag=0;
        area_index=0;
        march=0;
        rest=0;
        support=0;
        raid=0;
        defence=0;
        the_order=[];
    end
    methods
       function obj = ORDER(house_flag,area_index)
            obj.house_flag=house_flag;
            obj.area_index=area_index;
       end
       
       function clear(obj)
            obj.house_flag=0;
            obj.area_index=0;
            obj.march=0;
            obj.rest=0;
            obj.support=0;
            obj.raid=0;
            obj.defence=0;
            obj.the_order=[];
       end    
    end
end
    
    
 