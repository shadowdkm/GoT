%mass_produce maps

for map_indexs=1:15
    testing_script
    fn=sprintf('./x3d/test/map%02d.html',map_indexs);
    movefile('./x3d/test/themap.html',fn)
end