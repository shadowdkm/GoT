figure(9527)
clf,hold on
lx=[0,0,0,0,0,0;
    2,2,0,-2,-2,2;
    2,2,0,-2,-2,2;
    0,0,0,0,0,0];
ly=[0,0,0,0,0,0;
    2,-1.5,-2.5,-1.5,2,2;
    2,-1.5,-2.5,-1.5,2,2;
    0,0,0,0,0,0];
lz=[1,1,1,1,1,1;
    1,1,1,1,1,1;
    0,0,0,0,0,0;
    0,0,0,0,0,0];

surf(lx,ly,lz)  

camlight('headlight');
material('dull');

% Fix the axes scaling, and set a nice view angle
axis('image');
view([-135 35]);