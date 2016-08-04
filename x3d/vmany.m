load stormdata
load ../locationArray
%%
mapoffset=[2972,1489]/2;
figure(9527)
clf,hold on
lx=lx/100;
ly=ly/100;
lz=lz/100;
for i=1:58
    X = [lx+locationArray(1,i)-mapoffset(1);ly+locationArray(2,i)-mapoffset(2);lz-30]';
    [K,V] = convhulln(X);
    % trisurf(K,X(:,1),X(:,2),X(:,3),[1:length(lx)])
    color=rand(1,3)/2+[1,1,1]/2;
    patch('Faces',K,'Vertices',X,...
             'FaceColor',       color, ...
             'EdgeColor',       color,        ...
             'FaceLighting',    'gouraud',     ...
             'AmbientStrength', 0.15);  
end
     %%

I = imread('map.png');
surface('XData',[-mapoffset(1) mapoffset(1); -mapoffset(1) mapoffset(1)],'YData',[-mapoffset(2) -mapoffset(2); mapoffset(2) mapoffset(2)],...
        'ZData',[-30 -30; -30 -30],'CData',flipdim(I,1),...
        'FaceColor','texturemap','EdgeColor','none','FaceLighting','flat',     ...
         'AmbientStrength', 1);
hold off

%%
figure2xhtml('test/example85',figure(9527),struct('embedimages',true))

% close