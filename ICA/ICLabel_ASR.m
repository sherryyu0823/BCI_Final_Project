addpath('D:\eeglab_current\eeglab2024.0');
addpath('D:\BCI\Final_project\FastICA_25');

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
data_folder = 'D:\BCI\Final_project\Result';
results_folder = 'D:\BCI\Final_project\Results';

% load all dataset files
set_files = dir(fullfile(data_folder, '*.set'));
disp(length(set_files))

% Choose Channel to keep
channels_to_keep = {'Fp1', 'AF3', 'F3', 'F7', 'FC5', 'FC1', 'C3', 'T7', 'CP5', 'CP1', ...
                    'P3', 'P7', 'PO3', 'O1', 'Oz', 'Pz', 'Fp2', 'AF4', 'Fz', 'F4', ...
                    'F8', 'FC6', 'FC2', 'Cz', 'C4', 'T8', 'CP6', 'CP2', 'P4', 'P8', ...
                    'PO4', 'O2'};
% Initialization
categories = {'Brain', 'Muscle', 'Eye', 'Heart', 'Line Noise', 'Channel Noise', 'Other'};
results = zeros(length(categories), 3); % Raw, Filtered, ASR-Corrected
chanlocs_file = 'D:\\eeglab_current\\eeglab2024.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; % 通道位置文件路径
chanlocs = readlocs(chanlocs_file);

% Iterate all sets
for i = 1:length(set_files)
    EEG_raw = pop_loadset('filename', set_files(i).name, 'filepath', set_files(i).folder);

    % -------Debug information-------
    disp(['Processing file: ', set_files(i).name]);
    disp(['EEG_raw.data size: ', mat2str(size(EEG_raw.data))]);
    disp(['EEG_raw.icawinv size: ', mat2str(size(EEG_raw.icawinv))]);
    disp(['EEG_raw.chanlocs size: ', mat2str(size(EEG_raw.chanlocs))]);
    disp(['EEG_raw.icachansind size: ', mat2str(size(EEG_raw.icachansind))]);
    
    if isempty(EEG_raw.icaact)
        disp(['icaact is empty, manually calculating for file: ', set_files(i).name]);
        EEG_raw.icaact = (EEG_raw.icaweights * EEG_raw.icasphere) * EEG_raw.data(EEG_raw.icachansind, :);
    end
    
    if isempty(EEG_raw.icaact)
        disp(['Error: icaact is still empty after manual calculation for file: ', set_files(i).name]);
        continue; 
    end
    required_fields = {'data', 'icawinv', 'icasphere', 'icaweights', 'icaact', 'chanlocs', 'icachansind'};
    missing_fields = setdiff(required_fields, fieldnames(EEG_raw));
    if ~isempty(missing_fields)
        disp(['Error: Missing fields for iclabel: ', strjoin(missing_fields, ', ')]);
        continue; 
    end
    % -------------------------------------

    % Run ICLabel
    try
        EEG_raw = iclabel(EEG_raw);
    catch ME
        disp(['Error in iclabel for file: ', set_files(i).name]);
        disp(ME.message);
        continue;
    end
    
    labels_raw = EEG_raw.etc.ic_classification.ICLabel.classifications;
    counts_raw = sum(labels_raw > 0.5, 1);  % Count the number of ICs in each category.
    results(:, 1) = results(:, 1) + counts_raw(:);
    labels_raw = EEG_raw.etc.ic_classification.ICLabel.classifications;
    counts_raw = sum(labels_raw > 0.5, 1);  % Count the number of ICs in each category.
    results(:, 1) = results(:, 1) + counts_raw(:);
    
    % Save data
    save_path_ica = fullfile(results_folder, [set_files(i).name(1:end-4), '_ica.set']);
    pop_saveset(EEG_raw, 'filename', save_path_ica);
    
    % Perform FastICA on the filtered data.
    EEG_filtered = pop_eegfiltnew(EEG_raw, 1, 50);
    EEG_filtered = pop_runica(EEG_filtered, 'icatype', 'fastica');

%     EEG_filtered.icaact = [];
%     EEG_filtered.icachansind = 1:size(EEG_filtered.data, 1); 
    EEG_filtered = pop_iclabel(EEG_filtered);
    
    labels_filtered = EEG_filtered.etc.ic_classification.ICLabel.classifications;
    counts_filtered = sum(labels_filtered > 0.5, 1);  % Count the number of ICs in each category.
    results(:, 2) = results(:, 2) + counts_filtered(:);
    
    % Perform FastICA on the ASR-corrected data.
    EEG_ASR = clean_rawdata(EEG_raw, -1, -1, 0.8, 4, -1, 0.5);
    EEG_ASR = pop_runica(EEG_ASR, 'icatype', 'fastica');
    EEG_ASR = pop_iclabel(EEG_ASR);
    labels_ASR = EEG_ASR.etc.ic_classification.ICLabel.classifications;
    counts_ASR = sum(labels_ASR > 0.5, 1);  % Count the number of ICs in each category.
    results(:, 3) = results(:, 3) + counts_ASR(:);
    
    % Save data
    save_path_asr = fullfile(results_folder, [set_files(i).name(1:end-4), '_asr.set']);
    pop_saveset(EEG_ASR, 'filename', save_path_asr);
end

%  Calculate Results and save as csv
results = results / length(set_files);
results_table = array2table(results, 'VariableNames', {'Raw', 'Filtered', 'ASR_Corrected'}, 'RowNames', categories);
writetable(results_table, fullfile(data_folder, 'ICA_results.csv'), 'WriteRowNames', true);
disp(results_table);

% Draw Figure
figure;
bar(results');
set(gca, 'XTickLabel', {'Raw', 'Filtered', 'ASR-Corrected'});
legend(categories, 'Location', 'northwest');
xlabel('Pre-processing Method');
ylabel('Average Number of ICs');
title('Average Number of ICs Classified by ICLabel');
grid on;
