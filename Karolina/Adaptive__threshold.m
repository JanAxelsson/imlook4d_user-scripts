
%Adaptive tröskning
StartScript
I = imlook4d_Cdata;
T = adaptthresh(I, 0.2);
ADAPTIVEMASK = imbinarize(I,T); %mask adaptive tröskel

%Nolla allt utanför grov_roi:en

PET_GROV_MASK = (imlook4d_ROI == imlook4d_ROI_number); %integers blir logiska nu

MASK_OVERLAP2 = (PET_GROV_MASK & ADAPTIVEMASK);
imlook4d_ROI(PET_GROV_MASK) = 0; % Make Grovmask empty
imlook4d_ROI(MASK_OVERLAP2) = imlook4d_ROI_number;

Import

%imlook4d(MASK_OVERLAP2) 
%WindowTitle('MASK_OVERLAP2');

%imlook4d_Cdata = imlook4d_Cdata -5000;
EndScript

