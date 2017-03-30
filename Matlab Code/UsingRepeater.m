function data = UsingRepeater(SatDis,n)
%% Initialization of indoor beacon position, user position and fiber length for connection
% Length of the fiber to join Outdoor receiving antenna to Indoor
% transmitting antenna
FiberLength = 1;

% Actual Location of User
User_Building=[-45 -40 30];

%Total numbers of beacons used
num = 11;

%Actual Location of the beacons
Beacon_Pos = [-50 50 100;
           50 -50 100;
           50 50 100;
           -50 -50 100;
           25 25 110;
           -25 25 110;
           25 -25 110;
           -25 -25 110;
           0 50 80;
           0 -50 80;
           0 0 110];

%% Distance calculation and Error Insertion
% Finding out the exact distance between user and beacons
for i=1:num
Dist_beacon_user(:,i) = SatDistance(Beacon_Pos(i,:),User_Building);
end

% Selecting random points from standard normal distribution
Error = n*randn(1,num);

%Addition of Error
Dist_beacon_user = Dist_beacon_user + Error;

%% Representation of internal working of the receiver
% Addition of satellite distance and fiber lenght to each beacon distance
for i=1:num
TotDist(:,i) = Dist_beacon_user(i) + SatDis(i) + FiberLength;
end

% Removing the satellite distance and fiberlength completely for running a
% simplified process
for i=1:num
ActDist(:,i) = TotDist(i) - SatDis(i) - FiberLength;
end

% Solving 11 equations available for positioning
% Vector initialization
x0 = [0 0 0];
% Equation Formation
eqn = @(x)[ ((((x(1)-Beacon_Pos(1,1))^2+(x(2)-Beacon_Pos(1,2))^2+(x(3)-Beacon_Pos(1,3))^2))-ActDist(1)^2);
            ((((x(1)-Beacon_Pos(2,1))^2+(x(2)-Beacon_Pos(2,2))^2+(x(3)-Beacon_Pos(2,3))^2))-ActDist(2)^2);
            ((((x(1)-Beacon_Pos(3,1))^2+(x(2)-Beacon_Pos(3,2))^2+(x(3)-Beacon_Pos(3,3))^2))- ActDist(3)^2);
            ((((x(1)-Beacon_Pos(4,1))^2+(x(2)-Beacon_Pos(4,2))^2+(x(3)-Beacon_Pos(4,3))^2))- ActDist(4)^2);
            ((((x(1)-Beacon_Pos(5,1))^2+(x(2)-Beacon_Pos(5,2))^2+(x(3)-Beacon_Pos(5,3))^2))- ActDist(5)^2);
            ((((x(1)-Beacon_Pos(6,1))^2+(x(2)-Beacon_Pos(6,2))^2+(x(3)-Beacon_Pos(6,3))^2))- ActDist(6)^2);
            ((((x(1)-Beacon_Pos(7,1))^2+(x(2)-Beacon_Pos(7,2))^2+(x(3)-Beacon_Pos(7,3))^2))- ActDist(7)^2);
            ((((x(1)-Beacon_Pos(8,1))^2+(x(2)-Beacon_Pos(8,2))^2+(x(3)-Beacon_Pos(8,3))^2))- ActDist(8)^2);
            ((((x(1)-Beacon_Pos(9,1))^2+(x(2)-Beacon_Pos(9,2))^2+(x(3)-Beacon_Pos(9,3))^2))- ActDist(9)^2);
            ((((x(1)-Beacon_Pos(10,1))^2+(x(2)-Beacon_Pos(10,2))^2+(x(3)-Beacon_Pos(10,3))^2))- ActDist(10)^2);
            ((((x(1)-Beacon_Pos(11,1))^2+(x(2)-Beacon_Pos(11,2))^2+(x(3)-Beacon_Pos(11,3))^2))- ActDist(11)^2)];

% Solution using Lsqnonlin
lb = [-100 -100 0];             %Lower Bound for the value
ub = [100 100 300];             %Upper Bound for the value


x = lsqnonlin(eqn,x0,lb,ub);
x2 = LMFnlsq(eqn,x0);
x1 = fsolve(eqn,x0);
x3 = LMFsolve(eqn,x0);
disp('Using lsqnonlin')
disp(x);
disp('Using fsolve')
disp(x1)
disp('Using LMFnlsq')
disp(x2)
disp('Using LMFsolve')
disp(x3)


data = SatDistance(x,User_Building);


% figure(2)  
% scatter3(Beacon_Pos(:,1), Beacon_Pos(:,2), Beacon_Pos(:,3),'filled','markerfacecolor','r');
% xlim([-50, 50])
% ylim([-50,50])
% zlim manual
% zlim([0,110])
% grid on
% title('Location of Beacons and User')
% xlabel('X-allignment'), ylabel('Y-allignment'),zlabel('Z-allignment')
% str = num2str((1:num)','Beacon %d');    
% text(Beacon_Pos(:,1), Beacon_Pos(:,2),Beacon_Pos(:,3),  str, 'HorizontalAlignment','left', 'VerticalAlignment','top')
% hold on
% scatter3(User_Building(:,1),User_Building(:,2),User_Building(:,3),'filled','markerfacecolor','g');   
% text(User_Building(:,1), User_Building(:,2),User_Building(:,3),  'User Position', 'HorizontalAlignment','left', 'VerticalAlignment','top')
% hold off

% scatter3(x(1),x(2),x(3),'filled','markerfacecolor','b');
% hold off

figure(2)
scatter3(Beacon_Pos(:,1), Beacon_Pos(:,2), Beacon_Pos(:,3),'filled','markerfacecolor','r');
scatter3(x(1),x(2),x(3),'filled','markerfacecolor','b');
xlim([-50, 50])
ylim([-50,50])
zlim manual
zlim([0,110])
grid on
title('User Position determined using 11 beacons')
xlabel('X-allignment'), ylabel('Y-allignment'),zlabel('Z-allignment')
str = num2str((1:num)','Beacon %d');    
text(Beacon_Pos(:,1), Beacon_Pos(:,2),Beacon_Pos(:,3),  str, 'HorizontalAlignment','left', 'VerticalAlignment','top')
hold on
scatter3(User_Building(:,1),User_Building(:,2),User_Building(:,3),'filled','markerfacecolor','g');   
% text(User_Building(:,1), User_Building(:,2),User_Building(:,3),  'User Position', 'HorizontalAlignment','left', 'VerticalAlignment','top')
hold on

end