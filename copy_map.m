% Make a copy of a handle object.
function new = copy_map(this)
    % Instantiate new object of the same class.
    new=[];
    for i=1:58
        new=[new,AREA(this(i).index, this(i).land_type, this(i).defence, this(i).crowns, this(i).barrels, this(i).towers)];
    end

   
end