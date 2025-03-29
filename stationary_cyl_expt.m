% Lift and Drag force with time
% CL and CD v/s Re compared with theoretical values

clc; clear all; close all;

% File paths
file_path = {
    '/Users/shreeyapadte/Desktop/shreeya2/500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/500_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/500_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/3000_1.csv'
    '/Users/shreeyapadte/Desktop/shreeya2/3000_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/3000_3.csv'
};

% Constants
m = 0.329;
wt = m * 9.81;
dia = 5.4 * 10^-2;  % 5.4 * 10^-2
l = 0.49;     % 49 * 10^-2
s = (dia * l)+(0.02 * 0.04) + (0.034 * 0.008);
rho = 1.18;
q = 0.5 * rho * s;
mu = 0.0000186;
v = [1, 2, 3, 4, 5]+1;
Re = v*(rho*dia/mu);  % 1 value lower considering average from top to bottom 

% Initialize storage
num_files = length(file_path);
mean_values1 = zeros(1, num_files);
mean_values2 = zeros(1, num_files);
std_1 = zeros(1, num_files);
std_2 = zeros(1, num_files);

% Read data
for f = 1:num_files
    % Read CSV file
    data = readmatrix(file_path{f});
    
    % Ensure the file has at least two columns
    if isempty(data) || size(data, 2) < 2
        warning('File %s is empty or does not have enough columns.', file_path{f});
        continue;
    end
    
    % Extract columns
    col1 = data(:, 1);
    col2 = data(:, 2);
    
    % Remove zero values
    col1 = col1(col1 ~= 0);
    col2 = col2(col2 ~= 0);

    % Compute mean only if non-empty
    if ~isempty(col1)
        mean_values1(f) = mean(col1, 'omitnan');
        std_1(f) = std(col1, 'omitnan');
    end
    if ~isempty(col2)
        mean_values2(f) = mean(col2, 'omitnan');
        std_2(f) = std(col2, 'omitnan');
    end
% 
%     % Create time vectors
%     time = 1:length(col1);
%     
%     % Plot col1 (Mean Value 1)
%     figure;
%     plot(time, col1, 'b-', 'LineWidth', 2);
%     xlabel('Number of Samples');
%     ylabel('Drag Force (N)');
%     title(['File - RPM ' num2str(f)]);
%     grid on;
% 
%     % Create time vector for col2
%     time = 1:length(col2);
%     
%     % Plot col2 (Mean Value 2)
%     figure;
%     plot(time, col2, 'r-', 'LineWidth', 2);
%     xlabel('Number of Samples');
%     ylabel('Lift Force (N)');
%     title(['File - RPM' num2str(f)]);
%     grid on;
end

% Compute grouped means
m1 = mean(mean_values1(1:3));  s1 = mean(mean_values2(1:3));
m2 = mean(mean_values1(4:6));  s2 = mean(mean_values2(4:6));
m3 = mean(mean_values1(7:9));  s3 = mean(mean_values2(7:9));
m4 = mean(mean_values1(10:12)); s4 = mean(mean_values2(10:12));
m5 = mean(mean_values1(13:15)); s5 = mean(mean_values2(13:15));
m6 = mean(mean_values1(16:18)); s6 = mean(mean_values2(16:18));

drag = [m2, m3, m4, m5, m6];
lift = [s2, s3, s4, s5, s6];
% Plot col1 (Mean Value 1)
figure;
scatter(Re, abs(drag), 'magenta', 'filled');
xlabel('Re');
ylabel('Drag Force (N)');
set(gca, 'FontName', 'Serif', 'FontSize', 14);
grid on;


% Plot col2 (Mean Value 2)
figure;
scatter(Re, abs(lift), 'green', 'filled');
xlabel('Re');
ylabel('Lift Force (N)');
set(gca, 'FontName', 'Serif', 'FontSize', 14);
grid on;

