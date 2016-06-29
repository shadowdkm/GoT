load map
close all
imshow(map)
theta=0:360;
rx=cosd(theta);
ry=sind(theta);
totalAreasNumber=58;
%% find locations
i=1;
hold on

locationArray=[];
while i<=totalAreasNumber
    [lx,ly]=ginput(1);
    text(lx,ly,sprintf('%d',i),'BackgroundColor',[1,1,1])
    plot(lx+70*rx,ly+70*ry,'w')
    locationArray=[locationArray,[lx;ly]];       
    i=i+1;
end
hold off
save locationArray
%% find connections
clc
connections=[]; 
connections(totalAreasNumber).elems=[];
i=1;
cbutton=1;
while i<=totalAreasNumber
    imshow(map),hold on
    subindexes=1:totalAreasNumber;
    subindexes(i)=[];
    for j=subindexes
        plot(locationArray(1,j)+70*rx,locationArray(2,j)+70*ry,'y')
    end    
    plot(locationArray(1,i)+70*rx,locationArray(2,i)+70*ry,'w','linewidth',4)
    while cbutton==1
        [cx,cy,cbutton]=ginput(1);
        ind=find(locationArray(1,:)+70>cx & locationArray(1,:)-70<cx & locationArray(2,:)+70>cy & locationArray(2,:)-70<cy)
        
        if length(ind)~=1
            disp('Failed connecting areas')
            continue;
        end
        plot([locationArray(1,i),locationArray(1,ind)],[locationArray(2,i),locationArray(2,ind)],'w:','linewidth',4)
        plot(locationArray(1,ind)+40*rx,locationArray(2,ind)+40*ry,'w:','linewidth',4)
        connections(i).elems=[connections(i).elems,ind];
    end
    cbutton=1;
    hold off
    i=i+1;
    
end
save connections

%%
clc
clf
imshow(map),hold on
for i=1:58
    plot(locationArray(1,i)+50*rx,locationArray(2,i)+50*ry,'y','linewidth',4)
    
    for j=1:length(connections(i).elems)
        plot([locationArray(1,i),locationArray(1,connections(i).elems(j))],[locationArray(2,i),locationArray(2,connections(i).elems(j))],'w:','linewidth',2)
    end
    text(locationArray(1,i),locationArray(2,i),sprintf('%d',i),'BackgroundColor',[1,1,1])
end
hold off