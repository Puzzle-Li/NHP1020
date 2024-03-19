fp_nii = '\\172.16.6.4\lglab\Projects\monkey_tes_sleep\0291\surgery\elec_loc\img\3dslc';

fn_T1 = 'inskull.nii';
fn_CT = 'CT_skull.nii';

%% Repair q-form in nii file

nii = load_nii(fullfile(fp_nii,fn_T1));

M_affine = [nii.hdr.hist.srow_x; nii.hdr.hist.srow_y; nii.hdr.hist.srow_z];
resolution = nii.hdr.dime.pixdim(2:4); 
M_rotate = eye(3);
for ii = 1:3
    M_rotate(:,ii) = M_affine(:,ii)/resolution(ii);
end

quat = dcm2quat(M_rotate);
if sum(sign(quat(2:end)))<0
    quat = -quat;
end
nii.hdr.hist.quatern_b = quat(2);
nii.hdr.hist.quatern_c = quat(3);
nii.hdr.hist.quatern_d = quat(4);

nii.hdr.hist.qoffset_x = nii.hdr.hist.srow_x(4);
nii.hdr.hist.qoffset_y = nii.hdr.hist.srow_y(4);
nii.hdr.hist.qoffset_z = nii.hdr.hist.srow_z(4); 

save_nii(nii,fullfile(fp_nii,fn_T1));

%% Reslice T1 mask

reslice_nii(fullfile(fp_nii,fn_T1), fullfile(fp_nii,fn_T1), 0.5);

%% Reslice CT based T1

matlabbatch{1}.spm.spatial.coreg.write.ref = {[fullfile(fp_nii,fn_T1), ',1']};
matlabbatch{1}.spm.spatial.coreg.write.source = {[fullfile(fp_nii,fn_CT), ',1']};
matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = 4;
matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = 'r';

spm_jobman('run',matlabbatch);

%% Change names and formats

movefile(fullfile(fp_nii,['r' fn_CT]), fullfile(fp_nii,fn_CT));
gzip(fullfile(fp_nii,fn_CT))
gzip(fullfile(fp_nii,fn_T1))