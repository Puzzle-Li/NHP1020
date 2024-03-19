clc;
clear;

monkey = '741';
path_vast = fullfile('\\172.16.6.4\lglab\Data\monkeys\Vasst', monkey);
path_img = fullfile('\\172.16.6.4\lglab\Projects\monkey_tes_sleep', monkey, 'surgery\elec_loc\img');
if ~isfolder(path_img), mkdir(path_img); end
if ~isfolder(fullfile(path_img, 'seg')), mkdir(fullfile(path_img, 'seg')); end

%% 定义文件名
path_vast = fullfile('\\172.16.6.4\lglab\Data\monkeys\Vasst', monkey);
path_img = fullfile('\\172.16.6.4\lglab\Projects\monkey_tes_sleep', monkey, 'surgery\elec_loc\img');
files = {[monkey '.nii']
    'brain.nii'
    [monkey '_mask.nii']
    ['CHARM_1_in_' monkey '.nii']
    ['CHARM_2_in_' monkey '.nii']
    ['CHARM_3_in_' monkey '.nii']
    ['CHARM_4_in_' monkey '.nii']
    ['CHARM_5_in_' monkey '.nii']
    ['CHARM_6_in_' monkey '.nii']
    ['SARM_1_in_' monkey '.nii']
    ['SARM_2_in_' monkey '.nii']
    ['SARM_3_in_' monkey '.nii']
    ['SARM_4_in_' monkey '.nii']
    ['SARM_5_in_' monkey '.nii']
    ['SARM_6_in_' monkey '.nii']
    ['SEG_in_' monkey '.nii']
    };

%% 复制文件并解压

copyfile(fullfile(path_vast, files{1}), fullfile(path_img));
for i = 2:length(files)
    copyfile(fullfile(path_vast, files{i}), fullfile(path_img, 'seg'));
end

%%
for i = 2:length(files)
    lpz_copyNiiHdr(fullfile(path_img, 'seg', files{i}), fullfile(path_img,'T1_conform_reo.nii'));
end

