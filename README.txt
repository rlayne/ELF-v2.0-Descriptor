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

Usage:
The entrypoint for this code is the function genDescriptor.  Please edit the function for usage instruction and assistance with parameters.

Context:
This code package is a proximal implementation of Gray and Tao's ELF descriptor, and the code has been upgraded a bit here and there over time to support masking and improve computational efficiency.  

Currently, the code supports extraction from uint8 class images only.  Non-integer classes are not supported and may give weird results.  The weighting feature is hacky so please use with caution.  Otherwise we welcome feedback and comments at the corresponding authors' email address.

Please preferably cite both of the following in your work:

[1] Layne, R., Hospedales, T. M., & Gong, S. (2012). Person Re-identification by Attributes. British Machine Vision Conference.  
[2] Gray, D., & Tao, H. (2008). Viewpoint invariant pedestrian recognition with an ensemble of localized features. European Conference on Computer Vision. Marseille, France. 

- QMUL Vision Group, VSL Ltd.