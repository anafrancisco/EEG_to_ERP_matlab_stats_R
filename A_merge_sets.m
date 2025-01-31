% EEGLAB merge sets, and creates .set file
% by Douwe Horsthuis on 3/24/2021
% ------------------------------------------------
eeglab
subject_list = {'some sort of ID' 'a different id for a different particpant'}; %all the IDs for the indivual particpants
filename= 'the_rest_of_the_file_name'; % if your bdf file has a name besides the ID of the participant
home_path  = 'path_where_to_load_in_pc'; %place data is
save_path  = 'path_where_to_save_in_pc'; %place you want to save data
blocks = 5; % the amount of BDF files. if different participant have different blocks, run the separate
ref_chan = [65 66] % these are normally the mastoids. BIOSEMI should have ref, but you can load it without
for s = 1:length(subject_list)
disp([home_path  subject_list{s} '_' filename '.bdf'])
if blocks == 1
    EEG = pop_biosig([home_path  subject_list{s} '_' filename '.bdf'], 'ref', ref_chan ,'refoptions',{'keepref' 'off'}); %
else
    for bdf_bl = 1:blocks
        EEG = pop_biosig([home_path  subject_list{s} '_' filename '_' num2str(bdf_bl) '.bdf'], 'ref', ref_chan ,'refoptions',{'keepref' 'off'}); %
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    end
    EEG = pop_mergeset( ALLEEG, [1:blocks], 0);
    EEG = pop_saveset( EEG, 'filename',[subject_list{s} '.set'],'filepath',save_path);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end
end