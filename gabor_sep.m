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
function [v,h,f]=gabor_sep(bw,gamma,psi,lambda,rotflag)
nstds=3;
sigma_x=bw;
sigma_y=bw/gamma;
xmax=ceil(max(1,abs(nstds*sigma_x)));
ymax=ceil(max(1,abs(nstds*sigma_y)));
x=(-xmax):xmax;
y=(-ymax):ymax;
v=((1/sqrt(2*pi*(sigma_y^2)))*exp(-((y.^2)/(2*sigma_y*sigma_y))))';
vx=(1/sqrt(2*pi*(sigma_x^2)))*exp(-((x.^2)/(2*sigma_x*sigma_x)));
h=vx.*cos((2*pi./lambda).*(x+psi));
f=v*h;
%f=f/max(f(:));
if (rotflag>0)
    f=f';
    tmp=h';
    h=v';
    v=tmp;
end
v=v/sum(v);
h=h/sum(h);
