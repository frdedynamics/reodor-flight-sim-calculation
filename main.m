%% Description
% The Stewart Platform consists of 2 rigid frames connected by 6 variable 
% length legs.
% The top frame is known and fits the flight simulator
% The legs are 1.60-2.60m linear actuators
%
% The bottom frame needs to be designed in order to allow the following:
% 1. 30 degree travel in all top plate euler angles roll, pitch and yaw
%
% There is low demand on cartesian travel x, y and z

%% Clear everything
clear all; clc;

%% Setup
setup.save_plots = true;

%% Tuning variables, play with these
b = zeros(6,3);
b(1,:) = [0, 1.5, 0]';       % vector from base origo to base link 1
b(2,:) = [0.2, 1.5, 0]';
b(3,:) = [1.5, 0.0, 0]';
b(4,:) = [1.5, 0.2, 0]';
b(5,:) = [0, -1.5, 0]';
b(6,:) = [0.2, -1.5, 0]';

%% Constants, define these from spec
l_min = 1.6;                % minimum link length
l_max = 2.6;

h_0 = 1.5;                  % default height with flat platform

p = zeros(6,3);
p(1,:) = [0, 1.0, 0]';      % vector from plate origo to plate link 1
p(2,:) = [0.2, 1.0, 0]';
p(3,:) = [1.0, 0.0, 0]';
p(4,:) = [1.0, 0.2, 0]';
p(5,:) = [0, -1.0, 0]';
p(6,:) = [0.2, -1.0, 0]';

%% Variables
psi = 0.0;                  % around base z
theta = 0.0;                % around base y
phi = 0.0;                  % around base x
h = h_0;                    % height of platform

% 1) home position
T = [0, 0, h_0]';  % translational from base origo to platform origo
disp('This should return without error')
q(1,:) = T + pRb(psi, theta, phi)*p(1,:)'   % x, y, z in base frame
l(1,:) = T + pRb(psi, theta, phi)*p(1,:)' - b(1,:)' % x, y, z from b to p
sprintf('length of link 1 is: %1.1f m', norm(l(1,:)))
disp('so far so good..')

%% Test extreme positions
% all arms extended

% all arms retracted

% 2 arms fully extended, 4 arms fully retracted, for all configs

% 4 arms fully extended, 2 arms fully retracted, for all configs


%% Basic motion

% from -30 to 30 degree yaw..

%% Plot
figure(1); clf;
for i=1:length(p) 
    plot3(  [b(i,1), p(i,1)],...
            [b(i,2), p(i,2)],...
            [b(i,3), p(i,3)+h_0],...
            'o--', 'LineWidth', 2, 'MarkerSize', 10)
    hold on;
end

title('Home position')
xlabel('x');
ylabel('y');
zlabel('z');
xlim([-2, 2]);
ylim([-2, 2]);
zlim([0, 3]);
grid on;

if setup.save_plots
    disp('Saving plot..')
    saveas(gcf,'./plots/home_positioni.png')
end

disp('Done')
