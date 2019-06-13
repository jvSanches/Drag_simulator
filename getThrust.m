function [force] = getThrust(revs,gear)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
	
tyre_radius = 0.305; 
transmission_efficiency = 0.89;
clutch = 1;

engine_torque = getTorque(revs);
total_gear_ratio = getReductionRatio(gear);
wheel_torque = engine_torque * clutch * total_gear_ratio * transmission_efficiency;

force = wheel_torque / tyre_radius;

end

