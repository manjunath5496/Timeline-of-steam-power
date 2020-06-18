function [RLE, yt,dydx] = thickness(xv, xc, xt)
global U c N CL Alpha TOC;
% NACA65A010 Thickness Form
x = [0 .005 .0075 .0125 .025 .05 .075 .1 .15 .2 .25 .3 .35 .4 .45 .5 .55...
    .6 .65 .7 .75 .8 .85 .9 .95 1];
yt0 = [0 .00765 .00928 .01183 .01623 .02182 .0265 .0304 .03658 .04127...
       .04483 .04742 .04912 .04995 .04983 .04863 .04632 .04304 .03899...
       .03432 .02912 .02352 .01771 .01188 .00604 .00021];
yt1 = yt0./max(yt0);
% Thickness is scaled linearly
yt = spline(x,yt1,xt).*TOC;
% yt = interp1(x,yt1,xt).*TOC;
RLE0 = .00607*(max(yt1)/max(yt0))^2;
% RLE scales with square of TOC
RLE = RLE0 * TOC^2;
for i = 1:N
   dydx(i) = (yt(i+1)-yt(i)) / (xt(i+1)-xt(i)); 
end