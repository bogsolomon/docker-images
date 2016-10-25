for j = 1:numfiles
     dataSize = eval(['size(data' num2str(j) '.data, 1)']);
     try
        eval(['cpu' num2str(j) ' = data' num2str(j) '.data(1:dataSize,10)']);
        cpustat(1,j) = eval(['median(cpu' num2str(j) ')']);
        cpustat(2,j) = eval(['mean(cpu' num2str(j) ')']);
        cpustat(3,j) = eval(['std(cpu' num2str(j) ')']);
        cpustat(4,j) = eval(['mad(cpu' num2str(j) ')']);
        cpustat(5,j) = eval(['max(cpu' num2str(j) ')']);
     catch err
        disp(['Can not load cpu', num2str(j)]);
     end
    clear dataSize;
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
            eval(['plot(cpu' num2str(j+k) ')']);hold all;
            legVal = sprintf('CPU %d Users', (j+labelOffset+k));
            leg(k+1) = {legVal};
         end
    end 
    hold off;figure(gcf);
    legend(leg(1:(extraDataPerImage+1)));xlabel('Time (30s)');ylabel('CPU Usage (%)');
    outfile = sprintf('%s/cpu-%d', outDir, j);
    % print(hFig,'-dpng',outfile);
    screen2jpeg(outfile);
    j = j + 2;
%     plot(time,'latency' num2str(j) ')';hold all;plot(time,latency1);plot(time,latency2);hold off;figure(gcf);legend('Latency 5 Users','Latency 10 Users','Latency 15 Users');xlabel('time (s)');ylabel('latency (ms)');
end
end