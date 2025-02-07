x = [500, 500, 500, 1000, 1000, 1000, 1500, 1500, 1500, 2000, 2000, 2000, 2500, 2500, 2500, 3000, 3000, 3000, 3500, 3500, 3500, 4000, 4000, 4000, 4500, 4500, 4500];

p_mean = [0, 0, 0, 0, 0, 0, 3.12, 3.18, 3.02, 4.16, 4.18, 4.23, 5.42, 5.34, 5.33, 6.87, 6.90, 6.79, 7.25, 7.56, 7.59, 8.48, 8.59, 8.45, 9.88, 9.59, 9.50];

p_sd = [0, 0, 0, 0, 0, 0, 0.19, 0.21, 0.26, 0.45, 0.37, 0.39, 0.47, 0.59, 0.47, 0.43, 0.45, 0.69, 0.64, 0.61, 0.59, 0.71, 0.61, 0.78, 0.79, 1.51, 1.21];

tri_mean = [1.08, 1.10, 1.03, 2.64, 2.63, 2.64, 3.26, 3.29, 3.75, 4.37, 4.36, 4.37, 5.43, 5.50, 5.70, 6.66, 6.75, 6.17, 7.11, 7.14, 7.51, 7.84, 8.12, 7.82, 9.60, 9.83, 9.05];

tri_sd = [0.36, 0.32, 0.31, 0.71, 0.77, 0.77, 0.87, 0.96, 0.95, 0.95, 1.00, 0.87, 1.21, 1.21, 1.14, 1.47, 1.43, 1.28, 1.41, 1.54, 1.70, 1.80, 1.89, 1.74, 2.01, 2.05, 4.91];

figure;
% Scatter plot for p_mean with error bars
scatter(x, p_mean, 'filled', 'r', 'DisplayName', 'Pitot\_mean');
hold on;
errorbar(x, p_mean, p_sd, 'r', 'LineStyle', 'none', 'HandleVisibility', 'off'); % Remove connecting lines

% Scatter plot for tri_mean with error bars
scatter(x, tri_mean, 'filled', 'b', 'DisplayName', 'Trisonica\_mean');
errorbar(x, tri_mean, tri_sd, 'b', 'LineStyle', 'none', 'HandleVisibility', 'off'); % Remove connecting lines

% Set xticks
x1 = 500:500:4500;
xticks(x1);

% Set axis labels and title
xlabel('Fan RPM', 'FontSize', 16, 'FontName', 'Serif');
ylabel('Mean Velocity Values with SD', 'FontSize', 16, 'FontName', 'Serif');
set(gca, 'FontName', 'Serif', 'FontSize', 16);

% Add grid and legend
grid on;
legend('show', 'Location', 'best');

% Display the plot
hold off;
