function c = radd(a,b,n)
%
% function c = radd(a,b,n)
%
% Adds two real numbers a and b simulating an arithmetic unit with
% n significant digits.
%
% First determine sign
sa=sign(a);
sb=sign(b);
if (sa == 0)
    la=-200;
else
la=ceil(log10(sa*a*(1+10^(-(n+1)))));
end
if (sb == 0)
    lb=-200;
else
    lb=ceil(log10(sb*b*(1+10^(-(n+1)))));
end
    lm=max(la,lb);

f=10^(n);
at=sa*round(f*sa*a/10^lm);	
bt=sb*round(f*sb*b/10^lm);

ct=at+bt;
sc=sign(ct);
if (sc ~= 0)
if (log10(sc*ct) >= n)
    ct=round(ct/10)*10;
end
end

c=ct*10^lm/f;
