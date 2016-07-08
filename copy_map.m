% Make a copy of a handle object.
function new = copy_map(this)
    % Instantiate new object of the same class.
    new=[];
    for i=1:58
        new=[new,AREA(this(i).index, this(i).land_type, this(i).defence, this(i).crowns, this(i).barrels, this(i).towers)];
        new(i).set_house_flag(this(i).house_flag);
        for j=1:length(this(i).troops)
            new(i).add_troop(this(i).troops(j).type);
        end
    end

   
end