StartScript

WindowTitle('RI --','prepend');

integrationRange=1:16;  % Area under curve in this interval
summingRange=15:17;     % Sum image over this interval

ExportROIs

roiNumber = imlook4d_ROI_number;  % Current ROI


inputFunction = imlook4d_ROI_data.mean(integrationRange,roiNumber)';

midtimes = imlook4d_ROI_data.midtime(integrationRange)'
durations = imlook4d_ROI_data.duration(integrationRange)'

%trapz(midtimes, inputFunction)
AUC = sum( inputFunction .* durations);

% Retention Index 1/min
imlook4d_Cdata = 60 * sum( imlook4d_Cdata(:,:,:,summingRange) , 4 ) / AUC ;

% Print times to sum over
disp(' ');
disp(['Reference ROI = '  imlook4d_ROINames{ roiNumber } ]);

disp(['Frame range for AUC = ' num2str(integrationRange(1)) ' to ' num2str(integrationRange(end)) ]);
disp(['Time  range for AUC  = ' ... 
    num2str( imlook4d_ROI_data.midtime(integrationRange(1)) - 0.5*imlook4d_ROI_data.duration(integrationRange(1) )) ... 
    ' to ' ... 
    num2str(imlook4d_ROI_data.midtime(integrationRange(end)) + 0.5*imlook4d_ROI_data.duration(integrationRange(end) )) ]);


disp(['Frame range for mean = ' num2str(summingRange(1)) ' to ' num2str(summingRange(end)) ]);
disp(['Time  range for mean  = ' ... 
    num2str( imlook4d_ROI_data.midtime(summingRange(1)) - 0.5*imlook4d_ROI_data.duration(summingRange(1) )) ... 
    ' to ' ... 
    num2str(imlook4d_ROI_data.midtime(summingRange(end)) + 0.5*imlook4d_ROI_data.duration(summingRange(end) )) ]);

EndScript

