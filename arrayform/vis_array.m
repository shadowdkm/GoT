% figure,plot3([0,5],[0,5],[0,5],'.')
% grid
% axis image
% hold on
% plot3(randi(4,1,20)-0.5,randi(4,1,20)-0.5,randi(4,1,20)-0.5,'x')
% hold off
clc
Tr=[1;2;2;0;3;0];
Go=[0,0,0,0,0,0;
    1,1,0,0,0,0;
    0,0,1,0,0,0;
    0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1];

disp(Tr)

disp(Go*Tr)