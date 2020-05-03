#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sun May 03 17:21:52 -03 2020
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim tb_machine_mode_behav -key {Behavioral:sim_1:Functional:tb_machine_mode} -tclbatch tb_machine_mode.tcl -log simulate.log"
xsim tb_machine_mode_behav -key {Behavioral:sim_1:Functional:tb_machine_mode} -tclbatch tb_machine_mode.tcl -log simulate.log
