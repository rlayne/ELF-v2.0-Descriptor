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
function cathist=gethists_specific(dat,mask,bins,maskisweights)
% Specify bins values in <bins>
if nargin~=4
    maskisweights=0;
end
cathist=zeros(1,length(bins)*size(dat,3));
mk=double(mask);
mk=mk(:);
s=1;
binlen = length(bins);
for j=1:size(dat,3)
    tmpdat=dat(:,:,j);
    tmpdat=tmpdat(:);
    if maskisweights==0
        tmpdat=tmpdat(mk>0);
    end
    
    if maskisweights==1
        % Weight the distances according to the provided mask
        %dist2 = bsxfun(@times,dist2,mk');
        dist2 = abs(pdist2(bins', tmpdat.*mk, 'cityblock'));
    else
        dist2 = abs(pdist2(bins', tmpdat, 'cityblock'));
    end
    
    [~,dpos] = min(dist2);
    ht = hist(dpos, 1:binlen);
    
    ht=ht+realmin;
    
    ht=ht/sum(ht);
    cathist(s:s+binlen-1)=ht';
    s=s+binlen;
    
    
end
