#!/bin/bash
#SBATCH --mail-user=rf2485@nyulangone.org
#SBATCH --mail-type=ALL
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --array=1-194
#SBATCH -o ./slurm_output/mprage2diff/slurm-%A_%a.out

subj_list=$(cut -d, -f1 diff_meso_research.csv)
subj_list=($subj_list)
list_index=$(($SLURM_ARRAY_TASK_ID-1))
subj=${subj_list[$list_index]}

basedir=/gpfs/data/lazarlab/ADRC/
dwidir=$basedir/hippo_subfields/dwi_processed/
t1dir=$basedir/hippo_subfields/t1_processed
mri_folder=$t1dir/$subj/mri
stats_folder=$t1dir/$subj/stats

module load fsl/.6.0.6
export LD_LIBRARY_PATH=/lib
module load freesurfer/7.4.1
export SUBJECTS_DIR=$t1dir

fslmaths $dwidir/$subj/B0.nii -mul $dwidir/$subj/brain_mask.nii $mri_folder/B0_brain.nii
cd $mri_folder/
bbregister --s ${subj} --mov $mri_folder/B0_brain.nii.gz --reg $mri_folder/b02fs.lta --dti --init-fsl
vol2subfield --i $mri_folder/B0_brain.nii.gz --reg $mri_folder/b02fs.lta --sf $mri_folder/rh.hippoAmygLabels-T1-FLAIR.v22.HBT.mgz --outreg $mri_folder/rh.diff2hippo.lta
mri_vol2vol --mov $mri_folder/B0_brain.nii.gz --targ $mri_folder/rh.hippoAmygLabels-T1-FLAIR.v22.HBT.mgz --inv --interp nearest --o $mri_folder/rh.hippo2diff.nii --reg $mri_folder/rh.diff2hippo.lta --no-save-reg
vol2subfield --i $mri_folder/B0_brain.nii.gz --reg $mri_folder/b02fs.lta --sf $mri_folder/lh.hippoAmygLabels-T1-FLAIR.v22.HBT.mgz --outreg $mri_folder/lh.diff2hippo.lta
mri_vol2vol --mov $mri_folder/B0_brain.nii.gz --targ $mri_folder/lh.hippoAmygLabels-T1-FLAIR.v22.HBT.mgz --inv --interp nearest --o $mri_folder/lh.hippo2diff.nii --reg $mri_folder/lh.diff2hippo.lta --no-save-reg

meas_list=( dki_ak dki_rk dki_mk dki_kfa dti_ad dti_rd dti_md dti_fa )
for meas in "${meas_list[@]}"; do
  vol2subfield --i $dwidir/$subj/metrics/${meas}.nii --reg $mri_folder/b02fs.lta --sf $mri_folder/rh.hippoAmygLabels-T1-FLAIR.v22.HBT.mgz --o $mri_folder/rh.${meas}2hippo.nii --stats $stats_folder/rh.${meas}2hippo.stats
  vol2subfield --i $dwidir/$subj/metrics/${meas}.nii --reg $mri_folder/b02fs.lta --sf $mri_folder/lh.hippoAmygLabels-T1-FLAIR.v22.HBT.mgz --o $mri_folder/lh.${meas}2hippo.nii --stats $stats_folder/lh.${meas}2hippo.stats
	mri_segstats --seg $mri_folder/rh.hippo2diff.nii --ctab $FREESURFER_HOME/FreeSurferColorLUT.txt --i $dwidir/$subj/metrics/${meas}.nii --sum $stats_folder/rh.hippo2${meas}.stats
	mri_segstats --seg $mri_folder/lh.hippo2diff.nii --ctab $FREESURFER_HOME/FreeSurferColorLUT.txt --i $dwidir/$subj/metrics/${meas}.nii --sum $stats_folder/lh.hippo2${meas}.stats
done