% n1 = mean(std_1(1:3));  p1 = mean(std_2(1:3));
% n2 = mean(std_1(4:6));  p2 = mean(std_2(4:6));
% n3 = mean(std_1(7:9));  p3 = mean(std_2(7:9));
% n4 = mean(std_1(10:12));  p4 = mean(std_2(10:12));
% n5 = mean(std_1(13:15));  p5 = mean(std_2(13:15));
% n6 = mean(std_1(16:18));  p6 = mean(std_2(16:18));
% 
% % Compute scaled means
mean1 = [m2/4, m3/3^2, m4/4^2, m5/5^2, m6/6^2] / q;
mean2 = [s2/4, s3/3^2, s4/4^2, s5/5^2, s6/6^2] / q;
mean1 = abs(mean1);
mean2 = abs(mean2);
% std_dev = [n3/2^2, n4/3^2, n5/4^2, n6/5^2] / q;
% 
% % Display results
% disp('CD:');
% disp(mean1);
% 
% disp('CL:');
% disp(mean2);
% 
% disp('Reynolds number:');
% disp(Re);
% 
% rpm = [500, 1000, 1500, 2000, 2500, 3000];
% 
% % theoretical
Re_sph = [2928.95, 4015.68, 5384.16, 7217.07, 9562.85, 13273.88, 18327.06, 25164.89];
Cd_sph = [0.363, 0.365, 0.370, 0.367, 0.376, 0.366, 0.389, 0.392];
Re_cyl = [2940.71, 4019.97, 5497.28, 7943.34, 10995.76, 15609.44, 21855.33];
Cd_cyl = [1.116, 1.164, 1.172, 1.263, 1.301, 1.349, 1.404];
% 
% Plot mean1 vs RPM
figure;
%plot(Re, mean1, '-o', 'LineWidth', 2, 'MarkerSize', 8);
scatter(Re, mean1, 'red', 'filled');
hold on;
%errorbar(Re, mean1, std_dev, 'b', 'LineStyle', 'none', 'HandleVisibility', 'off'); % Plot error bars
%hold on;
scatter(Re_cyl, Cd_cyl, 'black', 'filled');
scatter(Re_sph, Cd_sph, 'blue', 'filled');
xlabel('Re');
ylabel('CD');
title('CD vs Re');
legend({'Experiment', 'Schlichting Smooth cylinder', 'Schlichting Smooth sphere'});
grid on;
set(gca, 'FontName', 'Serif', 'FontSize', 14);
hold off;

% Plot mean2 vs RPM
figure;
%plot(Re, mean2, '-s', 'LineWidth', 2, 'MarkerSize', 8, 'Color', 'r');
scatter(Re, mean2, 'filled', 'square');
xlabel('Re');
ylabel('CL');
title('CL vs Re');
grid on;
set(gca, 'FontName', 'Serif', 'FontSize', 14);

%% St - fft, compared with theoretical

clc; clear all; close all;

file_path = {
    '/Users/shreeyapadte/Desktop/shreeya2/500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/3000_1.csv'
};

num_files = length(file_path);
dt = 1/10000;        % Time step (sampling at 10 kHz)
Fs = 1/dt;           % Sampling frequency
D = 0.054;           % Characteristic length (diameter)
U_values = [0.5, 1, 2, 3, 4, 5];  % Corresponding flow velocities
St_all = [];  % To store Strouhal numbers
Re_all = [];
rho = 1.18;
mu = 0.0000186;
markers = {'o', 's', 'd', '^', 'v', '>', '<', 'p', 'h', '*'};
colors = lines(num_files); 
figure; hold on;
Re_theory = round([ ...
    1396.187636033956, ...
    1862.0549329466137, ...
    2676.1602034920406, ...
    3929.211060603571, ...
    5942.810207356327, ...
    9081.204272620056, ...
    14202.384879796016, ...
    20866.285923882555], 2);

St_theory = round([ ...
    0.21937380990328234, ...
    0.2190781206747586, ...
    0.2175365941633882, ...
    0.21371234680781456, ...
    0.2108500750757048, ...
    0.20796414820531317, ...
    0.20476281949116287, ...
    0.2004812394621392], 2);


