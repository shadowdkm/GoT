classdef MAP < handle
    properties (GetAccess=public, SetAccess=private)
        map_areas=[];
        capitals=[13,23,27,37,41,47];
        init_seas=[8,10,5,3,2,12];
        rank1=[1,2,3,4,5,6];
        rank2=[1,2,3,4,5,6];
        rank3=[1,2,3,4,5,6];
        current_crowns=[5,5,5,5,5,5];
        current_barrels=[1,1,1,1,1,1];
    end
    
    methods
        function obj = MAP()
            load map_res
            load AreaConns
            obj.map_areas=[];
                        obj.rank1=randperm(6);
                        obj.rank2=randperm(6);
                        obj.rank3=randperm(6);
            for i=1:size(areaconns,1)
                obj.map_areas=[obj.map_areas,AREA(i, areatype(i), map_resourses(i,5), map_resourses(i,3), map_resourses(i,2), map_resourses(i,4))];
                
            end
            for i=1:6
                obj.map_areas(obj.capitals(i)).set_house_flag(i);
                obj.map_areas(obj.capitals(i)).add_troop(1);
                obj.map_areas(obj.capitals(i)).add_troop(2);
                obj.map_areas(obj.init_seas(i)).set_house_flag(i);
                obj.map_areas(obj.init_seas(i)).add_troop(0);
            end
            obj.map_areas(14).set_house_flag(1);
            obj.map_areas(14).add_troop(1);
            obj.map_areas(25).set_house_flag(2);
            obj.map_areas(25).add_troop(1);
            obj.map_areas(21).set_house_flag(3);
            obj.map_areas(21).add_troop(1);
            obj.map_areas(32).set_house_flag(4);
            obj.map_areas(32).add_troop(1);
            obj.map_areas(43).set_house_flag(5);
            obj.map_areas(43).add_troop(1);
            obj.map_areas(46).set_house_flag(6);
            obj.map_areas(46).add_troop(1);
            
            obj.map_areas(10).add_troop(0);
            obj.map_areas(51).set_house_flag(5);
            obj.map_areas(51).add_troop(0);
        end
        
        function rand_order_array=random_orders(obj, house_flag)
            stars_can_use=[3,3,2,1,0,0];
            stars_can_use=stars_can_use(obj.rank3(house_flag));
            orders_types=[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5];
            orders_types=orders_types(randperm(15));
            stared_orders=[0,0,0,0,0];
            stared_orders(1:stars_can_use)=1;
            stared_orders=stared_orders(randperm(5));            
            rand_order_array=[];
            for i=1:15
                rand_order_array=[rand_order_array,ORDER(house_flag)];
            end
            
            %mar, rai, def, sup, res
            for i=1:15
                if orders_types(i)==1
                    rand_order_array(i).march;
                elseif orders_types(i)==2
                    rand_order_array(i).raid;
                elseif orders_types(i)==3
                    rand_order_array(i).defence;
                elseif orders_types(i)==4
                    rand_order_array(i).support;
                elseif orders_types(i)==5
                    rand_order_array(i).rest;
                end
                
                if stared_orders(orders_types(i))==1
                    rand_order_array(i).with_star;
                    stared_orders(orders_types(i))=0;
                end
            end
        end
        
        function area_list=areas_of_a_house(obj, house_index)
            area_list=[];
            for i=1:58
                if obj.map_areas(i).house_flag==house_index
                    area_list=[area_list,i];
                end
            end
        end
        
        function update_barrels(obj)
            for house_index=1:6
                b=0;
                for i=1:58
                    if obj.map_areas(i).house_flag==house_index
                        b=b+obj.map_areas(i).barrels;
                    end
                end
                obj.current_barrels(house_index)=b;
            end
        end
        
        function castles_array=castles_occupied(obj,given_house_flag)
            castles_array=[0,0,0,0,0,0];
            for house_index=1:6
                castles=0;
                for i=1:58
                    if obj.map_areas(i).house_flag==house_index && obj.map_areas(i).towers>0
                        castles=castles+1;
                    end
                end
                castles_array(house_index)=castles;
            end
            if nargin==2
                castles_array=castles_array(given_house_flag);
            end
        end
        
        function area_list=areas_of_a_house_with_troops(obj, house_index)
            area_list=[];
            for i=1:58
                if obj.map_areas(i).house_flag==house_index && ~isempty(obj.map_areas(i).troops)
                    area_list=[area_list,i];
                end
            end
        end
        
        function thrones=throne_token_on_the_map(obj,house_flag)
            thrones=[0,0,0,0,0,0];
            for i=1:58
                if obj.map_areas(i).house_flag>0 && obj.map_areas(i).throne_token>0
                    thrones(obj.map_areas(i).house_flag)=thrones(obj.map_areas(i).house_flag)+1;
                end
            end
            if nargin==2
                thrones=thrones(house_flag);
            end
        end
        
        function collect_thrones_event(obj)
            fprintf('\nCollect Thrones Event\n');
            thrones=[0,0,0,0,0,0];
            for i=1:58
                if obj.map_areas(i).house_flag>0 && obj.map_areas(i).crowns>0
                    thrones(obj.map_areas(i).house_flag)=thrones(obj.map_areas(i).house_flag)+obj.map_areas(i).crowns;
                end
            end
            throne_pool=18-obj.throne_token_on_the_map();
            obj.current_crowns=obj.current_crowns+thrones;
            obj.current_crowns(obj.current_crowns>throne_pool)=throne_pool(obj.current_crowns>throne_pool);
        end
        
        function auction_event(obj)
            fprintf('\nAuction Event\n');
            obj.rank1=randperm(6);
            obj.rank2=randperm(6);
            obj.rank3=randperm(6);
        end
        
        function valid_use=use_a_throne_token(obj,house_flag)
            if obj.current_crowns(house_flag)>0
                obj.current_crowns(house_flag)=obj.current_crowns(house_flag)-1;
                valid_use=true;
            else
                valid_use=false;
            end
        end
        
        function list_map_as_text(obj)
            %             fprintf('\n*****************************')
            
            fprintf('\n1: '), for i=1:6,    fprintf('%s ',house_index2name(obj.rank1(i))),  end
            fprintf('\n2: '), for i=1:6,    fprintf('%s ',house_index2name(obj.rank2(i))),  end
            fprintf('\n3: '), for i=1:6,    fprintf('%s ',house_index2name(obj.rank3(i))),  end
            fprintf('\n');
            for i=6:-1:1
                fprintf('\n%s: %dB %dT %d.',house_index2name(i),obj.current_barrels(i),obj.castles_occupied(i),obj.current_crowns(i))
                area_list2disp=obj.areas_of_a_house(i);
                fprintf('\n');
                for j=1:length(area_list2disp)
                    fprintf('%d[',area_list2disp(j));
                    for k=1:length(obj.map_areas(area_list2disp(j)).troops)
                        fprintf('%d',obj.map_areas(area_list2disp(j)).troops(k).type);
                    end
                    if obj.map_areas(area_list2disp(j)).throne_token>0
                        fprintf('.');
                    end
                    if obj.map_areas(area_list2disp(j)).order.marching==1
                        fprintf('(P)');
                    elseif obj.map_areas(area_list2disp(j)).order.resting==1
                        fprintf('(=)');
                    elseif obj.map_areas(area_list2disp(j)).order.supporting==1
                        fprintf('(T)');
                    elseif obj.map_areas(area_list2disp(j)).order.raiding==1
                        fprintf('(!)');
                    elseif obj.map_areas(area_list2disp(j)).order.defencing==1
                        fprintf('(D)');
                    end
                    
                    fprintf('] ');
                end
            end
            
            
            
            %             fprintf('\n*****************************')
            fprintf('\n')
        end
        
        function rec_comb=recruit_combinations(obj, index)
            rec_comb=obj.map_areas(index).recruit_combinations(obj.map_areas, obj.current_barrels);
        end
        
        function refresh_map(obj)
            for i=1:58
                if obj.map_areas(i).no_troop && obj.map_areas(i).throne_token==0
                    obj.map_areas(i).set_house_flag(is_capital(i));
                end
                obj.map_areas(i).order.clear;
            end
        end
        
        function cut_army(obj)
            for house_flag=1:6
                for i=1:58
                    if obj.map_areas(i).house_flag==house_flag
                        [validity,fault_indexs]=obj.map_areas(i).check_population(obj.map_areas, house_flag, obj.current_barrels);
                        break;
                    end
                end

                if validity==1, continue; end
                while validity==0
                    %                 disp(fault_indexs)
                    obj.map_areas(fault_indexs(1)).remove_smallest_troop;
                    [validity,fault_indexs]=obj.map_areas(i).check_population(obj.map_areas, house_flag, obj.current_barrels);
                end
            end
        end
        
        function random_local_recruit(obj,index)
            if obj.map_areas(index).house_flag==0
                return;
            end
            
            if obj.map_areas(index).towers==1
                rec_comb=obj.recruit_combinations(index);
                if isempty(rec_comb),return,end
                recruit_command=randi(size(rec_comb,1));
                recruit_command=rec_comb(recruit_command,:);
                obj.map_areas(index).recruit(obj.map_areas,recruit_command);
            elseif obj.map_areas(index).towers==2
                rec_comb=obj.recruit_combinations(index);
                if isempty(rec_comb),return,end
                recruit_command=randi(size(rec_comb,1));
                recruit_command=rec_comb(recruit_command,:);
                obj.map_areas(index).recruit(obj.map_areas,recruit_command);
                
                rec_comb=obj.recruit_combinations(index);
                if isempty(rec_comb),return,end
                recruit_command=randi(size(rec_comb,1));
                recruit_command=rec_comb(recruit_command,:);
                obj.map_areas(index).recruit(obj.map_areas,recruit_command);
            end
        end
        
        function recruit_event(obj)
            fprintf('\nRecruit Event\n');
            recruit_order=randperm(50);
            for i=1:50
                obj.random_local_recruit(recruit_order(i));
            end
        end
        
        function round_consolidation(obj)
            for i=1:58
                if obj.map_areas(i).order.resting==1
                    if obj.map_areas(i).order.star==1
                        obj.random_local_recruit(i);
                    else
                        crowns2collect=obj.map_areas(i).crowns+1;
                        obj.current_crowns(obj.map_areas(i).house_flag)=obj.current_crowns(obj.map_areas(i).house_flag)+crowns2collect;
                        if obj.current_crowns(obj.map_areas(i).house_flag)>20-obj.throne_token_on_the_map(obj.map_areas(i).house_flag)
                            obj.current_crowns(obj.map_areas(i).house_flag)=20-obj.throne_token_on_the_map(obj.map_areas(i).house_flag);
                        end
                    end
                end
            end
        end 
        
        function random_a_around(obj)
            for i=1:6
                possible_order_sites=obj.areas_of_a_house_with_troops(obj.rank1(i));
                possible_order_sites=possible_order_sites(randperm(length(possible_order_sites)));
                rand_order_array=obj.random_orders(i);
                
                for j=1:min(length(possible_order_sites),15)
                    obj.map_areas(possible_order_sites(j)).set_order(rand_order_array(j));   
                end
            end
            
            obj.list_map_as_text;
            
            for i=1:6
                possible_move_sites=[];
                for j=1:min(length(possible_order_sites),15)
                    if obj.map_areas(possible_order_sites(j)).order.marching==1
                        possible_move_sites=[possible_move_sites,possible_order_sites(j)];
                    end
                end
                
                
                for j=1:length(possible_move_sites)
                    obj.map_areas(possible_move_sites(j)).random_move_troops(obj.map_areas,obj.current_barrels)
                    if obj.map_areas(possible_move_sites(j)).no_troop ...
                                && obj.map_areas(possible_move_sites(j)).throne_token==0 ...
                                && obj.map_areas(possible_move_sites(j)).land_type==1
                        obj.map_areas(possible_move_sites(j)).put_a_throne_token(obj);
                    end
                end
            end
            
            obj.round_consolidation;
            obj.refresh_map; 
            
            
            roll=randi(5)
            if roll==5
                obj.collect_thrones_event;
            elseif roll==4
                obj.recruit_event;
            elseif roll==3
                obj.rank1=randperm(6);
                obj.rank2=randperm(6);
                obj.rank3=randperm(6);
            elseif roll==2
                obj.update_barrels;            
                obj.cut_army;
            end
           
            
            obj.list_map_as_text;
        end
        
    end
end


