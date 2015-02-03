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
function [v,h,f,filter,sd,rk]=schmid_sep(sigma,tau)
[x,y] = meshgrid(-10:10,-10:10);
sh = cos((2.*pi.*tau.*sqrt((x.^2)+(y.^2)))./sigma).*exp(-((x.^2)+(y.^2))./(2.*(sigma.^2)));
sh = sh ./ sum(sum(sh));
filter = sh - (sum(sum(sh)) ./ (21.*21)); % Original 2D filter
%filter=filter/sum(filter(:));
rk=rank(filter);
%fprintf('Rank of filter is %d\n',rk);
[U,S,V] = svd(filter);
sd=diag(S); % Singular values
S2=S;
S2(S2<max(sd))=0; % Retain only highest value
f=U*S2*V'; % Reconstruct 2D filter given highest singular value only
v=[];
h=[];
for k=1:rk;
    v = [v U(:,k)*sqrt(S(k,k))]; % Vertical and horizontal separable vectors for 2D filter
    h = [h;V(:,k)'*sqrt(S(k,k))];
end
sd=sd(1:length(sd));
