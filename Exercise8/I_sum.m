function [ Isum ] = I_sum( o_row, o_col, width, height )
global I;
o_row = round(o_row);
o_col = round(o_col);
width = round(width);
height = round(height);
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
D = I(o_row + height,o_col + width);
A = I(o_row,o_col);
B = I(o_row + height,o_col);
C = I(o_row, o_col + width);
Isum = D + A - B - C;
end

