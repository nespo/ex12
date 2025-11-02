% ex12_main.m
% Exercise 12 – FIR Low-Pass via direct formula (sinc) and comparison
% Creates figures for M=20 and M=64 and saves them in ./figures
% Author: <your name>    Date: <yyyy-mm-dd>

clear; close all; clc;

% -------------------- parameters --------------------
wc = 1;                 % cutoff (radians/sample)
Ms = [20, 64];          % filter orders to test
Nfft = 1024;            % FFT length for smooth response
outdir = fullfile(pwd,'figures');
if ~exist(outdir,'dir'), mkdir(outdir); end

% -------------------- run for each M --------------------
allW = []; allMag = [];  % store for comparison

for k = 1:numel(Ms)
    M = Ms(k);
    n = 0:M;                            % 0..M (length M+1)
    hLP = sin(wc*(n - M/2)) ./ (pi*(n - M/2));
    hLP(n == M/2) = wc/pi;              % handle n = M/2

    % ----- frequency response -----
    H = fft(hLP, Nfft);
    w = linspace(-pi, pi, Nfft);
    Hmag = abs(fftshift(H));

    % ----- plot: impulse response -----
    f1 = figure('Color','w'); 
    stem(n, hLP, 'filled'); grid on;
    title(sprintf('Impulse Response h_{LP}(n), M = %d', M));
    xlabel('n'); ylabel('h_{LP}(n)');
    xlim([0 M]);
    savepng(f1, fullfile(outdir, sprintf('hLP_M%d.png', M)));

    % ----- plot: magnitude response -----
    f2 = figure('Color','w');
    plot(w/pi, Hmag, 'LineWidth', 1.2); grid on;
    title(sprintf('Magnitude Response |H_{LP}(e^{j\\omega})|, M = %d', M));
    xlabel('\omega/\pi'); ylabel('|H_{LP}|');
    xlim([-1 1]);
    ylim([0 1.1*max(Hmag)]);
    savepng(f2, fullfile(outdir, sprintf('HLP_M%d.png', M)));

    % store for comparison figure
    if isempty(allW), allW = w; end
    allMag = [allMag; Hmag]; %#ok<AGROW>
end

% -------------------- comparison plot --------------------
fc = figure('Color','w');
plot(allW/pi, allMag(1,:), 'LineWidth', 1.25); hold on;
plot(allW/pi, allMag(2,:), 'LineWidth', 1.25); grid on;
legend(arrayfun(@(m)sprintf('M = %d',m), Ms, 'UniformOutput', false), ...
       'Location','SouthWest');
title('Comparison of |H_{LP}(e^{j\omega})| for Different Orders');
xlabel('\omega/\pi'); ylabel('|H_{LP}|'); xlim([-1 1]);
savepng(fc, fullfile(outdir, 'HLP_compare.png'));

disp('Done. Files saved in ./figures:');
disp({'hLP_M20.png','HLP_M20.png','hLP_M64.png','HLP_M64.png','HLP_compare.png'});

% -------------------- helper: robust saver --------------------
function savepng(fig, filename)
% Try exportgraphics (R2020a+). Fallback to saveas for older MATLAB/Octave.
    [~,~,ext] = fileparts(filename);
    if isempty(ext), filename = [filename '.png']; end
    try
        exportgraphics(fig, filename, 'Resolution', 200);
    catch
        try
            saveas(fig, filename);
        catch ME
            warning('Could not save figure to %s: %s', filename, ME.message);
        end
    end
end
