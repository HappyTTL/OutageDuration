clear all;
clc;

BSDen = [10 30 100 300 500 1000];
DeCorrDis = [20 100 200];
SINRthreshold = 0;

for m = 1 : length(DeCorrDis)
    figure(m);
    for j = 1 : length(BSDen)
            fileName = sprintf('/Users/tingtinglu/Desktop/HPCData/OutageDuration/Tx_40_NB_OutageDuration_BS%d_RWP_DeCorr%d.mat', BSDen(j), DeCorrDis(m));
            if exist(fileName, 'file')
                load(fileName);
                Outage = OutagePeriod(find(OutagePeriod(:,1) == 0), 2);
                len = length(Outage);
                display(BSDen);
                display(sum(Outage));
                display(length(Outage(find(Outage >= 1000)))/len);
                cdfplot(Outage);
                hold on;
            end
    end
    title('Outage Duration');
    xlabel('Outage Duration (OD) (0.5s)');
    ylabel('CDF of OD');
    set(gca, 'FontSize', 20);
    set(gca, 'YGrid', 'on');
end