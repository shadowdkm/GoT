world=vrworld('wind_turbine.wrl', 'new');
open(world);
fig=vrfigure(world);

blades_1=vrnode(world, 'Blades_1');
blades_2=vrnode(world, 'Blades_2');
blades_3=vrnode(world, 'Blades_3');
blades_4=vrnode(world, 'Blades_4');

phase_1=0;
phase_2=pi/3;
phase_3=pi/6;

for theta=0:0.1:12*pi
    pause(0.01)
    blades_1.rotation=[0 0 1 phase_1-theta];
    blades_2.rotation=[0 0 1 phase_2-theta];
    blades_3.rotation=[0 0 1 phase_3+theta];
    vrdrawnow;
end