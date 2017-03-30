%% Calculation of distance between any two points
function distance = SatDistance(a,b)

distance = sqrt((a(1)-b(1))^2+(a(2)-b(2))^2+(a(3)-b(3))^2);

end