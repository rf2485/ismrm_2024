#!/bin/bash
#SBATCH --mail-user=rf2485@nyulangone.org
#SBATCH --mail-type=ALL
#SBATCH --time=12:00:00
#SBATCH --mem=4G
#SBATCH -o ./slurm_output/diffstats/slurm-%j.out

export FREESURFER_HOME=/gpfs/share/apps/freesurfer/7.4.1/raw/freesurfer/
module load freesurfer/7.4.1
basedir=/gpfs/data/lazarlab/ADRC/
t1dir=$basedir/hippo_subfields/t1_processed
module load freesurfer/7.4.1
export SUBJECTS_DIR=$t1dir

cut -d, -f1 diff_meso_research.csv > $t1dir/subjectsfile.txt
cd $t1dir
sed -i '1d' subjectsfile.txt

meas_list=( dki_ak dki_rk dki_mk dki_kfa dti_ad dti_rd dti_md dti_fa )
for meas in "${meas_list[@]}"; do
  asegstats2table --subjectsfile=subjectsfile.txt --meas mean --stats=rh.${meas}2hippo.stats --tablefile=rh_${meas}2hippo.tsv --common-segs
  asegstats2table --subjectsfile=subjectsfile.txt --meas mean --stats=rh.hippo2${meas}.stats --tablefile=rh_hippo2${meas}.tsv --common-segs
  asegstats2table --subjectsfile=subjectsfile.txt --meas mean --stats=lh.${meas}2hippo.stats --tablefile=lh_${meas}2hippo.tsv --common-segs
  asegstats2table --subjectsfile=subjectsfile.txt --meas mean --stats=lh.hippo2${meas}.stats --tablefile=lh_hippo2${meas}.tsv --common-segs
done