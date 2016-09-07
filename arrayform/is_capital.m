function house_flag=is_capital(index)
    capitals=[13,23,27,37,41,47];
    house_flag=find(index==capitals);
    if isempty(house_flag)
        house_flag=0;
    end
        
end