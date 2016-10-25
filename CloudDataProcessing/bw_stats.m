 for j = 1:numfiles
    dataSize = eval(['size(data', num2str(j), '.data, 1)']);
    try
        eval(['bwIn' num2str(j) ' = data' num2str(j) '.data(1:dataSize,8)']);
        eval(['bwOut' num2str(j) ' = data' num2str(j) '.data(1:dataSize,9)']);
    catch err
        disp(['Can not load bwIn', num2str(j)]);
    end
end

extraDataPerImage = 6;
leg = cell(7, 1);
leg(:) = {'test'};

if 1
hFig = figure(1);set(hFig, 'Position', [100 100 1032 444]);
j = 1;
while j <= (numfiles)
   for k = 0:extraDataPerImage
         if ((j+k) <= numfiles)
            eval(['plot(bwOut' num2str(j+k) ')']);hold all;
            legVal = sprintf('Bandwidth %d Users', (j+labelOffset+k));
            leg(k+1) = {legVal};
         end
    end 
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (30s)');ylabel('Bandwidth (Kbps)');
    outfile = sprintf('%s/bandwidth-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + extraDataPerImage;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end