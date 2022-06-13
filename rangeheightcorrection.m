function [Height, H_S_Distance]=rangeheightcorrection(Elevation_Angle,max_range_gate,range_resolution)
%% Earth's curvature correction
% dr = 0.500;
Slant_Range = range_resolution:range_resolution:max_range_gate*range_resolution; % In km
% Elevation_Angle=1:0.5:90; % in Degree
a = 6378; % radius of earth (km)
ke = 4/3; % ratio of equivalent-to-real radius of the earth
cnst = ke.*a;
sin_theta_e = sin(Elevation_Angle.*pi./180);
cos_theta_e = cos(Elevation_Angle.*pi./180);

%     for i=1:length(Slant_Range)
% %         for j=1:length(Elevation_Angle)
%             Height(i,1)=((Slant_Range(i)^2)+((ke*a)^2)+...
%                         (2*Slant_Range(i)*ke*a*sin_theta_e)).^(1/2)-ke*a + 289.3977/1000;
%             H_S_Distance(i,1)= cnst*asin((Slant_Range(i)*cos_theta_e)...
%                                 /(cnst+Height(i)));
% %         Radius(i,j)=Slant_Range(i).*cos(Elevation_Angle(j).*pi/180);
% %         end
%     end
    
    for i=1:length(Slant_Range)
        for j=1:length(Elevation_Angle)
            Height(i,j)=((Slant_Range(i)^2)+((ke.*a)^2)+...
                        (2.*Slant_Range(i).*ke.*a.*sin_theta_e(j))).^(1/2)-ke.*a + 289.3977/1000;
            H_S_Distance(i,j)= cnst.*asin((Slant_Range(i).*cos_theta_e(j))...
                                /(cnst+Height(i,j)));
%         Radius(i,j)=Slant_Range(i).*cos(Elevation_Angle(j).*pi/180);
        end
    end
% clear i j cnst a cos_theta_e ke sin_theta_e
end