%mass_produce maps

for map_indexs=1:200
    testing_script
    fn=sprintf('./x3d/test/map_v01_%03d.html',map_indexs);
    movefile('./x3d/test/themap.html',fn)
end