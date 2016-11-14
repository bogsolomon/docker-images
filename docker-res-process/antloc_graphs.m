for j = 1:length(antLocIndices)
    if (antLocIndices(j) ~= 0)
        dataSize = eval(['size(ant', num2str(antLocIndices(j)), '.data, 1)']);
        try
            eval(['times' num2str(j) ' = ant' num2str(antLocIndices(j)) '.data(1:dataSize,1)']);
            eval(['antLoc' num2str(j) ' = ant' num2str(antLocIndices(j)) '.data(1:dataSize,2)']);
        catch err
            disp(['Can not load antLoc', num2str(antLocIndices(j))]);
        end
    end
end

extraDataPerImage = antCount -1;
leg = cell(7, 1);
leg(:) = {'test'};

if 1
hFig = figure(1);set(hFig, 'Position', [100 100 1032 444]);
j = 1;
while j <= length(antLocIndices)
   if (antLocIndices(j) == 0)
       break;
   end
   for k = 0:extraDataPerImage
         eval(['minTime = min(times' num2str(j) ')']);
         if ((j+k) <= length(antLocIndices))
            eval(['timesNew' num2str(j+k) ' = times' num2str(j+k) ' - minTime']);
            eval(['timesNew' num2str(j+k) ' = timesNew' num2str(j+k) ' / 60000']);
            eval(['plot(timesNew' num2str(j+k) ', antLoc' num2str(j+k) ')']);hold all;
            legVal = sprintf('Ant %d Location', (j+labelOffset+k));
            leg(k+1) = {legVal};
         end
   end 
    axis([0,maxTime,-1,7]);
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (m)');ylabel('Server Id');
    outfile = sprintf('%s/antLoc-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + extraDataPerImage + 1;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end