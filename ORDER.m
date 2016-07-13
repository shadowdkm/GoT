classdef ORDER < handle
    properties (GetAccess=public, SetAccess=private)
        house_flag=0;
        marching=0;
        resting=0;
        supporting=0;
        raiding=0;
        defencing=0;
        star=0;
        the_march_order=[];
    end
    methods
       function obj = ORDER(house_flag)
            obj.house_flag=house_flag;
       end
       
       function clear(obj)
            obj.house_flag=0;
            obj.marching=0;
            obj.resting=0;
            obj.supporting=0;
            obj.raiding=0;
            obj.defencing=0;
            obj.the_march_order=[];
       end    
       
        function march(obj)
            obj.clear;
            obj.marching=1;
        end
        
        function raid(obj)
            obj.clear;
            obj.raiding=1;
        end
        
        function defence(obj)
            obj.clear;
            obj.defencing=1;
        end       
        
        function support(obj)
            obj.clear;
            obj.supporting=1;
        end
        
        function rest(obj)
            obj.clear;
            obj.resting=1;
        end
        
        function with_star(obj)
            obj.star=1;
        end
    end
end
    
    
 