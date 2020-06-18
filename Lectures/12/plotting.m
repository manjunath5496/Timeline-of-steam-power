function plotting(xv,xc,xt,F,yt,Gamma,G,UT,UTVP)
figure;
% subplot(2,2,1); 
% plot(xc,Gamma,'-r','LineWidth',2);  hold on;
% plot(xc,G,'-b','LineWidth',2);  hold off;
% legend('Point Vortex Strength (Gamma)','Vortex Sheet Strength(G)');
% xlabel('X/C');  grid on;

% subplot(2,2,2); 
plot(xc,UT,'-r+','LineWidth',2);  
xlabel('X/C');  ylabel('Ut');   grid on;
title('Thickness Induced Velocity vs X')

% subplot(2,2,3); 
% plot(xv,F,'-r','LineWidth',2);
% ylabel('Camber f/c');   xlabel('X/C');  grid on;
% title('Camber Distribution');
% 
% subplot(2,2,4); 
% plot(xt,yt,'-r','LineWidth',2);
% xlabel('X/C');  ylabel('Thickness t/c');    grid on;
% title('Thickness Distribution')