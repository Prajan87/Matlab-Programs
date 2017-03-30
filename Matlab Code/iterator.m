function result = iterator (SatPos,origDis,n)
iniPos=[20 40 290];
j=0;
deltaV=1;
while (deltaV >0.0001)
    for i=1:n
         newDis(:,i)=SatDistance(SatPos(i,:),iniPos);
    end

deltaDis=(newDis-origDis);%ones(1,4)*iniPos(4))-origDis);

%alpha calculation
for i=1:n
alpha(i,1)=(SatPos(i,1)-iniPos(1))/(newDis(i));%-iniPos(4));
alpha(i,2)=(SatPos(i,2)-iniPos(2))/(newDis(i));%-iniPos(4));
alpha(i,3)=(SatPos(i,3)-iniPos(3))/(newDis(i));%-iniPos(4));
end

% alpha(:,4)=1;

%Error Calcualtion
 a = transpose(alpha)*deltaDis';
 b = transpose(alpha)*alpha;
deltaError=pinv(b)*a;
deltaV=sqrt(deltaError(1)^2+deltaError(2)^2+deltaError(3)^2);%+deltaError(4)^2);
iniPos=iniPos+deltaError(1:3)';
j=j+1;
end
j
result=iniPos;
end
