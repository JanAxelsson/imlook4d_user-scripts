% Rearrange an MRI scanned with Sagital nose to the left
%
% Use as script in imlook4d
% Jan Axelsson 2020-10-28

StartScript

% Rearrange dimensions
A = permute( imlook4d_Cdata, [ 3 1 2]);
imlook4d_Cdata = A;
imlook4d_ROI = zeros(size(A),'uint8'); % Make empty ROI matrix

% Rearrange pixel sizes in imlook4d
im = imlook4d_current_handles.image;
imlook4d_current_handles.image.pixelSizeX = im.sliceSpacing;
imlook4d_current_handles.image.pixelSizeY = im.pixelSizeX;
imlook4d_current_handles.image.sliceSpacing = im.pixelSizeY;

% Turn axial upside-down
imlook4d_Cdata=flipdim(imlook4d_Cdata,2);
imlook4d_ROI=flipdim(imlook4d_ROI,2);

% Fix nifti header
imlook4d_current_handles.image.nii.hdr.dime.pixdim(1) = im.nii.hdr.dime.pixdim(3);
imlook4d_current_handles.image.nii.hdr.dime.pixdim(2) = im.nii.hdr.dime.pixdim(1);
imlook4d_current_handles.image.nii.hdr.dime.pixdim(3) = im.nii.hdr.dime.pixdim(2);

% Finish
EndScript
