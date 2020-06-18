% test of spherical bessel function generator
x=[0.1:0.1:10];
jf=zeros(length(x),6);
for i=1:length(x)
    j=sbfj(x(i),10);
    jf(i,:)=j(1:size(jf,2));
end
col=['r' 'g' 'b' 'c' 'm' 'y'];
figure(1)
hold off
a=plot(x,jf(:,1),col(1))
 set(a,'LineWidth',2);
 hold on
for i=2:6
 a=plot(x,jf(:,i),col(i))
 set(a,'LineWidth',2);
end
axis([0 10 -2 2 ]);
grid on
title('j_m(x) - Backward Recurrence');
xlabel('x')

jf=zeros(length(x),6);
for i=1:length(x)
    j=sbfj_3(x(i),10);
    jf(i,:)=j(1:size(jf,2));
end
col=['r' 'g' 'b' 'c' 'm' 'y'];
figure(2)
hold off
a=plot(x,jf(:,1),col(1))
 set(a,'LineWidth',2);
 hold on
for i=2:6
 a=plot(x,jf(:,i),col(i))
 set(a,'LineWidth',2);
end
axis([0 10 -2 2 ]);
grid on
title('j_m(x) - Backward Recurrence - 3 digits');
xlabel('x')

% forward recurrence
jf=zeros(length(x),6);
for i=1:length(x)
    j=sbfj_f(x(i),10);
    jf(i,:)=j(1:size(jf,2));
end
col=['r' 'g' 'b' 'c' 'm' 'y'];
figure(3)
hold off
a=plot(x,jf(:,1),col(1))
 set(a,'LineWidth',2);
 hold on
for i=2:6
 a=plot(x,jf(:,i),col(i))
 set(a,'LineWidth',2);
end
axis([0 10 -2 2 ]);
grid on
title('j_m(x) - Forward Recurrence');
xlabel('x')

% forward recurrence 3 sign digits
jf=zeros(length(x),6);
for i=1:length(x)
    j=sbfj_f_3(x(i),10);
    jf(i,:)=j(1:size(jf,2));
end
col=['r' 'g' 'b' 'c' 'm' 'y'];
figure(4)
hold off
a=plot(x,jf(:,1),col(1))
 set(a,'LineWidth',2);
 hold on
for i=2:6
 a=plot(x,jf(:,i),col(i))
 set(a,'LineWidth',2);
end
axis([0 10 -2 2 ]);
grid on
title('j_m(x) - Forward Recurrence - 3 digits');
xlabel('x')

% forward recurrence y
jf=zeros(length(x),6);
for i=1:length(x)
    j=sbfy(x(i),10);
    jf(i,:)=j(1:size(jf,2));
end
col=['r' 'g' 'b' 'c' 'm' 'y'];
figure(5)
hold off
a=plot(x,jf(:,1),col(1))
 set(a,'LineWidth',2);
 hold on
for i=2:6
 a=plot(x,jf(:,i),col(i))
 set(a,'LineWidth',2);
end
axis([0 10 -2 2 ]);
grid on
title('y_m(x) - Forward Recurrence');
xlabel('x')

