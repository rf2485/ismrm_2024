#!/bin/bash
#SBATCH --mail-user=rf2485@nyulangone.org
#SBATCH --mail-type=ALL
#SBATCH	--gres=gpu:1 -p radiology
#SBATCH --time=03:00:00
#SBATCH --mem=16G
#SBATCH --array=1-194
#SBATCH -o ./slurm_output/pydesigner/slurm-%A_%a.out

# basedir=/gpfs/data/lazarlab/ADRC/
# dwidir=$basedir/hippo_subfields/dwi_processed/
#
# subj_list=$(cut -d, -f1 diff_meso_research.csv)
# PA_path_list=$(cut -d, -f5 diff_meso_research.csv)
# diff_meso_path_list=$(cut -d, -f4 diff_meso_research.csv)
# diff_meso_research_path_list=$(cut -d, -f3 diff_meso_research.csv)
# subj_list=($subj_list)
# PA_path_list=($PA_path_list)
# diff_meso_path_list=($diff_meso_path_list)
# diff_meso_research_path_list=($diff_meso_research_path_list)
# list_index=$(($SLURM_ARRAY_TASK_ID-1))
# subj=${subj_list[$list_index]}
# PA_path=${PA_path_list[$list_index]}
# diff_meso_path=${diff_meso_path_list[$list_index]}
# diff_meso_research_path=${diff_meso_research_path_list[$list_index]}

srun --nodes=1 --ntasks=1 --tasks-per-node=1 --cpus-per-task=2 --time=03:00:00 --mem=16G --pty bash
module load singularity/3.9.8
# singularity pull docker://dmri/neurodock
# neurodock_latest.sif /gpfs/data/lazarlab/
singularity shell --bind /gpfs/data/lazarlab/ADRC/ /gpfs/data/lazarlab/neurodock_latest.sif
mkdir 0831_new
cd 0831_new
PA_path=/gpfs/data/lazarlab/ADRC/bids/sub-0831/ses-20171110/dwi/sub-0831_ses-20171110_acq-DIFFmeso_dir-PA_run-1_dwi.nii.gz
diff_meso_path=/gpfs/data/lazarlab/ADRC/bids/sub-0831/ses-20171110/dwi/sub-0831_ses-20171110_acq-DIFFmeso_run-1_dwi.nii.gz
diff_meso_research_path=/gpfs/data/lazarlab/ADRC/bids/sub-0831/ses-20171110/dwi/sub-0831_ses-20171110_acq-DIFFmesoresearch_run-1_dwi.nii.gz
pydesigner -s --verbose --nthreads 2 --rpe_pairs 1 -o . $PA_path $diff_meso_path $diff_meso_research_path
exit
exit
srun --gres=gpu:1 -p radiology --time=01:00:00 --mem=16G --pty bash
module load singularity/3.9.8
module load cuda/11.8
singularity shell --nv --bind /gpfs/data/lazarlab/ADRC/ /gpfs/data/lazarlab/neurodock_latest.sif
dwifslpreproc -eddy_options "--data_is_shelled --repol --slm=linear" \
	-rpe_header -eddyqc_all metrics_qc/eddy \
	working.mif 3_dwi_undistorted.mif
rm dwiec.bv*
rm B0_EPI.mif
intermediate=intermediate_nifti/3_dwi_undistorted
mrconvert -export_grad_fsl $intermediate.bvec $intermediate.bval -json_export $intermediate.json \
    3_dwi_undistorted.mif $intermediate.nii
mv 3_dwi_undistorted.mif working.mif
exit
exit
srun --nodes=1 --ntasks=1 --tasks-per-node=1 --cpus-per-task=2 --time=03:00:00 --mem=16G --pty bash
module load singularity/3.9.8
singularity shell --bind /gpfs/data/lazarlab/ADRC/ /gpfs/data/lazarlab/neurodock_latest.sif
pydesigner -s --verbose --nthreads 2 --rpe_pairs 1 --resume -o . $PA_path $diff_meso_path $diff_meso_research_path

#without B250
mv dwi_preprocessed.bvec dwi_preprocessed_all.bvec
mv dwi_preprocessed.bval dwi_preprocessed_all.bval
mv dwi_preprocessed.json dwi_preprocessed_all.json
mv dwi_preprocessed.nii dwi_preprocessed_all.nii
mrconvert -fslgrad dwi_preprocessed_all.bvec dwi_preprocessed_all.bval -json_import dwi_preprocessed_all.json dwi_preprocessed_all.nii dwi_preprocessed_all.mif
dwiextract -shells 0,1000,2000 dwi_preprocessed_irlls.mif dwi_preprocessed_nob250.mif
mrconvert -export_grad_fsl dwi_preprocessed.bvec dwi_preprocessed.bval -json_export dwi_preprocessed.json dwi_preprocessed_nob250.mif dwi_preprocessed.nii
rm csf_mask.nii
rm S*
rm B0_* 
rm b*
pydesigner -s --verbose --nthreads 2 --rpe_pairs 1 --fit_constraints 1,1,1 --resume -o . $PA_path $diff_meso_path $diff_meso_research_path
tensor2metric metrics/DT.nii -vector metrics/V1.nii