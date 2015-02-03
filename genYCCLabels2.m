%-------------------------------------------------------------------------------
%- CPYRGT1: (c) 2015 Vision Group, Queen Mary University of London
%- CPYRGT2: (c) 2015 Vision Semantics Ltd.
%-
%- C.AUTHR: Ryan Layne, <r.d.c.layne [at] qmul.ac.uk>
%- LICENSE: Academic use only, no commercial usage without direct consent from 
%-          the authors.
%- WEBSITE: http://qml.io/rlayne
%-
%- CITEPRE: Please cite the following papers if you use this code in your 
%-          research:
%- CITATN1: Layne, R., Hospedales, T. M., & Gong, S. (2012). Person 
%-          Re-identification by Attributes. British Machine Vision Conference.  
%-          Surrey, England.
%- CITATN2: Gray, D., & Tao, H. (2008). Viewpoint invariant pedestrian 
%-          recognition with an ensemble of localized features. European 
%-          Conference on Computer Vision. Marseille, France. 
%-------------------------------------------------------------------------------
function labelsYCC = genYCCLabels2(input_img)
% Same as OpenCV implementation
delta=128; % Since input is 8 bit
img=double(input_img);
labelsYCC = zeros(size(input_img));
labelsYCC(:,:,1) = 0.299*img(:,:,1) + 0.587*img(:,:,2) + 0.114*img(:,:,3);
labelsYCC(:,:,2) = (img(:,:,1)-labelsYCC(:,:,1))*0.713 + delta;
labelsYCC(:,:,3) = (img(:,:,3)-labelsYCC(:,:,1))*0.564 + delta;
labelsYCC = labelsYCC/255;
