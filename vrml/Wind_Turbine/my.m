clear
clc
mp=vrworld('./testing.wrl');
open(mp);
view(mp);

% mynode = vrnode(mp, 'sroot','Transform')
mynode = vrnode(mp.sroot, 'children',['sball' num2str(randi(1000))],'Inline');
mynode.url='hello.wrl';

for i=1:1000
mp.sroot.translation=randi(100,[1,3])/100;
mp.sroot.scale=randi(200,[1,3])/100;
pause(0.01)

end