for f = 1:num_files
    data = readmatrix(file_path{f});
    if isempty(data) || size(data,2) < 2, continue; end

    signal = data(:, 2);
    signal = signal(signal ~= 0);  % Remove zeros
    signal = signal - mean(signal);  % Remove DC offset
    L = length(signal);
    if L < 2, continue; end

    % FFT
    Y = fft(signal);
    P2 = abs(Y / L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2 * P1(2:end-1);  % One-sided spectrum

    % Frequency axis
    f_axis = Fs * (0:(L/2)) / L;

    % Define valid frequency range (e.g., 2 to 30 Hz)
    f_min = 2;  % Hz
    f_max = 30; % Hz
    
    % Find indices within that range
    valid_idx = find(f_axis >= f_min & f_axis <= f_max);
    P_focus = P1(valid_idx);
    f_focus = f_axis(valid_idx);
    
    % Find peak in the restricted range
    [~, peak_rel_idx] = max(P_focus);
    f_peak = f_focus(peak_rel_idx);


    % Strouhal number
    U = U_values(f);
    St = f_peak * D / U;
    Re = rho * U * D / mu;

    Re_all(end+1) = Re;
    St_all(end+1) = St; 

    % Display
    fprintf('File %d: Peak frequency = %.2f Hz, Strouhal = %.4f\n', f, f_peak, St);

%     % Plot
%     figure;
%     plot(f_axis, P1);
%     xlabel('Frequency (Hz)');
%     ylabel('|P1(f)|');
%     title(sprintf('FFT of Lift Force - File %d', f));
%     grid on;
    marker_idx = mod(f-1, length(markers)) + 1;
    scatter(Re, St, 80, 'filled', ...
        'Marker', markers{marker_idx}, ...
        'MarkerFaceColor', colors(f,:), ...
        'DisplayName', sprintf('U=%.1f m/s', U));

end
% Plot theoretical curve
plot(Re_theory, St_theory, '--k', 'LineWidth', 2, 'DisplayName', 'Theoretical Curve');

xlabel('Reynolds Number (Re)');
ylabel('Strouhal Number (St)');
title('St vs Re');
legend('show', 'Location', 'best');
grid on;
set(gca, 'FontName', 'Serif', 'FontSize', 14);


%% checking moments

clc; clear all; close all;

% File paths
file_path = {
    '/Users/shreeyapadte/Desktop/shreeya2/500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/500_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/500_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1000_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/1500_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2000_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_1.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/2500_3.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/3000_1.csv'
    '/Users/shreeyapadte/Desktop/shreeya2/3000_2.csv',
    '/Users/shreeyapadte/Desktop/shreeya2/3000_3.csv'
};

% Constants
m = 0.329;
wt = m * 9.81;
dia = 5.4e-2;  % 5.4 * 10^-2
l = 49e-2;     % 49 * 10^-2
s = (dia * l)+(0.02 * 0.04) + (0.034 * 0.008);
rho = 1.18;
q = 0.5 * rho * s;
mu = 0.0000186;
Re = [0.5, 1, 2, 3, 4, 5]*(rho*dia/mu);  % 1 value lower considering average from top to bottom 

% Initialize storage
num_files = length(file_path);
mean_values1 = zeros(1, num_files);
mean_values2 = zeros(1, num_files);
std_1 = zeros(1, num_files);
std_2 = zeros(1, num_files);

% Read data
for f = 1:num_files
    % Read CSV file
    data = readmatrix(file_path{f});
    
    % Ensure the file has at least two columns
    if isempty(data) || size(data, 2) < 2
        warning('File %s is empty or does not have enough columns.', file_path{f});
        continue;
    end
    
    % Extract columns
    col1 = data(:, 4);  % Mx
    col2 = data(:, 5);  % My
    
    % Remove zero values
    col1 = col1(col1 ~= 0);
    col2 = col2(col2 ~= 0);

    % Compute mean only if non-empty
    if ~isempty(col1)
        mean_values1(f) = mean(col1, 'omitnan');
        std_1(f) = std(col1, 'omitnan');
    end
    if ~isempty(col2)
        mean_values2(f) = mean(col2, 'omitnan');
        std_2(f) = std(col2, 'omitnan');
    end
% 
    % Create time vectors
    time = 1:length(col1);
    
    % Plot col1 (Mean Value 1)
    figure;
    plot(time, col1, 'b-', 'LineWidth', 2);
    xlabel('Number of Samples');
    ylabel('Drag Force (N)');
    title(['File - RPM ' num2str(f)]);
    grid on;

    % Create time vector for col2
    time = 1:length(col2);
    
    % Plot col2 (Mean Value 2)
    figure;
    plot(time, col2, 'r-', 'LineWidth', 2);
    xlabel('Number of Samples');
    ylabel('Lift Force (N)');
    title(['File - RPM' num2str(f)]);
    grid on;
end


