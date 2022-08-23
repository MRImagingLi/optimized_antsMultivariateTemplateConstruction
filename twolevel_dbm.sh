#!/bin/bash

# Created by argbash-init v2.10.0
# ARG_HELP([DBM post-processing for twolevel_modelbuild.sh from optimized_antsMultivariateTemplateConstruction])
# ARG_OPTIONAL_SINGLE([output-dir],[],[Output directory for modelbuild],[output])
# ARG_OPTIONAL_SINGLE([jacobian-smooth],[],[Comma separated list of smoothing gaussian FWHM, append "vox" for voxels, "mm" for millimeters],[4vox])
# ARG_OPTIONAL_SINGLE([walltime],[],[Walltime for short running stages (averaging, resampling)],[00:15:00])
# ARG_OPTIONAL_BOOLEAN([debug],[],[Debug mode, print all commands to stdout],[])
# ARG_OPTIONAL_BOOLEAN([dry-run],[],[Dry run, don't run any commands, implies debug],[])
# ARG_POSITIONAL_SINGLE([inputs],[Input text files, one line per subject, comma separated scans per subject],[])
# ARG_LEFTOVERS([Arguments to be passed to dbm.sh without validation])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}


begins_with_short_option()
{
  local first_option all_short_options='h'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_leftovers=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_output_dir="output"
_arg_jacobian_smooth="4vox"
_arg_walltime="00:15:00"
_arg_debug="off"
_arg_dry_run="off"


print_help()
{
  printf '%s\n' "DBM post-processing for twolevel_modelbuild.sh from optimized_antsMultivariateTemplateConstruction"
  printf 'Usage: %s [-h|--help] [--output-dir <arg>] [--jacobian-smooth <arg>] [--walltime <arg>] [--(no-)debug] [--(no-)dry-run] <inputs> ... \n' "$0"
  printf '\t%s\n' "<inputs>: Input text files, one line per subject, comma separated scans per subject"
  printf '\t%s\n' "... : Arguments to be passed to dbm.sh without validation"
  printf '\t%s\n' "-h, --help: Prints help"
  printf '\t%s\n' "--output-dir: Output directory for modelbuild (default: 'output')"
  printf '\t%s\n' "--jacobian-smooth: Comma separated list of smoothing gaussian FWHM, append \"vox\" for voxels, \"mm\" for millimeters (default: '4vox')"
  printf '\t%s\n' "--walltime: Walltime for short running stages (averaging, resampling) (default: '00:15:00')"
  printf '\t%s\n' "--debug, --no-debug: Debug mode, print all commands to stdout (off by default)"
  printf '\t%s\n' "--dry-run, --no-dry-run: Dry run, don't run any commands, implies debug (off by default)"
}


parse_commandline()
{
  _positionals_count=0
  while test $# -gt 0
  do
    _key="$1"
    case "$_key" in
      -h|--help)
        print_help
        exit 0
        ;;
      -h*)
        print_help
        exit 0
        ;;
      --output-dir)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_output_dir="$2"
        shift
        ;;
      --output-dir=*)
        _arg_output_dir="${_key##--output-dir=}"
        ;;
      --jacobian-smooth)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_jacobian_smooth="$2"
        shift
        ;;
      --jacobian-smooth=*)
        _arg_jacobian_smooth="${_key##--jacobian-smooth=}"
        ;;
      --walltime)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_walltime="$2"
        shift
        ;;
      --walltime=*)
        _arg_walltime="${_key##--walltime=}"
        ;;
      --no-debug|--debug)
        _arg_debug="on"
        test "${1:0:5}" = "--no-" && _arg_debug="off"
        ;;
      --no-dry-run|--dry-run)
        _arg_dry_run="on"
        test "${1:0:5}" = "--no-" && _arg_dry_run="off"
        ;;
      *)
        _last_positional="$1"
        _positionals+=("$_last_positional")
        _positionals_count=$((_positionals_count + 1))
        ;;
    esac
    shift
  done
}


handle_passed_args_count()
{
  local _required_args_string="'inputs'"
  test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
}


