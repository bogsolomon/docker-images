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

extraDataPerImage = 2;
leg = cell(7, 1);
leg(:) = {'test'};

if 1
hFig = figure(1);set(hFig, 'Position', [100 100 1032 444]);
j = 1;
while j <= length(antIndices)
   for k = 0:extraDataPerImage
         if ((j+k) <= length(antIndices))
            eval(['plot(times' num2str(j+k) ', pheromone' num2str(j+k) ')']);hold all;
            legVal = sprintf('Ant %d Pheromone', (j+labelOffset+k));
            leg(k+1) = {legVal};
         end
    end 
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time');ylabel('Pheromone Level');
    outfile = sprintf('%s/bandwidth-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + extraDataPerImage;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end