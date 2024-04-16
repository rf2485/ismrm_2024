#!/bin/bash
#SBATCH --mail-user=rf2485@nyulangone.org
#SBATCH --mail-type=ALL
#SBATCH	--gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --mem=16G
#SBATCH --array=1-194
#SBATCH -o ./slurm_output/pydesigner/slurm-%A_%a.out

basedir=/gpfs/data/lazarlab/ADRC/
dwidir=$basedir/hippo_subfields/dwi_processed/

subj_list=$(cut -d, -f1 diff_meso_research.csv)

###### dwi processing ######
module load miniconda3/gpu/4.9.2
# conda create -n pyd python=3.7
conda activate pyd
# pip install packaging
# pip install PyDesigner-DWI --user
# conda install -c mrtrix3 mrtrix3=3.0.4
module load fsl/.6.0.6

export LD_LIBRARY_PATH=/lib

PA_path_list=$(cut -d, -f5 diff_meso_research.csv)
diff_meso_path_list=$(cut -d, -f4 diff_meso_research.csv)
diff_meso_research_path_list=$(cut -d, -f3 diff_meso_research.csv)
subj_list=($subj_list)
PA_path_list=($PA_path_list)
diff_meso_path_list=($diff_meso_path_list)
diff_meso_research_path_list=($diff_meso_research_path_list)
list_index=$(($SLURM_ARRAY_TASK_ID-1))
subj=${subj_list[$list_index]}
PA_path=${PA_path_list[$list_index]}
diff_meso_path=${diff_meso_path_list[$list_index]}
diff_meso_research_path=${diff_meso_research_path_list[$list_index]}

mkdir -p $dwidir/$subj/
pydesigner -s --verbose --rpe_pairs 1 -o $dwidir/$subj/ $PA_path $diff_meso_path $diff_meso_research_path

dwifslpreproc -eddy_options "--data_is_shelled --repol --slm=linear" \
	-rpe_header -eddyqc_all $dwidir/$subj/metrics_qc/eddy \
	$dwidir/$subj/working.mif $dwidir/$subj/3_dwi_undistorted.mif

rm $dwidir/$subj/dwiec.bv*
rm $dwidir/$subj/B0_EPI.mif
intermediate=$dwidir/$subj/intermediate_nifti/3_dwi_undistorted
mrconvert -export_grad_fsl $intermediate.bvec $intermediate.bval -json_export $intermediate.json \
    $dwidir/$subj/3_dwi_undistorted.mif $intermediate.nii
mv $dwidir/$subj/3_dwi_undistorted.mif $dwidir/$subj/working.mif

pydesigner -s --verbose --rpe_pairs 1 --resume -o $dwidir/$subj/ $PA_path $diff_meso_path $diff_meso_research_path
