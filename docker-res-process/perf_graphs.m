for j = 1:length(perfIndices)
    if (perfIndices(j) ~= 0)
        dataSize = eval(['size(serverPerf', num2str(perfIndices(j)), '.data, 1)']);
        try
            eval(['times' num2str(j) ' = serverPerf' num2str(perfIndices(j)) '.data(1:dataSize,1)']);
            eval(['cpu' num2str(j) ' = serverPerf' num2str(perfIndices(j)) '.data(1:dataSize,2) * factor']);
            eval(['cpu' num2str(j) ' = min(cpu' num2str(j) ', 100 )' ]);
            eval(['lat' num2str(j) ' = serverPerf' num2str(perfIndices(j)) '.data(1:dataSize,7) * factor']);
            eval(['lat' num2str(j) ' = min(lat' num2str(j) ', 400 )' ]);
            eval(['bwUp' num2str(j) ' = serverPerf' num2str(perfIndices(j)) '.data(1:dataSize,11) * factor']);
            eval(['bwDown' num2str(j) ' = serverPerf' num2str(perfIndices(j)) '.data(1:dataSize,10) * factor']);
        catch err
            disp(['Can not load serverPerf', num2str(perfIndices(j))]);
        end
    end
end

extraDataPerImage = antCount -1;
leg = cell(7, 1);
leg(:) = {'test'};
bwleg = cell(7, 1);
bwleg(:) = {'test'};
bwupleg = cell(7, 1);
bwupleg(:) = {'test'};
latleg = cell(7, 1);
latleg(:) = {'test'};

if 1
hFig = figure(1);set(hFig, 'Position', [100 100 1032 777]);
j = 1;
while j <= length(perfIndices)
   if (perfIndices(j) == 0)
       break;
   end
   for k = 0:extraDataPerImage
         eval(['minTime = min(times' num2str(j) ')']);
         if ((j+k) <= length(perfIndices))
            eval(['timesNew' num2str(j+k) ' = times' num2str(j+k) ' - minTime']);
            eval(['timesNew' num2str(j+k) ' = timesNew' num2str(j+k) ' / 60000']);
            subplot(4,1,1)
            eval(['plot(timesNew' num2str(j+k) ', cpu' num2str(j+k) ')']);hold all;
            legVal = sprintf('Server %d CPU', (j+labelOffset+k));
            leg(k+1) = {legVal};
            subplot(4,1,2)
            eval(['plot(timesNew' num2str(j+k) ', bwUp' num2str(j+k) ')']);hold all;
            legVal = sprintf('Server %d Bandwith Up', (j+labelOffset+k));
            bwleg(k+1) = {legVal};
            subplot(4,1,3)
            eval(['plot(timesNew' num2str(j+k) ', bwDown' num2str(j+k) ')']);hold all;
            legVal = sprintf('Server %d Bandwith Down', (j+labelOffset+k));
            bwupleg(k+1) = {legVal};
            subplot(4,1,4)
            eval(['plot(timesNew' num2str(j+k) ', lat' num2str(j+k) ')']);hold all;
            legVal = sprintf('Server %d Latency', (j+labelOffset+k));
            latleg(k+1) = {legVal};
         end
   end 
    subplot(4,1,1)
    axis([0,maxTime,-inf,inf]);
    subplot(4,1,2)
    axis([0,maxTime,-inf,inf]);
    subplot(4,1,3)
    axis([0,maxTime,-inf,inf]);
    subplot(4,1,4)
    axis([0,maxTime,-inf,inf]);
    hold off;figure(gcf);
    subplot(4,1,1)
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (m)');ylabel('CPU (%)');
    subplot(4,1,2)
    legend(bwleg(1:(extraDataPerImage+1)));xlabel('Time (m)');ylabel('Bandwidth Up (kbps)');
    subplot(4,1,3)
    legend(bwupleg(1:(extraDataPerImage+1)));xlabel('Time (m)');ylabel('Bandwidth Down (kbps)');
    subplot(4,1,4)
    legend(latleg(1:(extraDataPerImage+1)));xlabel('Time (m)');ylabel('Latency (ms)');
    outfile = sprintf('%s/perf-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + extraDataPerImage + 1;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end