function Report(xv,F,Gamma,G,CLNum,RLE,yt,UT,UTVP,CPU,CPL)
global U c N CL Alpha TOC;
fid = fopen('Report.txt','w');
% =========================================================================
fprintf(fid,'2D Vortex Lattice with Lighthill Correction Program (VLM)\n\n');
fprintf(fid,'Number of Panels: %g\n',N);
fprintf(fid,'Ideal Lift Coefficient: %5.2f\n',CL);
fprintf(fid,'Angle of Attack (Alpha-AlphaIdeal): %5.1f degree\n',Alpha);
fprintf(fid,'Maximum Thickness/Chord Ratio (T/C): %5.2f\n',TOC);
fprintf(fid,'Radius of Leading Edge (RLE/C): %5.5f\n',RLE);
fprintf(fid,'Calculated Lift Coefficient (CLNum): %5.5f\n\n',CLNum);
fprintf(fid,'  x/c\t  f/c\t  t/c\t Gamma\t   G\t\t UT\t\t UTVP\t  CPU\t  CPL\n');
for i = 1:N
    fprintf(fid,'%6.4f  %6.4f  %6.4f  %+6.4f  %+6.4f  %+6.4f  %+6.4f  %+6.4f  %+6.4f\n'...
        ,xv(i),F(i),yt(i),Gamma(i),G(i),UT(i),UTVP(i),CPU(i),CPL(i));
end
% =========================================================================
fclose(fid);
open('Report.txt')