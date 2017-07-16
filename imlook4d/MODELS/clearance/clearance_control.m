function clearance_control(varargin)
%
%  This model sets the handle to clearance function
%  so that clearance model is used in generateImage
%
%  Parameters are stored in imlook4d under
%   imlook4d_handles.model.Clearance.startFrame
%   imlook4d_handles.model.Clearance.endFrame
%   imlook4d_handles.model.Clearance.thresholdLevel

   disp('Entered clearance_control');
   
    %
    % INITIALIZATION of important communication between imlook4d and 
    %
        % Save link back to calling imlook4d instance
        imlook4d_handle=varargin{1};                    % Handle to imlook4d instance
        
        imlook4d_handles=guidata(imlook4d_handle);      % Handles to calling imlook4d instance (COPY OF HANDLES)

   
    %
    % USER INITIALIZATION  ( CHANGE THIS ONE )         
    %   
        imlook4d_handles.model.functionHandle=@clearance;
        

        %
        % Remember old start values, or guess first value
        %
            try ans1=num2str(imlook4d_handles.model.Clearance.startFrame)
            catch ans1=num2str(get(imlook4d_handles.FrameNumSlider,'Value'));  
            end

            try ans2=num2str(imlook4d_handles.model.Clearance.endFrame)
            catch ans2=num2str(size(imlook4d_handles.image.Cdata,4));  % Last frame
            end


            try ans3=num2str(100*imlook4d_handles.model.Clearance.thresholdLevel)
            catch ans3='30';  % Default threshold level
            end
        
        %
        % GUI dialog for clearance parameters
        %
            defaultanswer={ans1, ans2, ans3};
            prompt={'First frame', 'Last frame', 'Discard threshold (%)'};
            title='Clearance';
            numlines=1;

            answer=inputdlg(prompt,title,numlines,defaultanswer);       

        % Write values from dialog
            imlook4d_handles.model.Clearance.startFrame=str2num(answer{1});
            imlook4d_handles.model.Clearance.endFrame=str2num(answer{2});
            imlook4d_handles.model.Clearance.thresholdLevel=str2num(answer{3})/100;  % fraction instead of percent

    %
    % FINISH
    %
        guidata(imlook4d_handle,imlook4d_handles); % Export modified handles back to imlook4d
        
        % Update imlook4d image
        imlook4d('updateImage',imlook4d_handle, [], imlook4d_handles);