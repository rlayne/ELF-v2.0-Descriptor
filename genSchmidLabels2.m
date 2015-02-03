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
function labelsSchmid = genSchmidLabels2(im,sigma,tau)
[v,h,f,filter,sd,rk]=schmid_sep(sigma,tau);
im=double(rgb2gray(im))/255;
labelsSchmid=zeros(size(im,1),size(im,2),'double');
for k=1:size(v,2)
    vt=v(:,k);
    ht=h(k,:);
    labelsSchmid=labelsSchmid+conv2(conv2(im,vt,'same'),ht,'same');
end