assign_positional_args()
{
  local _positional_name _shift_for=$1
  _positional_names="_arg_inputs "
  _our_args=$((${#_positionals[@]} - 1))
  for ((ii = 0; ii < _our_args; ii++))
  do
    _positional_names="$_positional_names _arg_leftovers[$((ii + 0))]"
  done

  shift "$_shift_for"
  for _positional_name in ${_positional_names}
  do
    test $# -gt 0 || break
    eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
    shift
  done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

set -uo pipefail
set -eE -o functrace

# shellcheck source=helpers.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname "${BASH_SOURCE[${__b3bp_tmp_source_idx:-0}]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[${__b3bp_tmp_source_idx:-0}]}")"
__base="$(basename "${__file}" .sh)"
# shellcheck disable=SC2034,SC2015
__invocation="$(printf %q "${__file}")$( (($#)) && printf ' %q' "$@" || true)"

if [[ ${_arg_debug} == "off" ]]; then
  unset _arg_debug
fi

# Setup a directory which contains all commands run
# for this invocation
mkdir -p ${_arg_output_dir}/secondlevel/jobs/${__datetime}

# Store the full command line for each run
echo ${__invocation} >${_arg_output_dir}/secondlevel/jobs/${__datetime}/invocation

while read -r file; do
  if [[ ! -s ${file} ]]; then
    failure "Input file ${file} does not exist"
  fi
done <  ${_arg_output_dir}/secondlevel/input_files.txt

# Process Second Level DBM
info "Processing between-subject DBM outputs"
debug "${__dir}/dbm.sh ${_arg_debug:+--debug} ${_arg_leftovers[@]+"${_arg_leftovers[@]}"} --jobname-prefix "dbm_twolevel_${__datetime}_" --output-dir ${_arg_output_dir}/secondlevel ${_arg_output_dir}/secondlevel/input_files.txt"
if [[ ${_arg_dry_run} == "off" ]]; then
  ${__dir}/dbm.sh ${_arg_debug:+--debug} ${_arg_leftovers[@]+"${_arg_leftovers[@]}"} --jobname-prefix "dbm_twolevel_${__datetime}_" --output-dir ${_arg_output_dir}/secondlevel ${_arg_output_dir}/secondlevel/input_files.txt
fi
mkdir -p ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/{full,relative}/smooth
mkdir -p ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/{full,relative}/smooth

# Convert smoothing jacobians to a list
IFS=',' read -r -a _arg_jacobian_smooth_list <<<${_arg_jacobian_smooth}


info "Processing within-subject DBM outputs"
i=1
while read -r subject_scans; do

  IFS=',' read -r -a scans <<<${subject_scans}
  if [[ $(wc -l < ${_arg_output_dir}/firstlevel/subject_${i}/input_files.txt) -gt 1 ]]; then
    debug "${__dir}/dbm.sh ${_arg_debug:+--debug} ${_arg_leftovers[@]+"${_arg_leftovers[@]}"} --jobname-prefix "dbm_twolevel_${__datetime}_subject_${i}_" --jacobian-smooth "${_arg_jacobian_smooth}" --output-dir ${_arg_output_dir}/firstlevel/subject_${i} ${_arg_output_dir}/firstlevel/subject_${i}/input_files.txt"
    if [[ ${_arg_dry_run} == "off" ]]; then
      ${__dir}/dbm.sh ${_arg_debug:+--debug} ${_arg_leftovers[@]+"${_arg_leftovers[@]}"} --jobname-prefix "dbm_twolevel_${__datetime}_subject_${i}_" --jacobian-smooth "${_arg_jacobian_smooth}" --output-dir ${_arg_output_dir}/firstlevel/subject_${i} ${_arg_output_dir}/firstlevel/subject_${i}/input_files.txt
    fi

    for scan in "${scans[@]}"; do
      info "Generating resampled jacobians"
      # Resample within-subject into common space
      if [[ ! -s ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz ]]; then
        echo "antsApplyTransforms -d 3 --verbose \
          -r ${_arg_output_dir}/secondlevel/final/average/template_sharpen_shapeupdate.nii.gz \
          -i ${_arg_output_dir}/firstlevel/subject_${i}/dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz \
          -t ${_arg_output_dir}/secondlevel/final/transforms/subject_${i}_1Warp.nii.gz \
          -t ${_arg_output_dir}/secondlevel/final/transforms/subject_${i}_0GenericAffine.mat \
          -o ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz"
      fi
      if [[ ! -s ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz ]]; then
        echo "antsApplyTransforms -d 3 --verbose \
          -r ${_arg_output_dir}/secondlevel/final/average/template_sharpen_shapeupdate.nii.gz \
          -i ${_arg_output_dir}/firstlevel/subject_${i}/dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz \
          -t ${_arg_output_dir}/secondlevel/final/transforms/subject_${i}_1Warp.nii.gz \
          -t ${_arg_output_dir}/secondlevel/final/transforms/subject_${i}_0GenericAffine.mat \
          -o ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz"
      fi
    done >>${_arg_output_dir}/secondlevel/jobs/${__datetime}/resample_jacobian

    for scan in "${scans[@]}"; do
      info "Generating overall jacobians"
      # Generate Overall Jacobians
      if [[ ! -s ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz ]]; then
        echo "ImageMath 3 ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz + \
          ${_arg_output_dir}/secondlevel/dbm/jacobian/full/subject_${i}.nii.gz \
          ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz"
      fi
      if [[ ! -s ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz ]]; then
        echo "ImageMath 3 ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz + \
          ${_arg_output_dir}/secondlevel/dbm/jacobian/relative/subject_${i}.nii.gz \
          ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz"
      fi
    done >>${_arg_output_dir}/secondlevel/jobs/${__datetime}/overall_jacobian

    for scan in "${scans[@]}"; do
      # Smooth jacobians files
      info "Smoothing Jacobians"
      for fwhm in "${_arg_jacobian_smooth_list[@]}"; do
        sigma_num=$(calc "$(echo ${fwhm} | grep -o -E '^[0-9]+')/(2*sqrt(2*log(2)))")
        if [[ ${fwhm} =~ [0-9]+mm$ ]]; then
          fwhm_type=1
        elif [[ ${fwhm} =~ [0-9]+vox$ ]]; then
          fwhm_type=0
        else
          failure "Parse error for FWHM entry \"${fwhm}\", must end with vox or mm"
        fi
        if [[ ! -s ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/full/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ]]; then
          echo "SmoothImage 3 \
            ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz \
            ${sigma_num} \
            ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/full/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ${fwhm_type} 0"
        fi
        if [[ ! -s ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/relative/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ]]; then
          echo "SmoothImage 3 \
            ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz \
            ${sigma_num} \
            ${_arg_output_dir}/secondlevel/resampled-dbm/jacobian/relative/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ${fwhm_type} 0"
        fi
        if [[ ! -s ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/full/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ]]; then
          echo "SmoothImage 3 \
            ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/full/$(basename ${scan} | extension_strip).nii.gz \
            ${sigma_num} \
            ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/full/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ${fwhm_type} 0"
        fi
        if [[ ! -s ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/relative/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ]]; then
          echo "SmoothImage 3 \
            ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/relative/$(basename ${scan} | extension_strip).nii.gz \
            ${sigma_num} \
            ${_arg_output_dir}/secondlevel/overall-dbm/jacobian/relative/smooth/$(basename ${scan} | extension_strip)_fwhm_${fwhm}.nii.gz ${fwhm_type} 0"
        fi
      done
    done >>${_arg_output_dir}/secondlevel/jobs/${__datetime}/smooth_jacobian

  else
    info "Subject ${i} has only a single file, "${scans[@]}", and does not have a subject wise average, it will only have second-level cross sectional DBM"
  fi

  debug "$(cat ${_arg_output_dir}/secondlevel/jobs/${__datetime}/resample_jacobian)"
  if [[ ${_arg_dry_run} == "off" ]]; then
    qbatch --logdir ${_arg_output_dir}/secondlevel/logs/${__datetime} \
      --walltime ${_arg_walltime} \
      -N dbm_twolevel_${__datetime}_resample_jacobian \
      --depend "dbm_twolevel_${__datetime}*" \
      ${_arg_output_dir}/secondlevel/jobs/${__datetime}/resample_jacobian
  fi

  debug "$(cat ${_arg_output_dir}/secondlevel/jobs/${__datetime}/overall_jacobian)"
  if [[ ${_arg_dry_run} == "off" ]]; then
    qbatch --logdir ${_arg_output_dir}/secondlevel/logs/${__datetime} \
      --walltime ${_arg_walltime} \
      -N dbm_twolevel_${__datetime}_overall_jacobian \
      --depend "dbm_twolevel_${__datetime}_resample_jacobian" \
      ${_arg_output_dir}/secondlevel/jobs/${__datetime}/overall_jacobian
  fi

  debug "$(cat ${_arg_output_dir}/secondlevel/jobs/${__datetime}/smooth_jacobian)"
  if [[ ${_arg_dry_run} == "off" ]]; then
    qbatch --logdir ${_arg_output_dir}/secondlevel/logs/${__datetime} \
      --walltime ${_arg_walltime} \
      -N dbm_twolevel_${__datetime}_smooth_jacobian \
      --depend "dbm_twolevel_${__datetime}*" \
      --depend "dbm_twolevel_${__datetime}_resample_jacobian" \
      --depend "dbm_twolevel_${__datetime}_overall_jacobian" \
      ${_arg_output_dir}/secondlevel/jobs/${__datetime}/smooth_jacobian
  fi

  ((++i))
done < ${_arg_inputs}

# ] <-- needed because of Argbash
