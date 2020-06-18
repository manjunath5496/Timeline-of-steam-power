% Travelling salesman problem
% Create random city distribution
n=20;
x=random('unif',-1,1,n,1)
y=random('unif',-1,1,n,1)
gam=1;
mu=sign(x);
% End up where you start
x=[x' x(1)]'; 
y=[y' y(1)]'; 
mu=[mu' mu(1)]'; 
figure(1); hold off; g=plot(x,y,'.r'); set(g,'MarkerSize',20);
c0=cost(x,y,mu,gam)
k=1;
nt=50;
nr=200;
cp=zeros(nr,nt);
iran=inline('round(random(d,1.5001,n+0.4999))','d','n');
for i=1:nt   
    T=1.0 -(i-1)/nt
    for j=1:nr
        % switch two random cities
        ic1=iran('unif',n);
        ic2=iran('unif',n);
        xs=x(ic1); ys=y(ic1); ms=mu(ic1);
        x(ic1)=x(ic2); y(ic1)=y(ic2); mu(ic1)=mu(ic2);
        x(ic2)=xs; y(ic2)=ys; mu(ic2)=ms;
        p=random('unif',0,1);
        c=cost(x,y,mu,gam);
        if (c < c0 | p < exp(-(c-c0)/(k*T)))
            % accept
            c0=c;
        else
            % reject and switch back
            xs=x(ic1); ys=y(ic1); ms=mu(ic1);
            x(ic1)=x(ic2); y(ic1)=y(ic2); mu(ic1)=mu(ic2);
            x(ic2)=xs; y(ic2)=ys; mu(ic2)=ms;
            c=c0;
        end
        cp(j,i)=c0;
    end
    figure(2)
    plot(reshape(cp,nt*nr,1)); drawnow;
    figure(1); hold off; g=plot(x,y,'.r'); set(g,'MarkerSize',20); 
    hold on; plot(x,y,'b'); g=plot(x(1),y(1),'.g'); set(g,'MarkerSize',30);
    p=plot([0 0],[-1 1],'r--'); set(g,'LineWidth',2);
    drawnow;
end

            
            
            
        
        

