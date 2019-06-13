function [max_thrust] = getMaxThrust(accel)
%Calculates maximum tractive force
%   Detailed explanation goes here
G= 9.8;
wheel_base = 2.565;	
gc_height = 0.4;
friction_coef = 0.9;
total_mass = 1275;
cg_location=0.50;
%P = total_mass * cg_location; %fwd
%P = G * total_mass * (1-cg_location); %Rwd


Prear = (total_mass * accel * gc_height)/wheel_base + total_mass * G/2;

max_thrust = Prear * friction_coef;
end

