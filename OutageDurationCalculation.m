clear all;
clc;

BSDen = [3 5 10 15 20 30 40 50 100 200 300 500 1000];
DeCorrDis = [20 100 200];
SINRthreshold = 0;
for j = 1 : length(BSDen)
    for m = 1 : length(DeCorrDis)
        OnOff = zeros(1,2);
        for i = 1:1000
            fileName = sprintf('/Users/tingtinglu/Desktop/HPCData/OutageDuration/DeCorr%d/NBSINR/Max_SINR_Tx40BS%dExp%dID%d.mat', DeCorrDis(m), BSDen(j), DeCorrDis(m), i);
            if exist(fileName, 'file')
                load(fileName);
                NB_SINR(find(NB_SINR >= SINRthreshold)) = 1;
                NB_SINR(find(NB_SINR < SINRthreshold)) = 0;
                [indicator, len, BI] = RunLength(NB_SINR);
                OnOff = [OnOff; indicator len'];
            end
        end
        A = size(OnOff);
        OutagePeriod = OnOff(2:A(1),:);
        filename = ['/Users/tingtinglu/Desktop/HPCData/OutageDuration/Tx_40_NB_OutageDuration_BS' num2str(BSDen(j)) '_RWP_DeCorr' num2str(DeCorrDis(m)) '.mat'];
        save(filename, 'OutagePeriod');
    end
    
end