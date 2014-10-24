#!/bin/bash
# Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
#   Jeff Larkin
# USAGE: Add between aprun options and executable
# For Example: aprun -n 16 -N 1 ./foo arg1 arg2
# Becomes: aprun -n 16 -N 1 ./nvprof_metrics.sh ./foo arg1 arg2

# Give each *node* a separate file
LOG=metrics_$RUNID.nvp

# Stripe each profile file by 1 to share the load on large runs
lfs setstripe -c 1 $LOG

# Execute the provided command.
exec nvprof --analysis-metrics -o $LOG $*
