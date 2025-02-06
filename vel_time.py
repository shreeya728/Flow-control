%% VEL WITH TIME

file_path = '/Users/shreeyapadte/Desktop/SEM8/BTP AS4600+/pitot_tube/50cm-probe (2).xlsx';
sheet_name = 'r1-3000';
data = readmatrix(file_path, 'Sheet', sheet_name);

time = data(:, 1);
sec_column = data(:, 3);
%sec_column = sec_column;

time = time(100:3100);
sec_column = sec_column(100:3100);

time_strings = string(time);
time_datetime = datetime(time_strings, 'InputFormat', 'HHmmssSSS', 'Format', 'HH:mm:ss.SSS');
time_seconds = seconds(time_datetime - time_datetime(1));

mean_value = mean(sec_column, 'omitnan');
disp(mean_value)


figure;
plot(time_seconds, sec_column, 'LineWidth', 1.5);
hold on;
yline(mean_value, '--r', sprintf('Mean=%.4f', mean_value), 'LineWidth', 1.5);

xticks(0:10:length(sec_column));
set(gca, 'FontName', 'Serif', 'FontSize', 16);

xlabel('Time (s)', 'FontName', 'Serif', 'FontSize', 16);
ylabel('$\overrightarrow{|V|}$ (m/s)', 'Interpreter', 'latex', 'FontName', 'Serif', 'FontSize', 16);
ylim([0 12]);

grid on;

