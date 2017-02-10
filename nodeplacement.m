function XY=nodeplacement(numnode, topologysize)
% %This function is used to generates the coordinates of nodes
% numnode = 10;
% topologysize = 1000;
for j=1:numnode
    r=sqrt(rand)*topologysize;
    angle=2*pi*rand;
    XY(j,1)=r*sin(angle);
    XY(j,2)=r*cos(angle);
end
% plot(XY(:,1), XY(:,2));

% for j = 1 : numnode
%     flag = true;
%     while flag
%         x1 = rand;
%         x2 = rand;
%         y1 = rand;
%         y2 = rand;
%         r = sqrt((x2 - x1)^2 + (y2 - y1)^2)/sqrt(2);
%         u1 = rand;
%         if u1 < r
%             flag = false;
%         end
%     end
%     u2 = rand;
%     XY(j, 1) = (u1 * x1 + (1 - u2) * x2) * topologysize;
%     XY(j, 2) = (u2 * y1 + (1 - u2) * y2) * topologysize;
% end
     
    