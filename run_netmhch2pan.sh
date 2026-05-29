#!/bin/bash

# 1. Setup Directories and Files
allele_file="hla_ref_set.class_ii.txt"
fasta_dir="output/pepfiles"
# Use a consistent path. Ensure this folder exists or is writable.
output_dir="output/netmhciipan_results"

# 2. Prerequisites
if [[ ! -f "$allele_file" ]]; then
  echo "Error: Allele file $allele_file not found!"
  exit 1
fi

if [[ ! -d "$fasta_dir" ]]; then
  echo "Error: Directory $fasta_dir not found!"
  exit 1
fi

mkdir -p "$output_dir"

# 3. Resource Allocation
total_cores=$(nproc)
# Using 50% of cores to avoid memory bottlenecking with netMHCIIpan
max_parallel_jobs=$((total_cores / 2))
[[ $max_parallel_jobs -lt 1 ]] && max_parallel_jobs=1

# 4. Processing Function
process_file() {
  local fasta_file="$1"
  local allele="$2"
  
  export NETMHCIIpan="/home/user/netMHCIIpan-4.0"
  export TMPDIR="/tmp"

  local base_name=$(basename "$fasta_file" | cut -f 1 -d '.')
  local output_xls="$output_dir/${base_name}_${allele}.xls"
  local output_txt="$output_dir/${base_name}_${allele}.txt"

  # Force the "SUBMITTING" message to print to stderr so it bypasses buffering
  echo "[SUBMITTING] Job: $base_name | Allele: $allele" >&2

  # Redirect perl output to the text file
  perl "$NETMHCIIpan/NetMHCIIpan-4.0.pl" \
    -a "$allele" \
    -f "$fasta_file" \
    -inptype 0 \
    -context 1 \
    -filter 1 \
    -rankF 2 \
    -s 1 \
    -xls 1 \
    -xlsfile "$output_xls" > "$output_txt" 2>&1

  # Final status update
  if [[ -f "$output_xls" && -s "$output_xls" ]]; then
      echo "[SUCCESS] Finished: $base_name | Allele: $allele" >&2
  else
      echo "[ERROR] Failed: $base_name | Allele: $allele (Check $output_txt)" >&2
  fi
}

export -f process_file
export output_dir NETMHCIIpan

# 5. Execute in Parallel
# We use ::: (files) :::: (alleles) to create a Cartesian product (every file x every allele)
fasta_files=("$fasta_dir"/*.fasta)

parallel --jobs "$max_parallel_jobs" --eta --progress \
  process_file {1} {2} ::: "${fasta_files[@]}" :::: "$allele_file"
