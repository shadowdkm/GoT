clear
clc
mp=vrworld('./testing.wrl');
open(mp);
view(mp);

% mynode = vrnode(mp, 'sroot','Transform');

for i=1:10
mynode = vrnode(mp.sroot, 'children',['sball' num2str(randi(1000))],'Inline');
mynode.url='axis_simple.x3d';    
    
mp.sroot.translation=randi(100,[1,3])/20;
mp.sroot.scale=randi(200,[1,3])/100;
pause(0.01)

end

save(mp,'addedball.x3d')

close(mp)

