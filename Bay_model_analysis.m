MATLAB CODE FOR BAY MODEL ANALYSIS
%BAY Actuator VG model
%VG Effect instead of Geometry
%Define the dimension of grid (2H*1.02H*1.1H)
%Define the grid cell distribution in the entire region (20*17*10)
%w-18 lines; l-21 lines
%Define VG dimensions (2H*0.2H*1H)

%V - volume of unit grid cell
%u - local velocity = 14m/s
%rho - local density
%beta - AoA
%sumV - Sum of all volumes of cells wheremodel is applied
%svg - VG planform area
%cvg - emperical constant
%L - lifting force source term
%delt - small duration of time
%H=25mm

%if condition to finalise on affected cells through looping in all 3
%dimesnions
%(V/sumV) = number of cells  = n
%Z - List of x and y coordinates for each intersection
clear
clc

H = input('Enter boundary layer thickness dimension: ');
u = input('Enter free flow speed of wind: ');

 n = [ 10 100 250 500 1000 2000 5000 7500 8500 10000];
 x_max = 25.49;
 y_max = 50;
 cvg = 4;
svg = 2*H*0.2*H;
beta = 20*pi/180;
rho = 1.225;
vel = [ 5 10 15 20 25 30 35 40 45];

 s = zeros(1,10);
 
 %ya = tan(20*pi/180)*(xa - 2.44) + 1.71 - Line 1
 %yb = tan(20*pi/180)*(xb - 7.14) - Line 2
 %yc = tan(160*pi/180)*(xc -2.44) + 1.71 - Line 3
 %yd = tan(160*pi/180)*(xd - 24.24) + 46.98 - Line 4

 for i = 1:10
     m(i)=n(i);
     p(i)=x_max/m(i);
     q(i)=y_max/m(i);
     
     for a=1:(m(i)+1)
         for b=1:(m(i)+1)
             X = p(i)*a;
             Y = q(i)*b;
             
             if ((Y - tan(20*pi/180)*(X - 2.44) - 1.71) >= 0)&&((Y - tan(20*pi/180)*(X - 24.24)-46.98) <= 0)&&((Y - tan(160*pi/180)*(X-2.44)-1.71)>= 0)&&((Y-tan(160*pi/180)*(X-24.24)-46.98)<= 0)
 
 s(i) = s(i) + 1;
             end
            
         end
     end
    v(i) = s(i)/(m(i)*m(i));
%a point is inside the rectangel is greater than ya and yc and lesser than
%yb and yd
L(i) = cvg*svg*v(i)*beta*rho*(u^2)*10^(-6);
 end
 L
 s
 
 plot(n,L)
 xlabel('No of grid divisions');
 ylabel('Lift force (N)');
 
 for j = 1:9
     L1(j) = cvg*svg*v(2)*beta*rho*(vel(j)^2)*10^(-6);
 end
 plot(vel,L1)
 xlabel('Wind Velocity');
 ylabel('Lift force (N)');
% The convergence is at the max attainable wind velocity in the wind tunnel i.e 30.5 m/s.
% Find no.of cell for Rectangle and get the solution for other through volume ratio through utilising the height parameter.
