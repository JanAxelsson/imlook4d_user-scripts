pveFactors = [];
StoreVariables;
ExportUntouched;

%
% Dialog
%
name = 'FWHM';
prompt={'FWHM x [mm] ', 'FWHM y [mm] ', 'FWHM z [mm] '};
[answer, imlook4d_current_handles] = ModelDialog( imlook4d_current_handles, ...
    name, ...
    prompt, ...
    { num2str(imlook4d_frame), num2str( size(imlook4d_Cdata,4) ), '' } ...
    );

%fwhm_mm = [ 3.59, 3.40, 4.32];
fwhm_mm(1) = str2num( answer{1});
fwhm_mm(2) = str2num( answer{2});
fwhm_mm(3) = str2num(answer{3});

disp( [ 'FWHM = ' num2str(fwhm_mm) '  [mm]' ]);

%
% Calculate PVE factors
%


vox = voxel_size(imlook4d_current_handles);
sigma_pixels  = pixels( fwhm_mm, vox)  / 2.35;
disp( [ 'FWHM = ' num2str(sigma_pixels) '  [pixels]' ]);

measTACT = tactFromMatrix(imlook4d_Cdata,imlook4d_ROI)';
pveFactors = pveWeights( imlook4d_ROI, sigma_pixels);

ClearVariables;
