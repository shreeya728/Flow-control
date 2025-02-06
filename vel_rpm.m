% Define RPM values and file path
rpm_values = 500:500:4500;
file_base_path = '/Users/shreeyapadte/Desktop/SEM8/BTP AS4600+/pitot_tube/50cm-probe (2).xlsx';

% Initialize arrays to store means and standard deviations
final_means = zeros(3, length(rpm_values));
final_stds = zeros(3, length(rpm_values));

% Process each RPM
for r = 1:length(rpm_values)
    rpm = rpm_values(r);
    
    % Process each sheet (r1, r2, r3)
    for s = 1:3
        sheet_name = sprintf('r%d-%d', s, rpm);
        
        % Read data from the Excel file
        data = readmatrix(file_base_path, 'Sheet', sheet_name);
        
        % Extract the 3rd column
        column_3 = data(:, 3);
        
        % Remove zero values and limit to 3000 data points
        column_3 = column_3(column_3 ~= 0);
        column_3 = column_3(2:min(3000, end));
        
        % Calculate mean and standard deviation
        final_means(s, r) = mean(column_3, 'omitnan');
        final_stds(s, r) = std(column_3, 'omitnan');
        
        % Display results for each RPM and sheet
        fprintf('RPM: %d, Sheet: r%d\n', rpm, s);
        fprintf('  Mean: %.4f\n', final_means(s, r));
        fprintf('  Standard Deviation: %.4f\n\n', final_stds(s, r));
    end
end

% Calculate overall mean and standard deviation
overall_mean = mean(final_means, 1);
overall_std = sqrt(mean(final_stds.^2, 1));

% Plot the final mean values with standard deviation error bars
figure;
errorbar(rpm_values, overall_mean, overall_std, '-ro', 'MarkerFaceColor', 'r', 'LineWidth', 1.5);
hold on;
plot(rpm_values, final_means(1, :), 's-', 'DisplayName', 'r1');
plot(rpm_values, final_means(2, :), 'd-', 'DisplayName', 'r2');
plot(rpm_values, final_means(3, :), '^-', 'DisplayName', 'r3');
hold off;

xlabel('RPM', 'FontName', 'Serif', 'FontSize', 16);
ylabel('$\overrightarrow{|v|}_{mean}$ (m/s)', 'Interpreter', 'latex', 'FontName', 'Serif', 'FontSize', 16);
title('Mean Velocity vs RPM', 'FontName', 'Serif', 'FontSize', 18);
legend('Overall Mean', 'r1', 'r2', 'r3', 'Location', 'best');
grid on;
