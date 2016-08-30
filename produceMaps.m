%mass_produce maps
ver_string='v0121';
save ver_string ver_string
for map_indexs=1:50
    testing_script
    fn=sprintf('./x3d/test/map_%s_%03d.html',ver_string,map_indexs);
    movefile('./x3d/test/themap.html',fn)
    save(sprintf('./archive/map_%s_%03d.mat',ver_string,map_indexs),'m')
end