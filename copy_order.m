function new=copy_order(this)
    new = MARCH_ORDER(this.house_flag,this.area_index);
    for i=1:length(this.element_array)
        new.add_element(this.element_array(i).target,this.element_array(i).troop_type_array);
    end
end