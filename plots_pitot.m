% This code is for finding the decay in velocity as we move away from the gust fans.

% File path and sheet name
file_path = '/Users/shreeyapadte/Desktop/SEM7/BTP AS4600+/pitot_tube/decay_pitot.xlsx';
sheet_names = {'3000_50cm', '3000_50cm_2', '3000_75cm', '3000_75cm_2', '3000_100cm', '3000_100cm_2'};
dist = [50, 75, 100];

mean_values = zeros(1, length(sheet_names));

for i = 1:length(sheet_names)
    data = readmatrix(file_path, 'Sheet', sheet_names{i});
    
    if ismember(i, [1, 2, 4])
        sec_column = data(:, 3);
    elseif ismember(i, [3, 5, 6])
        sec_column = data(:, 5);
    end
    sec_column = sec_column(sec_column ~= 0);
    
    sec_column = sec_column(2:min(3000, end));
    
    mean_values(i) = mean(sec_column, 'omitnan');
    
    fprintf('Mean value for %s: %.4f\n', sheet_names{i}, mean_values(i));
end

cm_50 = (mean_values(1)+mean_values(2))/2;
cm_75 = (mean_values(3)+mean_values(4))/2;
cm_100 = (mean_values(5)+mean_values(6))/2;
cm = [cm_50, cm_75, cm_100];

figure;
scatter(dist, cm, 'filled', 'o');
hold on;
plot(dist, cm, 'LineWidth', 1.5);
%xticks(0:20:length(sec_column)); % Set x-axis ticks (adjust interval as needed)
%yticks(linspace(min(sec_column), max(sec_column), 10)); % Set y-axis ticks (10 intervals)

% Set font and size
set(gca, 'FontName', 'Serif', 'FontSize', 16); % Serif font with size 16

% Set labels and title
xlabel('Location from fan (cm)', 'FontName', 'Serif', 'FontSize', 16);
ylabel('$\overrightarrow{|v_{mean}|}$ (m/s)', 'Interpreter', 'latex', 'FontName', 'Serif', 'FontSize', 16);
grid on;

