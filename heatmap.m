% 2D interpolation plot for velocities across the fan array
clc;
clear all;
close all;

% file_path = {
%     '/Users/shreeyapadte/Downloads/75cmleftest.xlsx',
%     '/Users/shreeyapadte/Downloads/75cmleft.xlsx',
%     '/Users/shreeyapadte/Downloads/75cmmid.xlsx',
%     '/Users/shreeyapadte/Downloads/75cmright.xlsx',
%     '/Users/shreeyapadte/Downloads/75cmrightest.xlsx'
% };
file_path = {
    '/Users/shreeyapadte/Downloads/100cm_leftest.xlsx',
    '/Users/shreeyapadte/Downloads/100cm_left.xlsx',
    '/Users/shreeyapadte/Downloads/100cm_transverse.xlsx',
    '/Users/shreeyapadte/Downloads/100cm_right.xlsx',
    '/Users/shreeyapadte/Downloads/100cm_rightest.xlsx'
};

num_sheets = 15; % Total number of sheets
sheet_names = cell(1, num_sheets); % Preallocate cell array

for i = 1:num_sheets
    sheet_names{i} = sprintf('Sheet%d', i); 
end

%dist = [17.5, 14, 10.5, 7, 3.5] * 2.54; % Convert to cm
dist = [3.5, 7, 10.5, 14, 17.5] * 2.54;

% Matrix to store mean velocities for heatmap (rows: distances, cols: positions)
mean_velocity_matrix = zeros(length(dist), length(file_path));

for j = 1:length(file_path)
    mean_values = zeros(1, length(sheet_names));

    for i = 1:length(sheet_names)
        data = readmatrix(file_path{j}, 'Sheet', sheet_names{i});
        if size(data, 1) < 101
            warning('Sheet %s in file %s has less than 101 rows. Skipping.', sheet_names{i}, file_path{j});
            continue; % Skip this sheet
        end

        vel = data(101:end, 3);
        vel = vel(vel ~= 0);
        mean_values(i) = mean(vel, 'omitnan');
    end

    % Compute averaged mean velocities
    mean_velocity_matrix(:, j) = [mean(mean_values(1:3));
                                  mean(mean_values(4:6));
                                  mean(mean_values(7:9));
                                  mean(mean_values(10:12));
                                  mean(mean_values(13:15))];
end

% Original grid points
[X, Y] = meshgrid(1:length(file_path), 1:length(dist));

% Generate finer grid for interpolation (100x100 points)
[Xq, Yq] = meshgrid(linspace(1, length(file_path), 100), linspace(1, length(dist), 100));

% Interpolate using cubic or spline method for smoothness
smooth_velocity_matrix = interp2(X, Y, mean_velocity_matrix, Xq, Yq, 'spline');

% Plot Smoothed Heatmap
figure;
imagesc(linspace(1, length(file_path), 100), linspace(1, length(dist), 100), smooth_velocity_matrix);
colormap(jet);
colorbar;
caxis([min(mean_velocity_matrix(:)) max(mean_velocity_matrix(:))]); % Scale color range properly

% Set labels
xticks(1:length(file_path));
xticklabels({'Leftest', 'Left', 'Mid', 'Right', 'Rightest'});
yticks(1:length(dist));
yticklabels(string(dist));

xlabel('Position Across Transverse Section');
ylabel('Distance from Fan (cm)');
title('Smoothed Mean Velocity Heatmap at 100cm from Fan Array');

set(gca, 'FontName', 'Serif', 'FontSize', 14);
grid on;
