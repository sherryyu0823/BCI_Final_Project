% This code performs ICA on raw data (.cnt) and converts it to .set format
addpath('D:\eeglab_current\eeglab2024.0');
addpath('D:\BCI\Final_project\FastICA_25');

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
data_folder = 'D:\BCI\Final_project\ROI';
results_folder = 'D:\BCI\Final_project\Result';
if ~exist(results_folder, 'dir')
    mkdir(results_folder);
end

% Load CNT
cnt_files = dir(fullfile(data_folder, '*.cnt'));
% Choose Channel to keep
channels_to_keep = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', 'CP1', ...
                    'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', 'Fz', 'F4', ...
                    'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', 'CP2', 'P4', 'P8', ...
                    'PO4', 'O2'};
% Initialization
categories = {'Brain', 'Muscle', 'Eye', 'Heart', 'Line Noise', 'Channel Noise', 'Other'};
results = zeros(length(categories), 3); % Raw, Filtered, ASR-Corrected


for i = 1:length(cnt_files)
    EEG = pop_loadcnt(fullfile(cnt_files(i).folder, cnt_files(i).name), 'dataformat', 'auto');
    EEG = pop_select(EEG, 'channel', channels_to_keep);
    
    % Downsampling to 256Hz
    EEG = pop_resample(EEG, 256);
    
    % Perform FastICA on the raw data.
    EEG_raw = pop_runica(EEG, 'icatype', 'fastica');

    % Save data
    save_path_ica = fullfile(results_folder, [cnt_files(i).name(1:end-4), '_ica.set']);
    pop_saveset(EEG_raw, 'filename', save_path_ica);

end