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
function desc=genDescriptor(imseg,chans,bins,strips,mask)
% genDescriptor creates an ELF descriptor vector from an image
% using, in order, channels RGB, HS, YCrCb, Gabor, Schmid features
% 
% Example usage for all 5 channels, 16 bins per channel, 6 horiz strips
% and no binary mask or real-valued weight matrix:
% 
% descriptor = genDescriptor(imseg,chans,bins,strips, mask); 
% descriptor = genDescriptor(imseg,[1 1 1 1 1],[16 16 16 16 16],6,[]); 
% descriptor: a 1xn vector of normalised marginal histograms of features
% imseg     : m x n x 3 uint8 image 
% chans     : 1 x 5 binary vector indicating which features to extract
% bins      : 1 x 5 vector indicating how many bins to use for each channel
% strips    : integer, how many horizontal strips to divide the image into
% mask      : m x n binary mask OR m x n real-valued matrix of pixel weightings.
% 
% Changelog
% 02022015: Added a form of histogram weighting 
% 01022015: General tidy
% 01052013: Optimisations, histogram functions, speed
% 
sts=load('RANGEFINAL.mat');
mnx=sts.minfinal;
mxx=sts.maxfinal;
clear sts;
if (isempty(mask)) % If no mask provided, use all pixels
    mask = ones(size(imseg,1),size(imseg,2),'double');
end
maskisweights = 0; % Check if the mask is actually a weighting
if and( numel(unique(mask(:)))>2 , or(isa(mask,'double'),isa(mask,'single')) )
    maskisweights = 1;
end
% Number of histograms per feature, useful for calculating destination length
featlens=[3 2 3 8 13]; 
dlen = ((featlens.*chans)*bins')*strips; % such as this, for e.g.
desc=zeros(1,dlen);
jump=round(size(imseg,1)/strips);
gb=[struct('v',[2,0.3,0,4,0])  % Gabor filter parameters
    struct('v',[2,0.3,0,8,0]) 
    struct('v',[1,0.4,0,4,0]) 
    struct('v',[1,0.4,0,8,0]) 
    struct('v',[2,0.3,0,4,pi./2]) 
    struct('v',[2,0.3,0,8,pi./2]) 
    struct('v',[1,0.3,0,4,pi./2]) 
    struct('v',[1,0.3,0,8,pi./2])];
sc1=[2 4 4 6 6 6 8 8 8 10 10 10 10]; % Schmid parameters
sc2=[1 1 2 1 2 3 1 2 3 1 2 3 4];
pos=1; cpos=1;
for k=1:strips
    section=imseg(pos:min(pos+jump-1,size(imseg,1)),:,:); % Image strip
    msec   = mask(pos:min(pos+jump-1,size(mask,1)),:,:); % Mask strip
 
    if (chans(1))
        rg = get_range(0,1,bins(1));
        dat=genRGBLabels2(section);
        tmp=gethists_specific(dat,msec,rg,maskisweights);
        tl=length(tmp);
        desc(cpos:cpos+tl-1)=tmp;
        cpos=cpos+tl;
    end
    
    if (chans(2))
        rg = get_range(0,1,bins(2));
        dat=genHSLabels2(section);
        tmp=gethists_specific(dat,msec,rg,maskisweights);
        tl=length(tmp);
        desc(cpos:cpos+tl-1)=tmp;
        cpos=cpos+tl;
    end
    
    if (chans(3))
        rg = get_range(0,1,bins(3));
        dat=genYCCLabels2(section);
        tmp=gethists_specific(dat,msec,rg,maskisweights);
        tl=length(tmp);
        desc(cpos:cpos+tl-1)=tmp;
        cpos=cpos+tl;
    end
    
    if (chans(4))
        for j=1:8
            rg = get_range(mnx(j),mxx(j),bins(4));
            dat=genGaborLabels2(section,gb(j).v);
            tmp=gethists_specific(dat,msec,rg,maskisweights);
            tl=length(tmp);
            desc(cpos:cpos+tl-1)=tmp;
            cpos=cpos+tl;
        end
    end
    
    if (chans(5))
        for j=1:13
            rg = get_range(mnx(j+8),mxx(j+8),bins(5));
            dat=genSchmidLabels2(section,sc1(j),sc2(j));
            tmp=gethists_specific(dat,msec,rg,maskisweights);
            tl=length(tmp);
            desc(cpos:cpos+tl-1)=tmp;
            cpos=cpos+tl;
        end
    end
    
    pos=pos+jump;
    
end
    function rg = get_range(mnv,mxv,numb)
        
        ct=(mxv-mnv)/numb;
        rg = (mnv+(ct/2)):ct:mxv;
        
    end
end
