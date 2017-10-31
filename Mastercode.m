% Calculation of Pitch Angle for each blade element
function [ element_data,theta_mat ] = element_geom( d,ne,tsr,B )
element_l = (d/2) / ne ;
element_data = zeros(ne,5) ;
element_data(:,1) = 1:ne ;
alpha1 = 9.75 ; % Angle of attack for max L/D ratio for s832
Cl1 = 1.1207 ;
%Cd1 = 0.0622 ;
for i = 1:ne
element_data(i,2) = (element_l/2) + (i-1)*element_l ;
element_data(i,3) = tsr * ( element_data(i,2) / (d/2) ) ;
element_data(i,4) = atan( 1 / element_data(i,3) ) * (2/3) ;
element_data(i,5) = ( 8*pi*element_data(i,2)*(1-cos(element_data(i,4))) ) / (B*Cl1)
element_data(i,4) = element_data(i,4)*(180/pi) ;
end
for j = 1:ne
element_data(j,2) = element_data(j,2) / (d/2) ;
element_data(j,5) = element_data(j,5) / (d/2) ;
end
theta_mat = zeros(ne,1) ;
for k = 1:ne
theta_mat(k,1) = element_data(k,4) - alpha1 ;
end
end
