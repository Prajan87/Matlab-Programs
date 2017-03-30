clc;
clear ;
%% Initialization and plotting of positions of satellites and outdoor antenna
% Total number of satellites
num =12;                    
         
% Satellite position
Sat = [ -5000 5000 9600;
        0 5000 9800;
        5000 5000 9500;
        -5000 0 9400;
        5000 0 9800;
        -5000 -5000 9900;
        0 -5000 9300;
        5000 -5000 9700;
        -2500 2500 9900;
        2500 2500 9850;
        -2500 -2500 9950;
        2500 -2500 9800];
    
% User Position
User = [25 50 300];           

%Plotting Satellite Positions
figure(1)
scatter3(Sat(:,1), Sat(:,2), Sat(:,3),'filled','markerfacecolor','r');
xlim([-5000, 5000])
ylim([-5000,5000])
zlim manual
zlim([0,10000])
grid on
title('Satellite and User Position')
xlabel('X-coordinates'), ylabel('Y-coordinates'),zlabel('Z-coordinates')
str = num2str((1:num)','Sat %d');    
text(Sat(:,1), Sat(:,2),Sat(:,3),  str, 'HorizontalAlignment','left', 'VerticalAlignment','bottom')
hold on
scatter3(User(:,1),User(:,2),User(:,3),'filled','markerfacecolor','g');
text(User(:,1), User(:,2),User(:,3),  'Outdoor Antenna Position', 'HorizontalAlignment','left', 'VerticalAlignment','bottom')
hold off

%% Distance calculation and Error Insertion
%Distance calculation
for i=1:num
Dis_user_sat(:,i)=SatDistance(Sat(i,:),User);
end

%Error Addition
Error = 10*randn(1,num);
dis=Dis_user_sat+ Error;


%% Randomness of postion calculation inside the building after retransmission
% Collecting randomness of displacement from actual position over 100 iterations

n=5;                                % Deviation of randomness
for i=1:1
data(1,i)=UsingRepeater(dis,n);
end

% % Fitting data to Rayleigh Distribution
% pd = fitdist(data', 'Rayleigh');
% x = linspace(min(data),max(data),200);
% y = pdf(pd,x);
% 
% % Plotting of the distribution
% figure(3)
% plot(x,y)
% title('Probability Distribution for displacement from actual position (11 beacons used)')
% xlabel('Displacement (in units)')
% ylabel('Probability of occurence')



% x0 = [300 100 30];
% eqn = @(x)[((((x(1)-Sat(1,1))^2+(x(2)-Sat(1,2))^2+(x(3)-Sat(1,3))^2))-dis(1)^2);
% ((((x(1)-Sat(2,1))^2+(x(2)-Sat(2,2))^2+(x(3)-Sat(2,3))^2))-dis(2)^2);
% ((((x(1)-Sat(3,1))^2+(x(2)-Sat(3,2))^2+(x(3)-Sat(3,3))^2))- dis(3)^2);
% ((((x(1)-Sat(4,1))^2+(x(2)-Sat(4,2))^2+(x(3)-Sat(4,3))^2))- dis(4)^2);
% ((((x(1)-Sat(5,1))^2+(x(2)-Sat(5,2))^2+(x(3)-Sat(5,3))^2))- dis(5)^2);
% ((((x(1)-Sat(6,1))^2+(x(2)-Sat(6,2))^2+(x(3)-Sat(6,3))^2))- dis(6)^2);
% ((((x(1)-Sat(7,1))^2+(x(2)-Sat(7,2))^2+(x(3)-Sat(7,3))^2))- dis(7)^2);
% ((((x(1)-Sat(8,1))^2+(x(2)-Sat(8,2))^2+(x(3)-Sat(8,3))^2))- dis(8)^2);
% ((((x(1)-Sat(9,1))^2+(x(2)-Sat(9,2))^2+(x(3)-Sat(9,3))^2))- dis(9)^2);
% ((((x(1)-Sat(10,1))^2+(x(2)-Sat(10,2))^2+(x(3)-Sat(10,3))^2))- dis(10)^2);
% ((((x(1)-Sat(11,1))^2+(x(2)-Sat(11,2))^2+(x(3)-Sat(11,3))^2))- dis(11)^2);
% ((((x(1)-Sat(12,1))^2+(x(2)-Sat(12,2))^2+(x(3)-Sat(12,3))^2))- dis(12)^2)];
% 
% % Solution using Lsqnonlin
% lb = [0 0 0];
% ub = [10000 10000 10000];
% % options = optimoptions('lsqnonlin','MaxFunEvals',3000,'MaxIter',700,'TolFun',1e-18);%,'TolX',1);
% x= lsqnonlin(eqn,x0)%,lb,ub);%,options);
% disp('using lsqnonlin')
% disp(x)
%  
% %Solution using LMFnlsq
% d=LMFnlsq(eqn,x0);
% disp('using LMFnlsq')
% disp(d)
% 
% %Solution using fsolve
% foptions.Algorithm = 'levenberg-marquardt';
% e=fsolve(eqn,x0,foptions);
% disp('using fsolve')
% disp(e)


 


