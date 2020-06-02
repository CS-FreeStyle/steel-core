#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Jun 02 18:59:45 -03 2020
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto b8561a63f69e41d98a2e12d383a11daf --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_store_unit_behav xil_defaultlib.tb_store_unit xil_defaultlib.glbl -log elaborate.log"
xelab -wto b8561a63f69e41d98a2e12d383a11daf --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_store_unit_behav xil_defaultlib.tb_store_unit xil_defaultlib.glbl -log elaborate.log
