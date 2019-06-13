function [resistance] = getResitance(v)
%GETRESITANCE Summary of this function goes here
%   Detailed explanation goes here
constant_resistance = 4 * 12;
ro = 1.2;
Cd = 0.33;
A = 1.9;
drag = 1/2 * ro * v^2 * Cd * A ;
resistance = constant_resistance + drag;
end

