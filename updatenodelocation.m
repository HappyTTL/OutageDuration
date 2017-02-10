function XY=updatenodelocation(topologysize,mobilityparameter)
global numnode;
global XY; %Coordinates of nodes
global mobilityvector; %Distance moved per topology update
global mobilityvectortimer; %Counting when the current mobility vector should expire
global nodespeed;
XY=XY+mobilityvector;

mobilityvectortimer=mobilityvectortimer-1;

stationarynode=(mobilityvector(:,1)==0)&(mobilityvector(:,2)==0);
newpatternnode=(mobilityvectortimer<=0);
linearindex=1:numnode;

for i=linearindex(newpatternnode)
    
    waypointradius=sqrt(rand)*topologysize;
    waypointangle=2*pi*rand;
    waypointXY(1)=waypointradius*sin(waypointangle);
    waypointXY(2)=waypointradius*cos(waypointangle);
    movedirectionXY=waypointXY-XY(i,:);
    
    
    %If the original state is stationary, change to mobile
    if (stationarynode(i)==1)
        nodespeed(i)=unifrnd(mobilityparameter.SPEED_INTERVAL(1),mobilityparameter.SPEED_INTERVAL(2));
        nodemoveduration=floor( sqrt(movedirectionXY(1)^2+movedirectionXY(2)^2)/(nodespeed(i)*mobilityparameter.TOPOLOGY_UPDATE_TIME)); %In number of updates
        mobilityvector(i,:)=movedirectionXY/nodemoveduration;
        mobilityvectortimer(i)=nodemoveduration;
    else
        %If the original state is mobile, change to stationary
        mobilityvector(i,:)=[0 0];
        mobilityvectortimer(i)=floor(unifrnd(mobilityparameter.PAUSE_INTERVAL(1),mobilityparameter.PAUSE_INTERVAL(2)) / mobilityparameter.TOPOLOGY_UPDATE_TIME);
    end

end