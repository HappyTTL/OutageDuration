clear all;
close all;
rng('shuffle')
array_id = getenv('PBS_ARRAYID');
if isempty(array_id)
    array_id = '0';
end

field_id = str2num(array_id);
mobilityparameter=struct('MODEL_NAME','RWP', 'SPEED_INTERVAL', [1 10], 'PAUSE_INTERVAL',[0 60],'TOPOLOGY_UPDATE_TIME',0.5,'CHANNEL_UPDATE_TIME',10);
%number of randomly moved node:
global numnode;
global mobilityvector;
global mobilityvectortimer;
global XY;
global nodespeed;
numnode = 1;
%length of path
global simlength;
simlength = 11000;
%cell size
topologysize = 1000;
MOBILITY=true;
XY = nodeplacement(numnode, topologysize);
mobilityvector=zeros(numnode,2);
mobilityvectortimer=zeros(numnode,1);
nodespeed = zeros(numnode);
traces = zeros(2, simlength);
for i=1:simlength
%     disp(mobilityvector);
    XY=updatenodelocation(topologysize,mobilityparameter);
    traces(:,i) = XY;
    
end
filename = ['dat/traces/ID' num2str(field_id) '.mat'];
save(filename, 'traces');