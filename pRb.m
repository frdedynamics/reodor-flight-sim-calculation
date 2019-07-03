function y = pRb(psi,theta,phi)
%pRb Rotation matrix
%   Rotation matrix, yo

y = zeros(3,3);

% first column
y(1,1) = cos(psi)*cos(theta);
y(2,1) = sin(psi)*cos(theta);
y(3,1) = -sin(theta);

y(1,2) = -sin(psi)*cos(phi) + cos(psi)*sin(theta)*sin(phi);
y(2,2) = cos(psi)*cos(phi) + sin(psi)*sin(theta)*sin(phi);
y(3,2) = cos(theta)*sin(phi);

y(1,3) = sin(psi)*sin(phi) + cos(psi)*sin(theta)*cos(phi);
y(2,3) = -cos(psi)*sin(phi) + sin(psi)*sin(theta)*cos(phi);
y(3,3) = cos(theta)*cos(phi);

end

