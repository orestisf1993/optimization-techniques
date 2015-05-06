function [ y ] = f1( x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global calcs;
calcs = calcs + 1;

y = (x-2).^2 + (x-3).^2;

end

