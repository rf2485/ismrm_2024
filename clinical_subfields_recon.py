# -*- coding: utf-8 -*-
"""
Analysis of Hippocampal Subfields with DTI and DKI.
"""
from bids.layout import BIDSLayout
import os
import pandas as pd
import numpy as np

# file path handling
base_dir = "/Volumes/Research/lazarm03lab/labspace/AD/ADRC"
cluster_dir = "/gpfs/data/lazarlab/ADRC"
raw = os.path.join(base_dir, "ADRC_data/bids")
cluster_raw = os.path.join(cluster_dir, "bids")
project_dir = os.path.join(base_dir, "hippo_subfields")
cluster_project = os.path.join(cluster_dir, "hippo_subfields")
file_df_path = os.path.join(project_dir, "file_df.csv")

# %%
# layout = BIDSLayout(raw)  # generate layout (takes a long time)
# layout.save(project_dir)  # save to file so we don't have to do it again
# layout = BIDSLayout.load(project_dir) # reload layout (takes a while)

# file_df = layout.to_df()  # create df that represents layout (takes a long time)
# file_df.to_csv(file_df_path, index=False)  # save to file

# %%
# read layout df from file
file_df = pd.read_csv(file_df_path)
# convert subject and session to proper format
file_df['subject'] = file_df['subject'].astype(
    str).str.removesuffix('.0').str.zfill(4).replace('0nan', np.NaN)
file_df['session'] = file_df['session'].astype(
    str).str.removesuffix('.0').str.zfill(4).replace('0nan', np.NaN)
# replace beginning of paths (raw) with cluster_raw
file_list = file_df.path
file_list = [f.replace(raw, cluster_raw) for f in file_list]
file_df.path = file_list

# %%
# available MPRAGE and FLAIR scans
anat_df = file_df[(file_df.datatype == "anat") &
                  (file_df.extension == ".nii.gz")]
anat_suffix_list = anat_df.suffix.unique()
mprage_list = anat_df[(anat_df.suffix == "T1w") & (
    anat_df.acquisition == 'SAGMPRISO')].subject.unique()
flair_list = anat_df[(anat_df.suffix == "FLAIR") & (
    anat_df.acquisition == 'AX')].subject.unique()
mprage_flair_list = [i for i in mprage_list if i in flair_list]

print("Do all MPRAGE subjects have FLAIR?", len(
    mprage_flair_list) == len(mprage_list))
mprage_not_flair_list = [i for i in mprage_list if i not in flair_list]
# 1 subject has MPRAGE but not FLAIR
print("Subjects with MPRAGE but not FLAIR:", mprage_not_flair_list)
flair_not_mprage_list = [i for i in flair_list if i not in mprage_list]
# 3 subjects have FLAIR but not MPRAGE
print("Subjects with FLAIR but not MPRAGE:", flair_not_mprage_list)

# available DIFFmeso and DIFFmesoresearch scans
dwi_df = file_df[(file_df.datatype == "dwi") &
                 (file_df.extension == ".nii.gz")]
dwi_acq_list = dwi_df.acquisition.unique()
diff_meso_list = dwi_df[dwi_df.acquisition == "DIFFmeso"].subject.unique()
diff_meso_research_list = dwi_df[dwi_df.acquisition ==
                                 "DIFFmesoresearch"].subject.unique()

meso_mprage_list = [i for i in diff_meso_list if i in mprage_list]
# all diff_meso subjects have MPRAGE
print("Do all diff_meso subjects have MPRAGE?",
      len(diff_meso_list) == len(meso_mprage_list))
meso_flair_list = [i for i in diff_meso_list if i in flair_list]
# all diff_meso subjects have FLAIR
print("Do all diff_meso subjects have FLAIR?",
      len(diff_meso_list) == len(meso_flair_list))

meso_research_mprage_list = [
    i for i in diff_meso_research_list if i in mprage_list]
# all diff_meso_research subejcts have MPRAGE
print("Do all diff_meso_research participants have MPRAGE?", len(
    diff_meso_research_list) == len(meso_research_mprage_list))
meso_research_flair_list = [
    i for i in diff_meso_research_list if i in flair_list]
# all diff_meso_research subjects have FLAIR
print("Do all diff_meso_research participants have FLAIR?", len(
    diff_meso_research_list) == len(meso_research_flair_list))

meso_and_meso_research_list = [
    i for i in diff_meso_research_list if i in diff_meso_list]
# all meso diff research also have diff meso
print("Do all diff_meso_research participants also have diff_meso scans?",
      len(diff_meso_research_list) == len(meso_and_meso_research_list))


# %%
# list of PA diffmeso file names
diff_meso_pa_df = dwi_df[(dwi_df.acquisition == "DIFFmeso") &
                         (dwi_df.direction == "PA") &
                         (dwi_df.run == 1)]
diff_meso_pa_df = diff_meso_pa_df[['subject', 'session', 'path']].rename(
    columns={"path": "PA_path"})
# list of diffmeso PA file names
diff_meso_df = dwi_df[(dwi_df.acquisition == "DIFFmeso") &
                      (pd.isnull(dwi_df.direction)) &
                      (pd.isnull(dwi_df.reconstruction)) &
                      (dwi_df.run == 1) &
                      (dwi_df['session'].isin(diff_meso_pa_df['session']))]
diff_meso_df = diff_meso_df[['subject', 'session', 'path']].rename(
    columns={"path": "diff_meso_path"})
diff_meso_df = pd.merge(diff_meso_df, diff_meso_pa_df,
                        on=['subject', 'session'])
# list of diffmesoresearch file names
diff_meso_research_df = dwi_df[(dwi_df.acquisition == "DIFFmesoresearch") &
                               (pd.isnull(dwi_df.direction)) &
                               (pd.isnull(dwi_df.reconstruction)) &
                               (dwi_df.run == 1)]
diff_meso_research_df = diff_meso_research_df[['subject', 'session', 'path']].rename(
    columns={"path": "diff_meso_research_path"})
diff_meso_research_df = pd.merge(
    diff_meso_research_df, diff_meso_df, on=['subject', 'session'])
# List of MPRAGE filenames
mprage_df = anat_df[(anat_df.suffix == "T1w") & (
    anat_df.acquisition == 'SAGMPRISO')]
# last MPRAGE run for each session
mprage_df = mprage_df.groupby(['subject', 'session'], as_index=False).last()
mprage_df = mprage_df[['subject', 'session', 'path']].rename(
    columns={"path": "MPRAGE_path"})
diff_meso_research_df = pd.merge(
    diff_meso_research_df, mprage_df, on=['subject', 'session'])
# list of FLAIR file names
flair_df = anat_df[(anat_df.suffix == "FLAIR") & (
    anat_df.acquisition == 'AX')]
# last FLAIR run per session
flair_df = flair_df.groupby(['subject', 'session'], as_index=False).last()
flair_df = flair_df[['subject', 'session', 'path']].rename(
    columns={"path": "FLAIR_path"})
diff_meso_research_df = pd.merge(
    diff_meso_research_df, flair_df, on=['subject', 'session'])
# only one subject has multiple timepoints with the same protocol (two without FLAIR). Select most recent session.
diff_meso_research_df = diff_meso_research_df.groupby(
    ['subject'], as_index=False).last()

# save to file
diff_meso_research_df.to_csv(os.path.join(
    project_dir, "diff_meso_research.csv"), index=False)
diff_meso_research_df['subject'].to_csv(os.path.join(
    project_dir, "subjectsfile.txt"), index=False, header=False)
