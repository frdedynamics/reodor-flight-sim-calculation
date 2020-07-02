%% Stewart platfrom sim
% Using Matlab`s demo as starting point
% Adjusted platform to something closer to our need
% Made some motions
% Not excact, but good enough for epxploring build options,
% forces, limits, etc..

clear all; clc;

%% Tuning
controlled_stop_at_time = 400; % [s] into simulation
work_height = 1.2*100;
base_radius = 0.75*100;
platform_radius = 0.75*base_radius;

leg_min = 1.022;
leg_max = leg_min+0.3;

stroke_max = leg_max - leg_min;
dead_length = leg_max - stroke_max;
upper_leg_length = dead_length/2;
lower_leg_length = upper_leg_length;

desired_max_z = 0.05; % [m]
desired_max_x = 0.05;
desired_max_y= desired_max_x;
desired_max_angle = 10; % [deg]

platform_thickness = 0.1/8; % [m] 0.1 -> 200kg platform

leg_thickness = 75/1000; % [m]
max_velocity = 0.15; % [m/s]
distance_between_leg_joints = 150/1000; % [m]

trajectory_smoothing = 1/1.5;
initial_integral_force = 200;
%% Sim
disp('Simulating..')
tic
sim('sm_stewart_platform.slx',450);
disp('Time used for simulation: ')
toc

%% Plotty plots
disp('Plotting..')

B = base_points.Data(:,:,1);
P = platform_points.Data(:,:,1);

figure(1); clf;
hold on;
for i=1:6
    plot3(B(1,i), B(2,i), B(3,i),'.')
    text(B(1,i), B(2,i), B(3,i),num2str(i),'Color','r')
    if i<6
        plot3(...
            [B(1,i), B(1,i+1)],...
            [B(2,i), B(2,i+1)],...
            [B(3,i), B(3,i+1)],...
            '-','Color','r','LineWidth',1.5)
    end
end
plot3([B(1,6), B(1,1)],[B(2,6), B(2,1)],[B(3,6), B(3,1)],'-','Color','r','LineWidth',1.5)
viscircles([0,0],base_radius,'Color','r','LineStyle','--');


for i=1:6
    plot3(P(1,i), P(2,i), P(3,i),'.')
    text(P(1,i), P(2,i), P(3,i),num2str(i),'Color','b')
    if i<6
        plot3(...
            [P(1,i), P(1,i+1)],...
            [P(2,i), P(2,i+1)],...
            [P(3,i), P(3,i+1)],...
            '-','Color','b','LineWidth',1.5)
    end
end
plot3([P(1,6), P(1,1)],[P(2,6), P(2,1)],[P(3,6), P(3,1)],'-','Color','b','LineWidth',1.5)
viscircles([0,0],platform_radius,'Color','b','LineStyle','-.');

title('Layout and radii, top view')
axis equal

disp('Some distances [m]..')
(B(:,1)-B(:,4))/100
(B(:,3)-B(:,2))/100

disp('Done')


