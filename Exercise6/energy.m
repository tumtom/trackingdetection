function f = energy( x,a )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
R = x(1);
T = x(2);

A = a(1);
M_i = a(2);
m_i = a(3);

sum=0;

for i=1:nrP
    y = norm(A (R * M_i + T)) - m_i;
    sum = sum + y;
end

f = sum;