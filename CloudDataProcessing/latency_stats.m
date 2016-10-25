for j = 1:numfiles
    dataSize = eval(['size(data', num2str(j), '.data, 1)']);
    try
        latencystat(1,j) = eval(['median(data', num2str(j), '.data(1:dataSize,7))']);
        latencystat(2,j) = eval(['mean(data' num2str(j) '.data(1:dataSize,7))']);
        latencystat(3,j) = eval(['std(data' num2str(j) '.data(1:dataSize,7))']);
        latencystat(4,j) = eval(['mad(data' num2str(j) '.data(1:dataSize,7))']);
        latencystat(5,j) = eval(['max(data' num2str(j) '.data(1:dataSize,7))']);
        eval(['latency' num2str(j) ' = data' num2str(j) '.data(1:dataSize,7)']);
    catch err
        disp(['Can not load latency', num2str(j)]);
    end
    clear dataSize
end

if 1
extraDataPerImage = 2;
leg = cell(3, 1);
leg(:) = {'test'}; 
    
hFig = figure(1);set(hFig, 'Position', [100 100 1032 444]);
j = 1;
while j <= (numfiles)
    for k = 0:extraDataPerImage
         if ((j+k) <= numfiles)
            eval(['plot(latency' num2str(j+k) ')']);hold all;
            legVal = sprintf('Latency %d Users', (j+labelOffset+k));
            leg(k+1) = {legVal};
         end
    end 
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (30s)');ylabel('Latency (ms)');
    outfile = sprintf('%s/latency-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + 2;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end