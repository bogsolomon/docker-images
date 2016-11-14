for j = 1:length(antIndices)
    if (antIndices(j) ~= 0)
        dataSize = eval(['size(serverAnt', num2str(antIndices(j)), '.data, 1)']);
        try
            eval(['times' num2str(j) ' = serverAnt' num2str(antIndices(j)) '.data(1:dataSize,1)']);
            eval(['pheromone' num2str(j) ' = serverAnt' num2str(antIndices(j)) '.data(1:dataSize,2)']);
        catch err
            disp(['Can not load serverAnt', num2str(antIndices(j))]);
        end
    end
end

extraDataPerImage = antCount - 1;
leg = cell(7, 1);
leg(:) = {'test'};

if 1
hFig = figure(1);set(hFig, 'Position', [100 100 1032 444]);
j = 1;
while j <= length(antIndices)
   if (antIndices(j) == 0)
       break;
   end
   for k = 0:extraDataPerImage
         eval(['minTime = min(times' num2str(j) ')']);
         if ((j+k) <= length(antIndices))
            eval(['timesNew' num2str(j+k) ' = times' num2str(j+k) ' - minTime']);
            eval(['timesNew' num2str(j+k) ' = timesNew' num2str(j+k) ' / 60000']);
            eval(['plot(timesNew' num2str(j+k) ', pheromone' num2str(j+k) ')']);hold all;
            legVal = sprintf('Server %d Ant %d Pheromone', (j - 1) / antCount + 1, k + 1);
            leg(k+1) = {legVal};
         end
   end 
    hline = refline(0, 25);
    set(hline,'LineStyle',':')
    set(hline,'Color','r')
    hline = refline(0, 60);
    set(hline,'LineStyle',':');
    set(hline,'Color','r');
    hline = refline(0, 42.5);
    set(hline,'LineStyle',':');
    set(hline,'Color','b');
    axis([0,maxTime,10,70]);
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (m)');ylabel('Pheromone Level');
    outfile = sprintf('%s/ant-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + extraDataPerImage + 1;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end