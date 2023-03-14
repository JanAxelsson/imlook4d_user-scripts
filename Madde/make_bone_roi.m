% make_bone_roi.m
%
% This imlook4d script is used to auto-segment cortical bone in a standardized way,
% avoiding to include the epiphys
%
% INSTRUCTIONS FOR ROIs
%
% Make two small circular rois for the top and bottom cleft according to
% image :
%
%                   L = total length between "top" and "bottom" rois
%   
%         a = first ROI called "top" (in deepest cleft)
%      __   __
%     /  \a/  \
%    |         |    Proximal epiphys
%     \        /
%      \      /
%       |    |   ----
%       |    |     |
%       |    |     |    L * FRACTIONAL_LENGTH_HIGH ( FRACTIONAL_LENGTH_HIGH = 0.5 is all the way to "top" (a) )
%       |    |     |
%       |    |   ---- mid point
%       |    |     |
%       |    |     |    L * FRACTIONAL_LENGTH_LOW ( FRACTIONAL_LENGTH_LOW = 0.5 is all the way to "bottom" (b) )
%       |    |     |
%       |    |   ---- 
%       |  b |  
%       | | \/     Distal ephiphys
%       \/   
%                    
%            b = second ROI called "bottom" (in deepest cleft)
%
%
% RUN
% 
% Run this script:
%
% 

% User defined
FRACTIONAL_LENGTH_HIGH = 0.30;
FRACTIONAL_LENGTH_LOW  = 0.35;


% Start script
StoreVariables
Export

% Identify middle vector
SelectOrientation('Ax');
ROI_data_to_workspace;

top = imlook4d_ROI_data.centroid{1};
bottom = imlook4d_ROI_data.centroid{2};

% reverse if wrong order
if ( top.z < bottom.z) 
    temp = top;
    top = bottom;
    bottom = temp;

    temp = FRACTIONAL_LENGTH_LOW;
    FRACTIONAL_LENGTH_LOW = FRACTIONAL_LENGTH_HIGH;
    FRACTIONAL_LENGTH_HIGH = temp;
end


len = [ top.x - bottom.x, top.y - bottom.y, top.z - bottom.z ];  % Length vector
start = [ bottom.x , bottom.y , bottom.z ];  % Start position

mid = start + 0.5 * len;   % Middle

% New ROI
INPUTS = Parameters( {'SearchVolume'} );
MakeROI

[sx, sy, sz ] = size(imlook4d_ROI);
midz = round(mid(3));
lowz = midz - round( FRACTIONAL_LENGTH_LOW * len(3) )
highz = midz + round( FRACTIONAL_LENGTH_HIGH * len(3) )

INPUTS = Parameters( {'100%', '2000', num2str(lowz), num2str(highz), '3'} );
Threshold_ROI

% End script
Import
ClearVariables


% Make final orientation
SelectOrientation('Cor');