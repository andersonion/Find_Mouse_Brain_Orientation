#! /bin/sh 
#### created by Devon Overson, Nov 2024, email at devonko@gmail.com
# qsub -l h_vmem=64G predict_orientation.sh
#$ -cwd
#$ -o $JOB_NAME.$JOB_ID.out
#$ -j y
#$ -m ea
#$ -q users.q
#$ -wd /log/output/dir/
#$ -M email@email.com

#### use case: qsub -l h_vmem=64G predict_orientation.sh M22090514_dwi_mask_OF_prepped_AIL.nii.gz
# export SAMBA_APPS_DIR=/set/to/parent/directory/of/repo # Uncomment and edit if this system variable isn't already set.
mask=$1
exam=${mask##*/};
exam=${exam%%mask*}
exam=${exam%_}
parent_path=~/ 
tmp=${parent_path}/fmbo_${exam}_tmp
script_dir=${SAMBA_APPS_DIR}/Find_Mouse_Brain_Orientation/modeling
source activate ${SAMBA_APPS_DIR}/Find_Mouse_Brain_Orientation/fmbo_env
echo "script_dir = ${script_dir}"
echo "Writing tmp directory..."
mkdir ${tmp}
cp -r ${script_dir}/* ${tmp}/
sed "s/#exam_id = ###input_exam###/exam_id = [\"$exam\"]/g" ${script_dir}/tf_orientation_template.py > ${tmp}/tf_orientation_temp.py
python ${tmp}/tf_orientation_temp.py ${mask}
#echo "Cleaning tmp directory..."
#rm -r  ${tmp}




