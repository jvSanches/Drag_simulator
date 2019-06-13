function [ratio] = getReductionRatio(gear)
%GETREDUCTIONRATIO Summary of this function goes here
%   Detailed explanation goes here
gear_ratios=[3.72 2.40 1.77 1.26 1] ;
final_gear_ratio=3.15;
ratio = gear_ratios(gear) * final_gear_ratio;
end

