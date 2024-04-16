###### MPRAGE processing ######
#!/bin/bash
#SBATCH --mail-user=rf2485@nyulangone.org
#SBATCH --mail-type=ALL
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --array=1-194
#SBATCH -o ./slurm_output/recon/slurm-%A_%a.out

basedir=/gpfs/data/lazarlab/ADRC/

t1dir=$basedir/hippo_subfields/t1_processed
mkdir -p $t1dir

subj_list=$(cut -d, -f1 diff_meso_research.csv)
subj_list=($subj_list)
list_index=$(($SLURM_ARRAY_TASK_ID-1))
subj=${subj_list[$list_index]}
MPRAGE_path_list=$(cut -d, -f6 diff_meso_research.csv)
MPRAGE_path_list=($MPRAGE_path_list)
MPRAGE_path=${MPRAGE_path_list[$list_index]}

module load freesurfer/7.4.1
export SUBJECTS_DIR=$t1dir
recon-all-clinical.sh $MPRAGE_path $subj 4 $t1dir
###### hippocampal subfields segmentation ######
session_list=$(cut -d, -f2 diff_meso_research.csv)
session_list=($session_list)
ses=${session_list[$list_index]}

rawdir=$basedir/bids
mri_folder=$t1dir/$subj/mri
i=0
for mprage in $rawdir/sub-${subj}/ses-${ses}/anat/sub-${subj}_ses-${ses}_acq-SAGMPRISO_run*_T1w.nii.gz; do
  i=$((${i}+1))
  mri_convert $rawdir/sub-${subj}/ses-${ses}/anat/sub-${subj}_ses-${ses}_acq-SAGMPRISO_run-${i}_T1w.nii.gz $mri_folder/orig/00${i}.mgz
done

recon-all -no-isrunning -motioncor -talairach -nuintensitycor -normalization -gcareg -pctsurfcon -segstats -wmparc -balabels -subjid ${subj} -sd ${t1dir} 

FLAIR_path_list=$(cut -d, -f7 diff_meso_research.csv)
FLAIR_path_list=($FLAIR_path_list)
FLAIR_path=${FLAIR_path_list[$list_index]}


mri_easyreg --ref $mri_folder/norm.mgz --flo ${FLAIR_path} \
    --ref_seg $mri_folder/synthseg.mgz --flo_seg $mri_folder/FLAIRseg.mgz \
      --flo_reg $mri_folder/FLAIR_reg.mgz --threads -1 --affine_only

segmentHA_T2.sh ${subj} $mri_folder/FLAIR_reg.mgz FLAIR 1 ${t1dir}
