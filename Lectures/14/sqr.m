a=26;
n=10;
g=1;
     sq(1)=g;
     for i=2:n
      sq(i)= 0.5*(sq(i-1) + a/sq(i-1));
     end
     hold off
     plot([0 n],[sqrt(a) sqrt(a)],'b')
     hold on
     plot(sq,'r')
     plot(a./sq,'r-.')
     plot((sq-sqrt(a))/sqrt(a),'g')
     grid on

 
